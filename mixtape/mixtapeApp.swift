//
//  mixtapeApp.swift
//  mixtape
//
//  Created by Olin Johnson on 2/17/24.
//

import SwiftUI
import SwiftData

@main
struct mixtapeApp: App {
    
    @State var isAuthenticated = false
    @State var userProfile = User.empty
    
    @StateObject var spotifyController = SpotifyController()
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                NavbarView(isAuthenticated: $isAuthenticated, userProfile: $userProfile)
            } else {
                LoginView(isAuthenticated: $isAuthenticated, userProfile: $userProfile)
            }
        }
        .modelContainer(for: Entry.self)
    }
}
