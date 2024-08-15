//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Aasem Hany on 03/05/2024.
//

import UIKit

class FollowersListVC: UIViewController {

    enum Section { case main }
    
    var username: String!
    let networkManager: NetworkManager!
    var followers = [Follower]()
    var filteredFollowers = [Follower]()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    init(username: String!, networkManager: NetworkManager!) {
        self.username = username
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getFollowers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        title = username
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavorites))
    }
    
    @objc private func addToFavorites(){
        self.showLoadingView()
        networkManager.getUserInfo(for: username) { [weak self] result in
            guard let self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                UserDefaultsManger.updateFavoritesAfterAdding(Follower(login: user.login, avatarUrl: user.avatarUrl)) { [weak self] error in
                    guard let self else { return }
                    if let error  {
                        self.presentGFAlertVCOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
                        return
                    }
                    self.presentGFAlertVCOnMainThread(title: "Success!", message: "User added successfully to favorites🥳", buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentGFAlertVCOnMainThread(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a user name"
        navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        // make the collection takes all the available space of the view using view.bounds
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self

        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        // register the sell and reuse identifier to the collection view
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView){
            collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        }
    }
    
    private func updateData(with followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    private func getFollowers() {
        self.showLoadingView()
        networkManager.getFollowers(for: username, page: page){ [weak self] (result)  in
            guard let self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "User does not have any followers!")
                    }
                    return
                }
                self.updateData(with: self.followers)
                
            case .failure(let failure):
                self.presentGFAlertVCOnMainThread(title: "Something went wrong", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    deinit { print("Deallocated") }
}


extension FollowersListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasMoreFollowers else { return }
        
        let yOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let viewportHeight = scrollView.frame.size.height
        
        if yOffset > contentHeight - viewportHeight {
            page += 1
            getFollowers()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = isSearching ? filteredFollowers[indexPath.item] : followers[indexPath.item]
        let userInfoVc = UserInfoVC(userName: follower.login, networkManager: NetworkManagerImpl())
        userInfoVc.delegate = self
        let navController = UINavigationController(rootViewController: userInfoVc)
        
        // presents the UIViewController Modally
        present(navController, animated: true)
    }
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            //We added updateData() here to retrieve our unfiltered followers when the user remove all the search characters inside search bar
            updateData(with: followers)
            isSearching = false
            return
        }
        isSearching = true
        
        filteredFollowers = followers.filter{ $0.login.lowercased().contains(filter.lowercased()) }
        updateData(with: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(with: followers)
    }

}


extension FollowersListVC: UserInfoVCDelegate{
    
    func didTapGetFollowers(_ userInfoVC: UserInfoVC, for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers()
    }
    
}
