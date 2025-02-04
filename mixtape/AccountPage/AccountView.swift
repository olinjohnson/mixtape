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
    @EnvironmentObject var appleMusicController: AppleMusicController
    
    @Binding var isAuthenticated: Bool
    @Binding var userProfile: User
    
    @State var showingFAQ = false
    @State var showingPP = false
    @State var showingAcknowledgements = false
    
    let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    
    var body: some View {
        NavigationStack {
            List {
                
                /*
                 
                 IMPORTANT USER PROFILE SECTION
                Section {
                    HStack {
                        AsyncImage(url: URL(string: userProfile.picture)) {image in
                            image.resizable()
                        } placeholder: {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .foregroundStyle(Color(UIColor.systemGray4))
                        }
                        .scaledToFit()
                        .frame(width:75)
                        .clipShape(Circle())
                        .padding(.trailing)
                        
                        VStack(alignment:.leading) {
                            Text(userProfile.name)
                                .font(.headline)
                            Text(userProfile.email)
                                .font(.subheadline)
                                .foregroundStyle(Color(UIColor.systemGray))
                        }
                        Spacer()
//                        Button(action: {}) {
//                            Image(systemName: "chevron.right")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height:20)
//                                .foregroundStyle(Color(UIColor.systemGray4))
//                        }
                    }
                }
                 */
                
                Section {
                    //                .padding(.top, 5)
//                    HStack {
//                        iconView(systemName: "bell.fill", color:.red)
//                            .padding(.trailing, 5)
//                        Text("Notifications")
//                    }
                    Button(action: {showingFAQ = true}) {
                        HStack {
                            iconView(systemName: "bubble.left.and.bubble.right.fill", color:.yellow)
                                .padding(.trailing, 5)
                            Text("Frequently Asked Questions")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(height:15)
                                .foregroundStyle(Color(UIColor.systemGray3))
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $showingFAQ, content: {
                        FAQView()
                    })
                    
                    Button(action: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }) {
                        HStack {
                            iconView(systemName: "gearshape.fill", color:.indigo)
                                .padding(.trailing, 5)
                            Text("Permissions")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(height:15)
                                .foregroundStyle(Color(UIColor.systemGray3))
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    //                .padding(.bottom, 5)
                }
                
                Section {
                    if !spotifyController.isAuthorized && !appleMusicController.isAuthorized {
                
                        Button(action: {
                            Task {
                                await appleMusicController.requestMusicAuthorization()
                            }
                        }) {
                            HStack {
                                Image("apple_music_icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height:30)
                                    .padding(.trailing, 5)
                                Text("Connect to Apple Music")
//                                    .foregroundStyle(Color(UIColor(red: 255/255, green: 55/255, blue: 95/255, alpha: 1)))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height:15)
                                    .foregroundStyle(Color(UIColor.systemGray3))
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        
                        Button(action: {
//                            spotifyController.authorize()
                        }) {
                            HStack {
                                Image("spotify_icon_green")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height:30)
                                    .padding(.trailing, 5)
                                    .grayscale(0.9995)
                                    .opacity(0.6)
                                Text("Connect to Spotify")
                                    .foregroundStyle(Color(UIColor.systemGray))
                                //                            .foregroundStyle(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                                Spacer()
//                                Image(systemName: "chevron.right")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(height:15)
//                                    .foregroundStyle(Color(UIColor.systemGray3))
                            }
                            .contentShape(Rectangle())
                        }
//                        .buttonStyle(.plain)
                        .listRowBackground(Color(UIColor.systemGray5))
                        //                    .padding(.top, 5)
                        
                        HStack {
                            VStack {
                                Image("tidal")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                            }
                            .frame(width:30, height:30)
                            .background(.black)
                            .cornerRadius(5)
                            .padding(.trailing, 5)
                            .grayscale(0.9995)
                            .opacity(0.6)
                            
                            Text("Connect to Tidal")
                                .foregroundStyle(Color(UIColor.systemGray))
                            //                            .foregroundStyle(Color(UIColor(red: 255/255, green: 55/255, blue: 95/255, alpha: 1)))
                        }
                        .listRowBackground(Color(UIColor.systemGray5))
                        
                        HStack {
                            VStack {
                                Image("deezer")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                            }
                            .frame(width:30, height:30)
                            .background(Color(UIColor(red: 152/255, green: 49/255, blue: 255/255, alpha: 1)))
                            .cornerRadius(5)
                            .padding(.trailing, 5)
                            .grayscale(0.9995)
                            .opacity(0.6)
                            
                            Text("Connect to Deezer")
                                .foregroundStyle(Color(UIColor.systemGray))
                            //                            .foregroundStyle(Color(UIColor(red: 255/255, green: 55/255, blue: 95/255, alpha: 1)))
                        }
                        .listRowBackground(Color(UIColor.systemGray5))
                        //                    .padding(.bottom, 5)
                    } else {
                        
                        if spotifyController.isAuthorized {
                            
                            Button(action: {
                                spotifyController.deauthorize()
                            }) {
                                HStack {
                                    Image("spotify_icon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height:30)
                                        .padding(.trailing, 5)
                                    Text("Disconnect from Spotify")
                                        .foregroundStyle(.white)
                                        .bold()
                                    //                            .foregroundStyle(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height:15)
                                        .foregroundStyle(.white)
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .listRowBackground(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                            
                        } else if appleMusicController.isAuthorized {
                            
                            Button(action: {
                                appleMusicController.deauthorize()
                            }) {
                                HStack {
                                    Image("apple_music_icon_light")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height:30)
                                        .padding(.trailing, 5)
                                    Text("Disconnect from Apple Music")
                                        .foregroundStyle(.white)
                                        .bold()
                                    //                            .foregroundStyle(Color(UIColor(red: 30/255, green: 215/255, blue: 96/255, alpha: 1)))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height:15)
                                        .foregroundStyle(.white)
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .listRowBackground(Color(UIColor(red: 255/255, green: 55/255, blue: 95/255, alpha: 1)))
                        }
                        
                    }
                } header: {
                    Text("Integrations")
                } footer: {
                    if !spotifyController.isAuthorized && !appleMusicController.isAuthorized {
                        Text("Integrations with Spotify, Tidal, and Deezer are currently under development. These features will be available in future updates.")
                    }
                }
                
                Section {
                    Button(action: {
                        UIApplication.shared.open(URL(string:"mailto:feedback@themixtapeapp.com?subject=Feedback")!)
                    }) {
                        HStack {
                            iconView(systemName: "text.bubble.fill", color:.green)
                                .padding(.trailing, 5)
                            Text("Provide Feedback")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(height:15)
                                .foregroundStyle(Color(UIColor.systemGray3))
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
//                    .padding(.top, 5)
                    Button(action: {
                        UIApplication.shared.open(URL(string:"mailto:bugreport@themixtapeapp.com?subject=Bug Report&body=Please describe the bug and give detailed steps to reproduce:\n")!)
                    }) {
                        HStack {
                            iconView(systemName: "ant.fill", color:.gray)
                                .padding(.trailing, 5)
                            Text("Report a Bug")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(height:15)
                                .foregroundStyle(Color(UIColor.systemGray3))
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    
                    Button(action:{showingAcknowledgements=true}) {
                        HStack {
                            iconView(systemName: "heart.fill", color:.pink)
                                .padding(.trailing, 5)
                            Text("Acknowledgements")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(height:15)
                                .foregroundStyle(Color(UIColor.systemGray3))
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $showingAcknowledgements, content: {
                        AcknowledgementsView()
                    })
//                    .padding(.bottom, 5)
                } header: {
                    Text("Support Mixtape")
                } footer: {
                    Text("Mixtape is [open source](https://github.com/resources/articles/software-development/what-is-open-source-software) and relies on open source software. [Check out its ongoing development.](https://github.com/olinjohnson/mixtape)")
                }
                
                Section {
                    /*
                    HStack {
                        iconView(systemName: "doc.text.fill", color:.gray)
                            .padding(.trailing, 5)
                        Text("Terms of Service")
                    }
                     */
                    Button(action: {showingPP = true}) {
                        HStack {
                            iconView(systemName: "lock.doc.fill", color:.blue)
                                .padding(.trailing, 5)
                            Text("Privacy Policy")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(height:15)
                                .foregroundStyle(Color(UIColor.systemGray3))
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $showingPP, content: {
                        PrivacyPolicyView()
                    })
                } header: {
                    Text("Legal")
                }
                
                Section {
                    
                    /*
                     
                     IMPORTANT LOGOUT BUTTON
                    Button(action: {
                        logout()
                    }) {
                        HStack {
                            iconView(systemName: "lock.fill", color:.red)
                                .padding(.trailing, 5)
                            Text("Log Out")
                                .foregroundStyle(.white)
                                .bold()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(height:15)
                                .foregroundStyle(.white)
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.red)
                     
                     */
                    
                    /*
                    Button(action: {
                        // TODO: CALL AUTH0 DELETE FUNCTION
                        // TODO: ALERT BEFORE ACCOUNT DELETE
                    }) {
                        HStack {
                            Spacer()
                            Text("Delete Account")
                                .foregroundStyle(.white)
                                .bold()
//                            iconView(systemName: "trash.fill", color:.red)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    .listRowBackground(Color.red)
                     */
                } footer: {
                    HStack{
                        Spacer()
                        VStack {
                            Image("maine")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:100)
                                .opacity(0.5)
                            (
                            Text("Made with ")
                                .font(.caption)
                                .foregroundStyle(Color(UIColor.systemGray))
                            + Text(Image(systemName: "heart.fill"))
                                .font(.caption)
                                .foregroundStyle(Color.red)
                            + Text(" from Maine")
                                .font(.caption)
                                .foregroundStyle(Color(UIColor.systemGray))
                            )
                        }
                        Spacer()
                    }
//                    .padding(.top, 30)
                }
            }
            .navigationTitle("Settings")
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
//            TODO: DO NOT DELETE THIS!
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
        if spotifyController.isAuthorized { spotifyController.deauthorize() }
        if appleMusicController.isAuthorized { appleMusicController.deauthorize() }
        
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                    case .failure(let error):
                        print("Failed with \(error)")
                    case .success:
                        let _ = credentialsManager.clear()
                        self.userProfile = User.empty
                        self.isAuthenticated = false
                }
            }
    }
}

//#Preview {
//    AccountView()
//}
