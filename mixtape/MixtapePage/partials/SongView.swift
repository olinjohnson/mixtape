//
//  SongView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/20/24.
//

import SwiftUI

struct SongView: View {
    let song: Song
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: song.cover)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .cornerRadius(6)
            VStack(alignment:.leading) {
                Spacer()
                Text(song.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Text(song.artist)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding()
            Spacer()
        }
        .frame(height:50)
        .padding(5)
    }
}

//#Preview {
//    SongView(song: Tape.sample_tapes[0].songs[0])
//}
