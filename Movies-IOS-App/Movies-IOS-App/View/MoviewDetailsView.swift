
//
//  ContentView.swift
//  Movies-IOS-App
//
//  Created by Sohail Binanzala on 13/09/24.
//

import SwiftUI
import Kingfisher
struct MoviewDetailsView: View {
    @ObservedObject var moviesDetailsVM = MoviesDetailsViewModel()
    @EnvironmentObject var moviesViewModel:MoviesViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .top){
            VStack {
                ScrollView(.vertical){
                    VStack{
                        HStack{
                            Text("\(moviesDetailsVM.moviesDetailsModel.runtime ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                            Text("\(moviesDetailsVM.moviesDetailsModel.rated ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                            Text("\(moviesDetailsVM.moviesDetailsModel.released ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                            Spacer()
                        }.padding(.leading,30)
                        
                        ZStack{
                            KFImage(URL(string: moviesDetailsVM.moviesDetailsModel.poster ?? ""))
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width - 50, height: 150,alignment: .top) // Adjusting height to match aspect ratio
                        }
                        .clipped()
                        .aspectRatio(1, contentMode: .fill)
                        .clipShape(Rectangle())
                        .background(.white)
                        .shadow(radius: 0.5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                        
                        HStack{
                            Spacer().frame(width: 15)
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)   // Set the foreground color
                                .frame(width: 20,height: 20)
                            
                            Text("\(moviesDetailsVM.moviesDetailsModel.imdbRating ?? "") / 10")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                            
                            Text("\(formatVotes(moviesDetailsVM.moviesDetailsModel.imdbVotes ?? "0")) votes")
                                .font(.subheadline)
                                .foregroundColor(.black)
                            
                            
                            Spacer().frame(width: 15)
                            
                        }.frame( width: UIScreen.main.bounds.width - 50 ,height: 35, alignment: .leading)
                            .background(.white)
                            .shadow(radius: 0.2)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.yellow, lineWidth: 2))
                            .padding(.leading,10)
                        
                        
                        VStack(spacing: 5){
                            Text("Director:")
                                .font(.system(size: 16)).bold()
                                .foregroundColor(.black)
                                .frame( width: UIScreen.main.bounds.width/1.2, alignment: .leading)
                            
                            
                            Text("\(moviesDetailsVM.moviesDetailsModel.director ?? "")")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .frame( width: UIScreen.main.bounds.width/1.2, alignment: .leading)
                            
                            
                            
                            
                            Text("Writers:")
                                .font(.system(size: 16)).bold()
                                .foregroundColor(.black)
                                .frame( width: UIScreen.main.bounds.width/1.2, alignment: .leading)
                            
                            Text("\(moviesDetailsVM.moviesDetailsModel.writer ?? "")")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .frame( width: UIScreen.main.bounds.width/1.2, alignment: .leading)
                            
                            
                            
                            
                            Text("Stars:")
                                .font(.system(size: 16)).bold()
                                .foregroundColor(.black)
                                .frame( width: UIScreen.main.bounds.width/1.2, alignment: .leading)
                            
                            Text("\(moviesDetailsVM.moviesDetailsModel.actors ?? "")")
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .frame( width: UIScreen.main.bounds.width/1.2,alignment: .leading)
                            
                        }
                        
                        
                        Spacer()
                    }.padding(.top,5)
                }
                .onAppear(perform: {
                    print("id------------------ \(moviesViewModel.id)")
                    moviesDetailsVM.featchMovieDetails(id: moviesViewModel.id)
                })
                
            }.navigationBarBackButtonHidden(true)
            .padding(.top,60)

            
            HStack{
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    
                    Image(systemName: "arrowshape.backward.circle.fill")
                        .resizable()
                        .frame(width: 25,height: 25)
                        .foregroundColor(.black)
                }
                
                Text(moviesDetailsVM.moviesDetailsModel.title ?? "")
                    .font(.system(size: 18).bold())
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame( width: UIScreen.main.bounds.width/1.2,alignment: .leading)
                
            }
            .padding(.top,20)
        }

            
        
    }
    
    // Helper function using NumberFormatter for K/M formatting
    func formatVotes(_ votes: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        if let votesNumber = Double(votes.replacingOccurrences(of: ",", with: "")) {
            if votesNumber >= 1_000_000 {
                return "\(formatter.string(from: NSNumber(value: votesNumber / 1_000_000)) ?? "")M"
            } else if votesNumber >= 1_000 {
                return "\(formatter.string(from: NSNumber(value: votesNumber / 1_000)) ?? "")K"
            } else {
                return "\(formatter.string(from: NSNumber(value: votesNumber)) ?? "")"
            }
        }
        return votes
    }
}





