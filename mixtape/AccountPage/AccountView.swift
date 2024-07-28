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
    
    @EnvironmentObject var spotifyController: SpotifyController
    
    @Binding var isAuthenticated: Bool
    @Binding var userProfile: User
    
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
//                AsyncImage(url: URL(string: userProfile.picture)) {image in
//                    image.frame(maxWidth:160)
//                } placeholder: {
//                    Image(systemName: "person.crop.circle")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width:160)
//                }
                Text(userProfile.name)
                    .font(.title)
                
                if !userProfile.name.elementsEqual(userProfile.email) {
                    Text(userProfile.email)
                        .font(.subheadline)
                }
                
                Spacer()
                
                if !spotifyController.isAuthorized {
                    Button(action:{
                        spotifyController.authorize()
                    }) {
                        HStack {
                            Text("Connect to Spotify")
                            Image("spotify_icon_white")
                                .resizable()
                                .scaledToFit()
                        }
                        .font(.title2)
                        .bold()
                        .frame(maxWidth:.infinity, minHeight: 50, maxHeight: 50)
                        .background(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
//                    .buttonStyle(.plain)
                    Button(action:{
                        print("apple music functionality not implemented yet")
                    }) {
                        HStack {
                            Text("Connect to Apple Music")
    //                        Image("spotify_icon")
    //                            .resizable()
    //                            .scaledToFit()
                        }
                        .font(.title2)
                        .bold()
                        .frame(maxWidth:.infinity, minHeight: 50, maxHeight: 50)
                        .background(Color(UIColor(red: 255/255, green: 55/255, blue: 95/255, alpha: 1)))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                } else {
                    VStack {
                        HStack {
                            Text("Connected to Spotify")
                            Image("spotify_icon_green")
                                .resizable()
                                .scaledToFit()
                        }
                        .font(.title2)
                        .bold()
                        .frame(maxWidth:.infinity, minHeight: 50, maxHeight: 50)
                        .background(.white)
                        .foregroundColor(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)), lineWidth: 2))
                        
                        HStack{
                            VStack{
                                Divider()
                                    .background(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                                    .frame(height:1)
                                    .overlay(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                                    .padding([.leading, .trailing], 15)
                            }
                            Button(action:{
                                spotifyController.deauthorize()
                            }) {
                                Text("Disconnect?")
                                    .foregroundColor(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
    //                                .fontWeight(.heavy)
                            }
                            VStack{
                                Divider()
                                    .background(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                                    .frame(height:1)
                                    .overlay(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                                    .padding([.leading, .trailing], 15)
                            }
                        }
                        .padding(.top, 10)
                    }
                }
                
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
        .onOpenURL { url in
            spotifyController.setAuthTokens(url)
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
