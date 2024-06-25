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
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                NavbarView(isAuthenticated: $isAuthenticated)
            } else {
                LoginView(isAuthenticated: $isAuthenticated)
            }
        }
        .modelContainer(for: Entry.self)
    }
}
