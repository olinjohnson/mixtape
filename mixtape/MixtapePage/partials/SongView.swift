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
            song.cover
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(6)
            VStack(alignment:.leading) {
                Spacer()
                Text(song.name)
                    .font(.headline)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                Text(song.artist)
                    .font(.subheadline)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            .padding()
            Spacer()
        }
        .frame(height:50)
        .padding(5)
    }
}

#Preview {
    SongView(song: Tape.sample_tapes[0].songs[0])
}
