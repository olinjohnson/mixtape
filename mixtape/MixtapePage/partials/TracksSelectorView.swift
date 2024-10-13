//
//  TracksSelectorView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/3/24.
//

import SwiftUI

struct TracksSelectorView: View {
    
    @EnvironmentObject var spotifyController: SpotifyController
    @EnvironmentObject var appleMusicController: AppleMusicController
    @Binding var tracks: [Song]
    
    @State private var showingConnectAlert = false
    @State private var showingSearchTrackPopover = false
    
    var body: some View {
        VStack(alignment:.leading, spacing:5) {
            ForEach($tracks) { $track in
                HStack(alignment:.center) {
                    SongView(track: track)
                    
                    Button(action: {
                        withAnimation {
                            track.order += 1.5
                            self.resetTrackOrder()
                        }
                    }) {
                        Image(systemName: "arrow.down.circle.fill")
                            .foregroundStyle(Color(uiColor: UIColor.systemGray3))
                    }
                    
                    Button(action: {
                        withAnimation {
                            track.order -= 1.5
                            self.resetTrackOrder()
                        }
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
                            self.resetTrackOrder()
                        }
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundStyle(.red)
                    }
                    
                }
                TextField("Add a track caption...", text: $track.caption, axis:.vertical)
                    .padding(.leading, 65)
                    .padding(.bottom, 8)
                    .multilineTextAlignment(.leading)
                    .onAppear(perform: {
                        track.caption = track.caption.trimmingCharacters(in: .whitespacesAndNewlines)
                    })
                
                if (track.order < Double(tracks.count) - 1) {
                    Divider()
                        .padding(.leading, 60)
                }
            }
            
            if tracks.count != 0 {
                Divider()
                    .padding(.leading, 60)
                    .padding(.bottom, 10)
            }
                //.padding([.top, .bottom], 5)
            Button(action: {
                if spotifyController.isAuthorized || appleMusicController.isAuthorized {
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
                    title:Text("Connect to a music streaming service to add tracks."),
                    message:Text("Navigate to the Account page to manage your music integrations.")
                )
            }
            .sheet(isPresented: $showingSearchTrackPopover) {
                if spotifyController.isAuthorized {
                    SpotifyTrackSelectPopoverView(selectedTracks: $tracks)
                } else if appleMusicController.isAuthorized {
                    AMTrackSelectPopoverView(selectedTracks: $tracks)
                }
            }
        }
        //.padding([.leading, .trailing])
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color(uiColor: UIColor.systemGray6))
        .cornerRadius(10)
        .onAppear(perform: {
            tracks = tracks.sorted(by: {$0.order < $1.order})
        })
        
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

//#Preview {
//    TracksSelectorView()
//}
