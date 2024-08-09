//
//  MediaMasonryView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/9/24.
//

import SwiftUI
import MasonryStack
import Combine

struct MediaMasonryView: View {
    
    var media: [Media]
//    var media: [Media]
    
    var body: some View {
        MasonryVStack(columns:media.count > 6 ? 3 : (media.count > 1 ? 2 : 1)) {
            ForEach(media, id:\.self) { snippet in
                if snippet.image != nil {
                    Image(uiImage: UIImage(data: snippet.image!)!)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else if snippet.song != nil {
                    SongCardView(uri: snippet.song!)
                }
            }
        }
            
    }
    
}

struct SongCardView: View {
    
    @EnvironmentObject var spotifyController: SpotifyController
    var uri: String
    @State var url = URL(string: "")
    @State var trackCancellable: AnyCancellable? = nil
    
    var body: some View {
        VStack {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .cornerRadius(6)
        }
        .onAppear(perform: {
            self.trackCancellable = spotifyController.spotify.track(uri)
                .receive(on: RunLoop.main)
                .sink(
                    receiveCompletion: { completion in
                        if case(.failure) = completion {
                            //process
                        }
                    },
                    receiveValue: { results in
                        self.url = results.album!.images![0].url
                    }
                )
        })
    }
    
}

//#Preview {
//    MediaMasonryView()
//}
