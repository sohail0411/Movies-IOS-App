//
//  MoviesDetailsViewModel.swift
//  Movies-IOS-App
//
//  Created by Sohail Binanzala on 16/09/24.
//

import Foundation


class MoviesDetailsViewModel:ObservableObject{
    @Published var moviesDetailsModel = MoviesDetailsModel()
    
    func featchMovieDetails(id:String){
        Task{
            do{
                let data = try await HttpUtility.shared.movieDetails(id: id)
                DispatchQueue.main.async {
                    self.moviesDetailsModel = data ?? MoviesDetailsModel()
                    print(self.moviesDetailsModel)
                    
                }
            }
            catch{
                
            }
        }
    }
    
}





