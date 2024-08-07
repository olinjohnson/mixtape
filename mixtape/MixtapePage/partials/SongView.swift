//
//  SongView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/6/24.
//

import SwiftUI

struct SongView: View {
    
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

//#Preview {
//    SongView()
//}
