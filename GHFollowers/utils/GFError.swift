//
//  GFError.swift
//  GHFollowers
//
//  Created b y Aasem Hany on 15/05/2024.
//

import Foundation

enum GFError: String, Error{
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "An error occurred. Please check your internet connection!"
    case invalidResponse = "Invalid response. Please try again!"
    case invalidData = "Invalid retrieved data. Please try again later"
}
