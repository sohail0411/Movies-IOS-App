//
//  HttpUtility.swift
//  Movies-IOS-App
//
//  Created by Sohail Binanzala on 16/09/24.
//

import Foundation

enum httpError : Error {
    case jsonDecoding
    case noData
    case nonSuccessStatusCode
    case serverError
    case emptyCollection
    case emptyObject
}





final class HttpUtility {
    
    static let shared: HttpUtility = HttpUtility()
    private init() {}
    
    func featchData(type:String) async throws -> MoviesDataModel? {
        let url = URL(string: "https://www.omdbapi.com/?apikey=45cd9fa8&type=movie&s=\(type)")!
        
        let (serverData, serverUrlResponse) =  try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MoviesDataModel.self, from: serverData)
    }
    
    func movieDetails(id:String) async throws-> MoviesDetailsModel? {
        let url = URL(string: "https://www.omdbapi.com/?apikey=45cd9fa8&type=movie&i=\(id)")!
        let (data,serverUrlResponse) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MoviesDetailsModel.self, from: data)
        
    }
}
