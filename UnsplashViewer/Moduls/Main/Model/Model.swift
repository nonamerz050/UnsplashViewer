//
//  Model.swift
//  UnsplashViewer
//
//  Created by MacBook Pro on 4/11/21.
//

import Foundation

struct PhotoElement: Identifiable, Decodable {
    var id: String
    var date: String?
    var urls: Urls
    var user: User
}

struct Urls: Decodable {
    let small: String
}

struct User: Decodable {
    let name: String?
}
