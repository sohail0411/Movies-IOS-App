//
//  Movies_IOS_AppApp.swift
//  Movies-IOS-App
//
//  Created by Sohail Binanzala on 13/09/24.
//

import SwiftUI

@main
struct Movies_IOS_AppApp: App {
    @ObservedObject var data = MoviesViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.environmentObject(data)
    }
}
