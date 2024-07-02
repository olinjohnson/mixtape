//
//  NavbarView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/20/24.
//

import SwiftUI

/*
 HStack {
     VStack {
         Image(systemName: "book.closed")
             .font(.title)
         Text("Notebook")
             .font(.footnote)
     }
     .tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 1")/*@END_MENU_TOKEN@*/ }.tag(1)
     Spacer()
     VStack {
         Image(systemName: "music.note.house")
             .font(.title)
         Text("Home")
             .font(.footnote)
     }
     Spacer()
     VStack {
         Image(systemName: "recordingtape")
             .font(.title)
         Text("Mixtapes")
             .font(.footnote)
     }
 }
 //.padding(20)
 .padding()
 .padding(.leading, 20)
 .padding(.trailing, 20)
 .padding(.bottom)
 .background(.white)
 //.frame(width: Theme.nav_width, height:70)
 //.cornerRadius(12)
 .shadow(color: .black.opacity(0.1), radius: 10, y: -2)
 */

/*
 AboutView()
     .tabItem {
         Label("About", systemImage:"info.circle.fill")
     }
     .tag(3)
 */

struct NavbarView: View {
    
    @State private var selection = 0
    
    @Binding var isAuthenticated: Bool
    @Binding var userProfile: User
    
    @StateObject var nBar: NBar = NBar()
    
    /*var body: some View {
        TabView(selection:$selection) {
            AccountView(isAuthenticated: $isAuthenticated, userProfile: $userProfile)
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
                .tag(0)
            JournalView()
                .tabItem {
                    Label("Journal", systemImage: "book.closed")
                }
                .tag(1)
            MixtapesView(userProfile: $userProfile)
                .tabItem {
                    Label("Mixtapes", systemImage: "recordingtape")
                }
                .tag(2)
        }
        .edgesIgnoringSafeArea(.bottom)
//        .overlay(
//            VStack {
//                Spacer()
//                PlayerView()
//                    .padding([.leading, .trailing], 5)
//                    //.offset(y:-geo.size.height)
//            }
//            .offset(y:-50)
//        )
//
//            VStack {
//                Spacer()
//                PlayerView()
//                    .padding([.leading, .trailing], 5)
//            }
    }*/
    
    var body: some View {
        VStack(spacing:0) {
            if selection == 0 {
                AccountView(isAuthenticated: $isAuthenticated, userProfile: $userProfile)
            } else if selection == 1 {
                JournalView()
            } else {
                MixtapesView(userProfile: $userProfile)
            }
            if nBar.isShowing {
                VStack(spacing:0) {
                    PlayerView()
                        .padding([.leading, .trailing], 5)
                    HStack(alignment:.bottom) {
                        
                        VStack(alignment:.center) {
                            Image(systemName: "person.crop.circle")
                                .font(.title2)
                                .padding(.bottom, 1)
                            Text("Account")
                                .font(.caption)
                                .bold()
                        }
                        .onTapGesture {
                            selection = 0
                        }
                        .foregroundStyle(selection == 0 ? .blue : .gray)
                        Spacer()
                        VStack(alignment:.center) {
                            Image(systemName: "book.closed.fill")
                                .font(.title2)
                                .padding(.bottom, 1)
                            Text("Journal")
                                .font(.caption2)
                                .bold()
                        }
                        .onTapGesture {
                            selection = 1
                        }
                        .foregroundStyle(selection == 1 ? .blue : .gray)
                        Spacer()
                        VStack(alignment:.center) {
                            Image(systemName: "recordingtape")
                                .font(.title)
                                .padding(.bottom, 2)
                            Text("Mixtapes")
                                .font(.caption2)
                                .bold()
                        }
                        .onTapGesture {
                            selection = 2
                        }
                        .foregroundStyle(selection == 2 ? .blue : .gray)
                        
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 30)
                    .padding([.leading, .trailing], 40)
                }
                .padding(0)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .environmentObject(nBar)
//        .overlay(
//            VStack {
//                Spacer()
//                PlayerView()
//                    .padding([.leading, .trailing], 5)
//                    //.offset(y:-geo.size.height)
//            }
//            .offset(y:-50)
//        )
    }
}

class NBar: ObservableObject {
    @Published var isShowing: Bool = true
}

//struct NavbarView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavbarView()
//    }
//}
