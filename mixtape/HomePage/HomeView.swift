//
//  HomeView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/23/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Home")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    Button(action:{}) {
                        Text("hi")
                    }
                }
                .padding()
                Spacer()
                //NavbarView()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    HomeView()
}
