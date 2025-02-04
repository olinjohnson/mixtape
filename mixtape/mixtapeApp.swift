//
//  mixtapeApp.swift
//  mixtape
//
//  Created by Olin Johnson on 2/17/24.
//

import SwiftUI
import SwiftData
import Auth0

@main
struct mixtapeApp: App {
    
    @State var isAuthenticated = true
    @State var userProfile = User.empty
    
    let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    
    var body: some Scene {
        WindowGroup {
            VStack {
                NavbarView(isAuthenticated: $isAuthenticated, userProfile: $userProfile)
//                if self.isAuthenticated {//credentialsManager.hasValid() {
//                    NavbarView(isAuthenticated: $isAuthenticated, userProfile: $userProfile)
//                } else {
//                    LoginView(login: self.login)
//                }
            }
            .onAppear(perform: {
                if credentialsManager.hasValid() {
                    
                    credentialsManager.credentials { result in
                        switch result {
                            case .success(let credentials):
                                self.userProfile = User.from(credentials.idToken)
                            case .failure(_):
                                return
                        }
                    }
                    
                    self.isAuthenticated = true
                }
            })
        }
        .modelContainer(for: [Entry.self, Tape.self])
    }
}

extension mixtapeApp {
    private func login(_ parameters: [String : String]) {
        
        Auth0
            .webAuth()
            .parameters(parameters)
            .start { result in
                switch result {
                    case .failure(let error):
                        print("Failed with \(error)")
                    case .success(let credentials):
                        let _ = credentialsManager.store(credentials: credentials)
                        self.userProfile = User.from(credentials.idToken)
                        self.isAuthenticated = true
                }
            }
    }
}
