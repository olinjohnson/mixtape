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
    
    var body: some View {
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
            MixtapesView()
                .tabItem {
                    Label("Mixtapes", systemImage: "recordingtape")
                }
                .tag(2)
        }
    }
}

//struct NavbarView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavbarView()
//    }
//}
