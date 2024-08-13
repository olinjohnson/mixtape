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
            List {
                HStack {
                    iconView(systemName: "person.fill", color:.blue)
                        .padding(.trailing, 5)
                    Text("Profile")
                }
                .padding(.top, 5)
                HStack {
                    iconView(systemName: "bell.fill", color:.red)
                        .padding(.trailing, 5)
                    Text("Notifications")
                }
                HStack {
                    iconView(systemName: "bubble.left.and.bubble.right.fill", color:.yellow)
                        .padding(.trailing, 5)
                    Text("Frequently Asked Questions")
                }
                .padding(.bottom, 5)
                
                Section {
                    HStack {
                        Image("spotify_icon_green")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:30)
                            .padding(.trailing, 5)
                        Text("Connect to Spotify")
//                            .foregroundStyle(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                    }
                    .padding(.top, 5)
                    HStack {
                        Image("apple_music_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:30)
                            .padding(.trailing, 5)
                        Text("Connect to Apple Music")
//                            .foregroundStyle(Color(UIColor(red: 255/255, green: 55/255, blue: 95/255, alpha: 1)))
                    }
                    .padding(.bottom, 5)
                } header: {
                    Text("Integrations")
                } footer: {
                }
                
                Section {
                    HStack {
                        iconView(systemName: "text.bubble.fill", color:.green)
                            .padding(.trailing, 5)
                        Text("Provide Feedback")
                    }
                    .padding(.top, 5)
                    HStack {
                        iconView(systemName: "ant.fill", color:.gray)
                            .padding(.trailing, 5)
                        Text("Report a Bug")
                    }
                    .padding(.bottom, 5)
                } header: {
                    Text("Support Mixtape")
                } footer: {
                    HStack{
                        Spacer()
                        VStack {
                            Image("maine")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:100)
                            (
                            Text("Made with ")
                                .font(.caption)
                                .foregroundStyle(.black)
                            + Text(Image(systemName: "heart.fill"))
                                .font(.caption)
                                .foregroundStyle(.red)
                            + Text(" from Maine")
                                .font(.caption)
                                .foregroundStyle(.black)
                            )
                        }
                        Spacer()
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Account")
            /*
             HStack {
                 Text("Made with ")
                     .font(.caption)
                 +
                 Text(Image(systemName: "heart.fill"))
                     .font(.caption)
                     .foregroundStyle(.red)
                 +
                 Text(" from Maine")
                     .font(.caption)
                 Image("maine")
                     .resizable()
                     .aspectRatio(contentMode: .fit)
                     .frame(height:15)
             }
             */
/*
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
//                    Button(action:{
//                        print("apple music functionality not implemented yet")
//                    }) {
//                        HStack {
//                            Text("Connect to Apple Music")
//    //                        Image("spotify_icon")
//    //                            .resizable()
//    //                            .scaledToFit()
//                        }
//                        .font(.title2)
//                        .bold()
//                        .frame(maxWidth:.infinity, minHeight: 50, maxHeight: 50)
//                        .background(Color(UIColor(red: 255/255, green: 55/255, blue: 95/255, alpha: 1)))
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                    }
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
 */
        }
        .onOpenURL { url in
            spotifyController.setAuthTokens(url)
        }
    }
}

struct iconView: View {
    var systemName: String
    var color: Color
    
    var body: some View {
        VStack {
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.white)
                .padding(5)
        }
        .frame(width:30, height:30)
        .background(color)
        .cornerRadius(5)
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
