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
        HStack(alignment:.center) {
            AsyncImage(url: URL(string: track.cover)) { image in
                image.resizable()
            } placeholder: {
                VStack(alignment:.center) {
                    ProgressView()
                }
            }
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
            Spacer()
        }
        .frame(maxHeight:50)
    }
}

struct TracksView: View {
    
    let tracks: [Song]
    
    var body: some View {
        VStack(alignment:.leading, spacing:5) {
            if (tracks.count) > 0 {
                ForEach(tracks.sorted(by: {$0.order < $1.order})) { track in
                    TrackView(track: track)
                    if (track.order < Double(tracks.count) - 1) {
                        Divider()
                            .padding(.leading, 60)
                    }
                }
            } else {
                VStack(alignment:.leading) {
                    Text("No tracks yet")
                        .bold()
                }
                //.padding([.top, .bottom], 5)
            }
        }
        //.padding([.leading, .trailing])
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color(uiColor: UIColor.systemGray6))
        .cornerRadius(10)
    }
}

//#Preview {
//    TracksView(tracks: Tape.sample_tapes[0].songs)
//}
