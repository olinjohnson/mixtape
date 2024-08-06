//
//  TracksSelectorView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/3/24.
//

import SwiftUI

struct TracksSelectorView: View {
    
    @EnvironmentObject var spotifyController: SpotifyController
    @Binding var tracks: [Song]
    
    @State private var showingConnectAlert = false
    @State private var showingSearchTrackPopover = false
    
    var body: some View {
        VStack(alignment:.leading, spacing:5) {
//            if(tracks.count == 0) {
//                VStack(alignment:.leading) {
//                    Text("No tracks yet")
//                        .bold()
//                }
//                .padding(.bottom, 7)
//                .padding(.top, 2)
            if (tracks.count != 0) {
                ForEach(tracks.sorted(by: {$0.order < $1.order})) { track in
                    HStack(alignment:.center) {
                        TrackView(track: track)
                        
                        Button(action: {
                            withAnimation {
                                track.order += 1.5
                            }
                            self.resetTrackOrder()
                        }) {
                            Image(systemName: "arrow.down.circle.fill")
                                .foregroundStyle(Color(uiColor: UIColor.systemGray3))
                        }
                        
                        Button(action: {
                            withAnimation {
                                track.order -= 1.5
                            }
                            self.resetTrackOrder()
                        }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundStyle(Color(uiColor: UIColor.systemGray3))
                        }
                        .padding([.leading, .trailing], 5)
                        
                        Button(action: {
                            withAnimation {
                                tracks.removeAll(where: { tr in
                                    track.order == tr.order
                                })
                            }
                            self.resetTrackOrder()
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundStyle(.red)
                        }
                        
                    }

                    if (track.order < Double(tracks.count) - 1) {
                        Divider()
                            .padding(.leading, 60)
                    }
                }
                Divider()
                    .padding(.leading, 60)
                    .padding(.bottom, 10)
            }
                //.padding([.top, .bottom], 5)
            Button(action: {
                if spotifyController.isAuthorized {
                    showingSearchTrackPopover = true
                } else {
                    showingConnectAlert = true
                }
            }) {
                HStack {
                    Image(systemName: "plus")
                        .bold()
                    Text("Add tracks")
                        .bold()
                    Spacer()
                }
            }
            .alert(isPresented:$showingConnectAlert) {
                Alert(
                    title:Text("Connect to Spotify to add tracks."),
                    message:Text("Navigate to the Account page to manage your Spotify connection.")
                )
            }
            .sheet(isPresented: $showingSearchTrackPopover) {
                TrackSelectPopoverView(selectedTracks: $tracks)
            }
            
        }
        //.padding([.leading, .trailing])
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color(uiColor: UIColor.systemGray6))
        .cornerRadius(10)
    }
    
    func resetTrackOrder() {
        self.tracks = self.tracks.sorted(by: {$0.order < $1.order})
        var counter = 0
        for track in self.tracks {
            track.order = Double(counter)
            counter += 1
        }
    }
}

//struct EditTrackView: View {
//    var body: some View {
//        
//    }
//}

//#Preview {
//    TracksSelectorView()
//}
