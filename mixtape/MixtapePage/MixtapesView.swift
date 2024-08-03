//
//  ContentView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/17/24.
//

import SwiftUI
import SwiftData

struct MixtapesView: View {
    
    @EnvironmentObject var nBar: NBar
    
    @Query private var mixtapes: [Tape]
    //let mixtapes: [Tape] = Tape.sample_tapes
    @State private var searchText = ""
    
//    @Binding var userProfile: User
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                VStack(spacing:0) {
                    ScrollView(showsIndicators: false) {
//                    #TODO: add date on mixtape cards
                        ForEach(mixtapes.sorted(by: {$0.date < $1.date}).reversed()) {tape in
                            NavigationLink(destination: MixtapeDetailView(mixtape: tape)) {
                                TapeCardView(tape:tape)
                                    .padding(5)
                            }
                        }
                        .navigationTitle("My Mixtapes")
                        //.searchable(text: $searchText)
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
//                        Spacer()
//                        Spacer()
                    }
                    //NavbarView()
                }
                NavigationLink(destination: NewMixtapeView()) {
                    VStack {
                        Text("+")
                            .font(.title2)
//                            .font(.title3)
                            .bold()
                        //.foregroundColor(.white)
                        //.background(Theme.accent_color)
                            .foregroundColor(.black)
                    }
                    .frame(width:50, height:50)
                    .background(.white)
                    .cornerRadius(100)
                    .padding([.leading, .trailing], 10)
                }
                .shadow(color: .black.opacity(0.2), radius: 10, x: 2, y: 2)
                .offset(x: -16, y:-30)
                
            }
            .onAppear(perform: {nBar.isShowing = true})
            //.edgesIgnoringSafeArea(.bottom)
            //.background(Theme.secondary_accent_color)
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct MixtapesViewPreviews: PreviewProvider {
//    static var previews: some View {
//        MixtapesView()
//    }
//}
