//
//  MoviesDataModel.swift
//  Movies-IOS-App
//
//  Created by Sohail Binanzala on 16/09/24.
//

import Foundation


// MARK: - MoviesDataModel
struct MoviesDataModel: Codable,Identifiable {
    let id = UUID()
    var search: [Search]?
    var totalResults, response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Search: Codable,Identifiable {
    let id = UUID()
    var title, year, imdbID: String?
    var type: TypeEnum?
    var poster: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
}





// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let moviesDataModel = try? JSONDecoder().decode(MoviesDataModel.self, from: jsonData)

