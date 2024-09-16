//
//  MoviesViewModel.swift
//  Movies-IOS-App
//
//  Created by Sohail Binanzala on 16/09/24.
//

import Foundation

class MoviesViewModel:ObservableObject {
    
    @Published var moviesDataModel = MoviesDataModel()
    @Published var id :String = ""
    @Published var type :String = "Avengers"

    
    func filteredMovies(searchText: String) -> [Search] {
         guard !searchText.isEmpty else {
             return moviesDataModel.search ?? []
         }
         return (moviesDataModel.search ?? []).filter { movie in
             movie.title?.lowercased().contains(searchText.lowercased()) ?? false
         }
     }
    func movieLIst()   {
        Task {
            do {
                let data = try await HttpUtility.shared.featchData(type: type) ?? MoviesDataModel()
                
                DispatchQueue.main.async {
                    self.moviesDataModel =  data
                    print(self.moviesDataModel)
                }
                
            }catch{
            }
            
        }
        
    }
    
}
