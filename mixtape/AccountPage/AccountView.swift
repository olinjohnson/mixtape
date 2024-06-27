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
    
    @StateObject var spotifyController: SpotifyController = SpotifyController()
    
    @State var spotifyAuthorized: Bool = false
    
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
                
                if !spotifyAuthorized {
                    Button(action:{
                        if !spotifyController.appRemote.isConnected {
                            spotifyController.authorize()
                            spotifyAuthorized = true
                        }
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
                } else {
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
                    .border(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)), width:4)
                    .cornerRadius(10)
                }
                
                Button(action:{
                    
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
            spotifyController.setAccessToken(from: url)
        }
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
//                            spotifyController.connect()
//                        })
        .environmentObject(spotifyController)
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
