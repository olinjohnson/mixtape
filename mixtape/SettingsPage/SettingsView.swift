//
//  SettingsView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/23/24.
//

import SwiftUI
import Auth0

struct SettingsView: View {
    
    @State var isAuthenticated = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(alignment: .center) {
                    HStack {
                        Text("Home")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    
                    Button(action:{}) {
                        Text("Create an account")
                            .font(.title2)
                            .bold()
                    }
                    .frame(maxWidth:.infinity, minHeight: 50)
                    .background(Color(UIColor.systemGray3))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button(action:{
                        login()
                    }) {
                        Text("Log in")
                            .font(.title2)
                            .bold()
                    }
                    .frame(maxWidth:.infinity, minHeight: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

extension SettingsView {
    
    private func login() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                    case .failure(let error):
                        print("Failed with \(error)")
                    case .success(let credentials):
                        self.isAuthenticated = true
                        print("Credentials: \(credentials)")
                }
            }
    }
    
    private func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                    case .failure(let error):
                        print("Failed with \(error)")
                    case .success:
                        self.isAuthenticated = false
                }
            }
    }
    
}

#Preview {
    SettingsView()
}
