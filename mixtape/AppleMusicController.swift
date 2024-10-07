//
//  AppleMusicController.swift
//  mixtape
//
//  Created by Olin Johnson on 10/6/24.
//

import Foundation
import SwiftUI
import KeychainAccess
import Combine
import MusicKit

class AppleMusicController: ObservableObject {
    
    init() {
        
        if let authStatusData = keychain[data: Self.authManagerKey] {
            do {
                let authStatus = try JSONDecoder().decode(
                    Bool.self,
                    from: authStatusData
                )
                self.isAuthorized = authStatus
                
            } catch {
                print("Error decoding authStatus from keychain data")
            }
        }
        
    }
    
    static let authManagerKey = "appleMusicAuthManager"
    private let keychain = Keychain(service: "Apple Music")
    
    @Published var isAuthorized = false
    
    func requestMusicAuthorization() async {
        let status = await MusicAuthorization.request()
        
        switch status {
        case .authorized:
            self.isAuthorized = true
            self.saveAuthStatus()
        default:
            print("Error connecting to apple music - status: ", status)
        }
    }
    
    func deauthorize() {
        self.isAuthorized = false
        self.removeAuthStatus()
    }
    
    func saveAuthStatus() {
        do {
            let authStatusData = try JSONEncoder().encode(self.isAuthorized)
            keychain[data:Self.authManagerKey] = authStatusData
        } catch {
            print("Error encoding authStatus data to keychain")
        }
    }

    func removeAuthStatus() {
        do {
            try keychain.remove(Self.authManagerKey)
        } catch {
            print("Error removing authStatus from keychain")
        }
    }
    
}
