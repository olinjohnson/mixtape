//
//  MediaMasonryView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/9/24.
//

import SwiftUI
import MasonryStack
import Combine
import AVKit

struct MediaMasonryView: View {
    
    var media: [Media]
//    var media: [Media]
    
    var body: some View {
        MasonryVStack(columns:media.count > 6 ? 3 : (media.count > 1 ? 2 : 1)) {
            ForEach(media, id:\.self) { snippet in
                if snippet.image != nil {
                    PVView(url:snippet.image!)
                } else if snippet.song != nil {
                    SongCardView(uri: snippet.song!)
                }
            }
        }
            
    }
    
}

struct PVView: View {
    
    var url: String
    
    var body: some View {
        VStack {
            switch try! URL(string:url)!.resourceValues(forKeys: [.contentTypeKey]).contentType! {
                
            case let contentType where contentType.conforms(to: .image):
                
                AsyncImage(url: URL(string:url)) { image in
                    image.resizable()
                } placeholder: {
                    Image("blank")
                        .resizable()
                        .overlay { 
                            ProgressView()
                        }
                }
                .aspectRatio(contentMode: .fit)
                .cornerRadius(6)
                
            case let contentType where
                contentType.conforms(to: .audiovisualContent):
                //                        snippet.image!
                VideoPlayer(player: AVPlayer(url: URL(string:url)!))
                    .scaledToFit()
                    .onAppear(perform: {
                        print("hi")
                    })
                //                            .clipShape(RoundedRectangle(cornerRadius: 10))
                
            default:
                Image("blank")
                    .resizable()
                    .overlay {
                        ProgressView()
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
                Image("blank")
                    .resizable()
                    .overlay {
                        ProgressView()
                    }
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
