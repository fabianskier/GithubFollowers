//
//  GFError.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-24.
//

import Foundation

enum GFErrorMessage: String {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Pleas try again."
}
