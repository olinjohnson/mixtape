//
//  TracksView.swift
//  mixtape
//
//  Created by Olin Johnson on 7/26/24.
//

import SwiftUI

struct TrackView: View {
    
    let track: Song
    
    var body: some View {
        HStack {
            track.cover
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(6)
                .frame(maxHeight:50)
                .padding(.trailing, 5)
            VStack(alignment:.leading) {
                Text(track.name)
                    .bold()
                Text(track.artist)
                    .font(.caption)
            }
        }
    }
}

struct TracksView: View {
    
    let tracks: [Song]
    
    var body: some View {
        VStack(alignment:.leading) {
            if (tracks.count) > 0 {
                TrackView(track: tracks[0])
                ForEach(tracks.dropFirst()) { track in
                    Divider()
                    TrackView(track: track)
                }
            } else {
                VStack(alignment:.leading) {
                    Text("No tracks yet")
                        .bold()
                }
                .padding([.top, .bottom], 5)
            }
            Button(action: {}) {
                HStack {
                    Image(systemName: "plus")
                        .bold()
                    Text("Add tracks")
                        .bold()
                }
            }
            .padding(.top, 10)
        }
        .padding([.leading, .trailing])
    }
}

//#Preview {
//    TracksView(tracks: Tape.sample_tapes[0].songs)
//}
