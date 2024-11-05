//
//  MixtapeDetailView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/20/24.
//
//  TODO: ADD LYRIC-SAVING CAROUSEL
//

import SwiftUI
import Combine

struct MixtapeDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var nBar: NBar
    
    @State var showingDeleteAlert = false
    @State var editNavigationReady = false
    
    @State var mixtape: Tape
    @State var uiCover: UIImage = UIImage(named: "no_select")!
    var emitter = PassthroughSubject<ExpandCollapseState, Never>()
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ScrollView {
                    // header image
                    VStack {
                        GeometryReader { gr in
                            //                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                            Image(uiImage: uiCover)
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
                                            
                                            var delM = mixtape
                                            mixtape = Tape.empty
                                            
                                            modelContext.delete(delM)
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
                        VStack(alignment:.leading) {
                            // date
                            Text(mixtape.date, style:.date)
                                .font(.footnote)
                                .padding([.leading, .trailing])
                            
                            // title
                            Text(mixtape.heading)
                                .font(.title)
                                .bold()
                                .padding([.leading, .trailing, .bottom])

                            // body text
                            Text(mixtape.body)
                                .padding([.leading, .trailing])
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
                                Spacer()
                                Button(action: {
                                    emitter.send(ExpandCollapseState(true))
                                }) {
                                    Image(systemName: "rectangle.expand.vertical")
                                        .font(.title3)
                                        .foregroundStyle(.black)
                                }
                                .padding(.trailing, 5)
                                Button(action: {
                                    emitter.send(ExpandCollapseState(false))
                                }) {
                                    Image(systemName: "rectangle.compress.vertical")
                                        .font(.title3)
                                        .foregroundStyle(.black)
                                }
//                                Menu {
//                                    Button(action: {
//                                        emitter.send(ExpandCollapseState(true))
//                                    }) {
//                                        Label("Expand all", systemImage: "rectangle.expand.vertical")
//                                    }
//                                    Button(action: {
//                                        emitter.send(ExpandCollapseState(false))
//                                    }) {
//                                        Label("Collapse all", systemImage: "rectangle.compress.vertical")
//                                    }
//                                } label: {
//                                    Image(systemName: "ellipsis")
//                                        .font(.title)
//                                        .foregroundStyle(.black)
//                                }
                            }
                            .padding([.leading, .trailing])
                            
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
                            TracksView(tracks: $mixtape.songs, event: emitter.eraseToAnyPublisher())
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
                        EditMixtapeView(mixtape: $mixtape).toolbar(.hidden, for: .tabBar)
                    })
                }
//                .scrollClipDisabled()
//                .edgesIgnoringSafeArea(.all)
            }
           
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            self.uiCover = UIImage(data: mixtape.cover)!
        })
    }
}

/**
 A class to represent when the user executes an 'expand all' or 'collapse all' action.
 
 # Properties: #
 `state`\
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - `true` represents an 'expand all' action, `false` represents a 'collapse all' action.
 */
class ExpandCollapseState {
    
    var state: Bool
    
    init(_ state: Bool) {
        self.state = state
    }
}

//#Preview {
//    MixtapeDetailView(mixtape: Tape.sample_tapes[1])
//}
