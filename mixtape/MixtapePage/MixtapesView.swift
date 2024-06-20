//
//  ContentView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/17/24.
//

import SwiftUI

struct MixtapesView: View {
    let mixtapes: [Tape] = Tape.sample_tapes
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                VStack(spacing:0) {
                    ScrollView(showsIndicators: false) {
                        ForEach(mixtapes, id: \.id) {tape in
                            NavigationLink(destination:MixtapeDetailView(mixtape: tape).toolbar(.hidden, for: .tabBar)) {
                                TapeCardView(tape:tape)
                                    .padding(5)
                            }
                        }
                        .navigationTitle("My Mixtapes")
                        .searchable(text: $searchText)
                        /*(
                            Text("Made with ")
                                .font(.caption)
                            +
                            Text(Image(systemName: "heart.fill"))
                                .font(.caption)
                                .foregroundStyle(Theme.accent_color)
                            +
                            Text(" from Maine \(Image(systemName: "mappin.and.ellipse"))")
                                .font(.caption)
                        )*/
                        Spacer()
                        Spacer()
                    }
                    //NavbarView()
                }
                NavigationLink(destination: NewMixtapeView().toolbar(.hidden, for: .tabBar)) {
                    Text("+ NEW")
                        //.font(.title2)
                        .font(.title3)
                        .bold()
                        .padding(10)
                        //.foregroundColor(.white)
                        //.background(Theme.accent_color)
                        .foregroundColor(.black)
                        .background(.white)
                        .cornerRadius(10)
                }
                .shadow(color: .black.opacity(0.4), radius: 10, x: 2, y: 2)
                .offset(x: -16, y:-30)
                
            }
            //.edgesIgnoringSafeArea(.bottom)
            //.background(Theme.secondary_accent_color)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MixtapesViewPreviews: PreviewProvider {
    static var previews: some View {
        MixtapesView()
    }
}
