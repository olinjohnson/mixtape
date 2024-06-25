//
//  AccountView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/24/24.
//

import SwiftUI
import Auth0

/*
 HStack {
     Text("Home")
         .font(.largeTitle)
         .bold()
     Spacer()
 }
 */


struct AccountView: View {
    
    @Binding var isAuthenticated: Bool
    @Binding var userProfile: User
    
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                AsyncImage(url: URL(string: userProfile.picture)) {image in
                    image.frame(maxWidth:160)
                } placeholder: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width:160)
                }
                Text(userProfile.name)
                    .font(.title)
                Text(userProfile.email)
                    .font(.subheadline)
                Spacer()
                Button(action:{
                    logout()
                }) {
                    Text("Log out")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth:.infinity, minHeight: 50)
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Account")
        }
    }
}

extension AccountView {
    private func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                    case .failure(let error):
                        print("Failed with \(error)")
                    case .success:
                        self.userProfile = User.empty
                        self.isAuthenticated = false
                }
            }
    }
}

//#Preview {
//    AccountView()
//}
