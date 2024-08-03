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
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var nBar: NBar
    
    @State var showingDeleteAlert = false
    @State var editNavigationReady = false
    
    @State var mixtape: Tape
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ScrollView {
                    // header image
                    VStack {
                        GeometryReader { gr in
                            //                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                            Image(uiImage: UIImage(data: mixtape.cover)!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: gr.size.width, height: gr.size.height + max(0, gr.frame(in: .global).origin.y), alignment:.center)
                                .clipped()
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
                            HStack {
                                NavigationLink(destination: MixtapesView()) {
                                    NavBackView(dismiss: self.dismiss)
                                }
                                Spacer()
                                Menu {
                                    Button(action:{editNavigationReady = true}) {
                                        Label("Edit mixtape", systemImage: "pencil")
                                    }
                                    Button(role: .destructive, action:{showingDeleteAlert = true}) {
                                        Label("Delete mixtape", systemImage: "trash")
                                    }
                                } label: {
                                    Text(Image(systemName: "ellipsis"))
                                        .font(.system(size: 16))
                                        .bold()
                                        .padding(10)
                                        .foregroundColor(.white)
                                        .frame(minWidth:40, minHeight:40)
                                        .background(.gray.opacity(0.5))
                                        .cornerRadius(14)
                                        .padding(40)
                                }
                                .alert(isPresented:$showingDeleteAlert) {
                                    Alert(
                                        title:Text("Are you sure you want to delete this mixtape?"),
                                        message:Text("This operation cannot be undone."),
                                        primaryButton: .destructive(Text("I'm sure")) {
                                            modelContext.delete(mixtape)
                                            do { try modelContext.save() } catch {}
                                            dismiss()
                                        },
                                        secondaryButton: .cancel(Text("No, go back"))
                                    )
                                }
                                
                            }
                            .offset(y: -gr.frame(in: .global).origin.y + 20)
                            //                        }
                        }
                        .frame(height:350)
                        
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
                            .padding(.bottom, 40)
                            
//                            Spacer()
                            //Divider()
//                            Spacer()
//                                .padding(.top, 5)
                            
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
                            
                            Spacer()
                        }
                        .padding()
//                        .edgesIgnoringSafeArea(.bottom)
                        .frame(minHeight: reader.size.height - 350 + reader.frame(in: .global).origin.y)
                        .background(.white)
//                        .padding([.leading, .trailing, .top])
//                        .background(.white)
                    }
                    .padding(.bottom)
                    .navigationDestination(isPresented: $editNavigationReady, destination: {
                        EditMixtapeView(mixtape: $mixtape)
                    })
                }
//                .edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    MixtapeDetailView(mixtape: Tape.sample_tapes[1])
//}
