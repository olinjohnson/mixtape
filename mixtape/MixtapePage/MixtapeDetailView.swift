//
//  MixtapeDetailView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/20/24.
//
//  TODO: ADD LYRIC-SAVING CAROUSEL
//

import SwiftUI

struct MixtapeDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var nBar: NBar
    let mixtape: Tape
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // header image
                VStack {
                    GeometryReader { gr in
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                            mixtape.cover
                                .resizable()
                                .scaledToFill()
                                .frame(width: gr.size.width, height: gr.size.height + max(0, gr.frame(in: .global).origin.y), alignment:.center)
//                                .clipped()
                                .overlay {
                                    HStack {
                                        VStack {
                                            Spacer()
                                            Text(mixtape.title)
                                                .foregroundStyle(.white)
                                                .font(.largeTitle)
                                                .bold()
                                                .padding(20)
                                                .padding([.leading, .trailing], 6)
                                                .multilineTextAlignment(.leading)
                                                .shadow(color:.black.opacity(0.2), radius:3, x:0, y:0)
                                        }
                                        Spacer()
                                    }
                                }
                                .offset(y: -gr.frame(in: .global).origin.y)

//                            NavigationLink(destination: MixtapesView().toolbar(.hidden, for: .tabBar)) {
//                                NavBackView(dismiss:self.dismiss)
//                            }
                            NavBackView(dismiss: self.dismiss)
                            .offset(y: -gr.frame(in: .global).origin.y + 20)
                        }
                    }
                    .frame(height:400)
                    
                    // Info stack
                    VStack {
                        // date
                        HStack {
                            Text(mixtape.date, style:.date)
                                .font(.footnote)
                                .padding([.leading, .trailing])
                            Spacer()
                        }
                        
                        // title
                        HStack {
                            Text(mixtape.heading)
                                .font(.title)
                                .bold()
                                .padding([.leading, .trailing, .bottom])
                            Spacer()
                        }
                        
                        // body text
                        HStack {
                            Text(mixtape.body)
                                .padding([.leading, .trailing])
                            Spacer()
                        }
                        .padding(.bottom)
                        
                        Spacer()
                        //Divider()
                        Spacer()
                            .padding(.top, 5)
                        
                        // track title
                        HStack {
                            Text("Tracks")
                                .font(.title3)
                                .bold()
                                .padding([.leading, .trailing])
                            Spacer()
                        }
                        
                        // track list
                        /*
                        VStack(spacing:0){
                            SongView(song: mixtape.songs[0])
                                .padding([.leading, .trailing])
                            ForEach(mixtape.songs.dropFirst()) { song in
                                LazyVStack(spacing:0) {
                                    Divider()
                                        .padding([.leading, .trailing])
                                    SongView(song: song)
                                }
                                .padding([.leading, .trailing])
                            }
                        }*/
                        TracksView(tracks: mixtape.songs)
                    }
                    .padding([.leading, .trailing, .top])
                    .background(.white)
                }
                .padding(.bottom)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    MixtapeDetailView(mixtape: Tape.sample_tapes[1])
//}
