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
        VStack(alignment:.leading) {
            
            if(tracks.count == 0) {
                VStack(alignment:.leading) {
                    Text("No tracks yet")
                        .bold()
                }
                .padding(.bottom, 7)
                .padding(.top, 2)
            } else {
                TrackView(track: tracks[0])
                ForEach(tracks.dropFirst()) { track in
                    Divider()
                    TrackView(track: track)
                }
            }
            
            Divider()
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
            .padding(.top, 10)
            
        }
        //.padding([.leading, .trailing])
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color(uiColor: UIColor.systemGray6))
        .cornerRadius(10)
    }
}

//#Preview {
//    TracksSelectorView()
//}
