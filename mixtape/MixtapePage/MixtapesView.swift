//
//  ContentView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/17/24.
//

import SwiftUI
import SwiftData

struct MixtapesView: View {
    
//    @EnvironmentObject var nBar: NBar
//    @Environment(\.dismissSearch) private var dismissSearch
    @Query private var mixtapes: [Tape]
    //let mixtapes: [Tape] = Tape.sample_tapes
    @State private var searchText = ""
//    @Binding var userProfile: User
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                VStack(spacing:0) {
                    ScrollView(showsIndicators: false) {
                        if (mixtapes.count > 0) {
                            ForEach(getMixtapes()) {tape in
                                NavigationLink(destination: MixtapeDetailView(mixtape: tape).toolbar(.hidden, for: .tabBar), label: {
                                    TapeCardView(tape:tape)
                                        .padding(5)
                                })
                            }
                            .navigationTitle("My Mixtapes")
//                            .searchable(text: $searchText)
                            
                            if (getMixtapes().count == 0) {
                                VStack {
                                    Text("You may need to re-tune your radio 📻.")
                                        .foregroundStyle(Color(UIColor.systemGray2))
                                        .multilineTextAlignment(.center)
                                        .padding(.bottom)
                                    Text("We couldn't find any mixtapes matching your search.")
                                        .foregroundStyle(Color(UIColor.systemGray2))
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.top, 50)
                                .padding([.leading, .trailing], 40)
                            }
                        } else {
                            VStack {
                                Text("No mixtapes yet")
                                    .navigationTitle("My Mixtapes")
                                    .font(.title)
                                    .bold()
                                NavigationLink(destination: NewMixtapeView().toolbar(.hidden, for: .tabBar)) {
                                    Text(" Create your first mixtape")
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding([.top], 160)
                        }
//                        Spacer()
//                            .padding(.bottom, 80)
                        
//                        Spacer()
//                        Spacer()
                    }
                    //NavbarView()
                }
                /*
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
                */
                
            }
            .background(Color(UIColor.systemGray6))
//            .onAppear(perform: {nBar.isShowing = true})
            //.edgesIgnoringSafeArea(.bottom)
            //.background(Theme.secondary_accent_color)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: NewMixtapeView().toolbar(.hidden, for: .tabBar)) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    func getMixtapes() -> [Tape] {
        if searchText == "" {
            return mixtapes.sorted(by: {$0.date > $1.date})
        } else {
            return mixtapes.sorted(by: {$0.date > $1.date}).filter{$0.title.lowercased().contains(searchText.lowercased()) || $0.date.formatted(date:.long, time:.omitted).lowercased().contains(searchText.lowercased())}
        }
    }
}

/*
 //PART OF FAILED SEARCH IMPLEMENTATION
struct TapeCardNav: View {
    
    @Environment(\.dismissSearch) private var dismissSearch
    var tape: Tape
    @State private var detailNavReady = false
    
    var body: some View {
        Button(action: {
            dismissSearch()
            detailNavReady = true
        }) {
            TapeCardView(tape:tape)
                .padding(5)
        }
        .navigationDestination(isPresented: $detailNavReady, destination: {
            MixtapeDetailView(mixtape: tape).toolbar(.hidden, for: .tabBar)
        })
    }
}
 */

//struct MixtapesViewPreviews: PreviewProvider {
//    static var previews: some View {
//        MixtapesView()
//    }
//}
