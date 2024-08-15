//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Aasem Hany on 30/04/2024.
//

import UIKit

class FavoritesListVC: UIViewController {

    let tableView = UITableView()
    var favorites = [Follower]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getFavorites() {
        UserDefaultsManger.retrieveFavorites { [weak self] result in
            guard let self else{ return }
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No Favorites")
                }else{
                    DispatchQueue.main.async {
                        self.favorites = favorites
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let failure):
                self.presentGFAlertVCOnMainThread(title: "Something went wrong", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseId)
    }

}


extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseId) as? FavoritesCell else{
            return UITableViewCell()
        }
        favoriteCell.set(favorite: favorites[indexPath.row])
        return favoriteCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let followerListVC = FollowersListVC(username: favorite.login, networkManager: NetworkManagerImpl())
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        UserDefaultsManger.updateFavoritesAfterRemoving(favorite) { [weak self] error in
            guard let self else {return}
            guard let error else {return}
            DispatchQueue.main.async {
                self.favorites.append(favorite)
                self.tableView.insertRows(at: [indexPath], with: .left)
            }
            self.presentGFAlertVCOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")

            
        }
        
    }
    
}
