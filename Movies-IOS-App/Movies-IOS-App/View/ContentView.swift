//
//  ContentView.swift
//  Movies-IOS-App
//
//  Created by Sohail Binanzala on 13/09/24.
//


import SwiftUI
import Kingfisher

struct ContentView: View {
    var columns: [GridItem] { Array(repeating: GridItem(spacing: 10), count: 2)}
    
    @EnvironmentObject var moviesViewModel: MoviesViewModel
    @State private var show: Bool = false
    @State private var searchText: String = ""
    @State var movelist = ["Avengers","Don", "Adventure","Fantasy", "Horror","Comedy" ]
    @State var selectedIndex:Int = 0
    
    var body: some View {
        NavigationStack {
            movieType
            VStack {
                // Search Bar
                TextField("Search movies", text: $searchText)
                    .padding(.horizontal)
                    .frame(height: 40)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(moviesViewModel.filteredMovies(searchText: searchText), id: \.id) { movieData in
                            Button {
                                show = true
                                moviesViewModel.id = movieData.imdbID ?? ""
                            } label: {
                                VStack {
                                    ZStack {
                                        KFImage(URL(string: movieData.poster ?? ""))
                                            .resizable()
                                            .frame(width: 180, height: 225)
                                            .scaledToFill()
                                    }
                                    .clipped()
                                    .aspectRatio(1, contentMode: .fill)
                                    .clipShape(Rectangle())
                                    
                                    Text(movieData.title ?? "")
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                }
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                            }
                        }
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
            }
            .background(.white)
            .navigationTitle("Movies")
            .navigationDestination(isPresented: $show, destination: {
                MoviewDetailsView()
            })
            .onAppear {
                moviesViewModel.movieLIst()
            }
        }
    }
    
    
    var movieType:some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing: 15){
                ForEach(0..<movelist.count,id: (\.self)) { index in
                    Button {
                        moviesViewModel.type = movelist[index]
                        selectedIndex = index
                        moviesViewModel.movieLIst()
                        print("type == \( moviesViewModel.type)")
                    } label: {
                        HStack{
                            Text(movelist[index])
                                .font(.footnote)
                                .foregroundColor(.black)
                                .frame( height: 30, alignment: .center)

                        }
                        .padding(.leading,15)
                        .padding(.trailing,15)
                        .padding(.top,5)
                        .padding(.bottom,5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                        .shadow(radius: 0.6)
                        .animation(.easeOut, value: 2)
                        .background(selectedIndex == index ? .yellow :.white)

                    }

                }
            }.padding(.leading,10)
        }    .padding(.top,10)
    }
}

