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
import SpotifyWebAPI

struct MediaMasonryView: View {
    
    var media: [Media]
    
    var body: some View {
        
        if media.count > 0 {
            MasonryVStack(columns:media.count > 6 ? 3 : (media.count > 1 ? 2 : 1)) {
                ForEach(media, id:\.self) { snippet in
                    if snippet.image != nil {
                        PVView(data: snippet.image!)
                    } else if snippet.song != nil {
                        SongCardView(uri: snippet.song!)
                    }
                }
            }
        } else {
            VStack {
                HStack {
                    Text("No media selected")
                        .bold()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color(uiColor: UIColor.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct MediaMasonrySelectionView: View {
    
    @Binding var media: [Media]
    
    var body: some View {
        
        if media.count > 0 {
            MasonryVStack(columns:media.count > 6 ? 3 : (media.count > 1 ? 2 : 1)) {
                ForEach(media, id:\.self) { snippet in
                    if snippet.image != nil {
                        PVView(data: snippet.image!)
                            .overlay {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Button(action: {
                                            withAnimation {
                                                _ = media.remove(at:media.firstIndex(of: snippet)!)
                                            }
                                        }) {
                                            Image(systemName: "trash")
                                                .resizable()
                                                .foregroundStyle(.white)
                                                .padding(5)
                                                .frame(width:25, height:25)
                                        }
                                        .background(.black.opacity(0.3))
                                        .cornerRadius(20)
                                        .padding(5)
                                        Spacer()
                                    }
                                }
                            }
                    } else if snippet.song != nil {
                        SongCardView(uri: snippet.song!)
                            .overlay {
                                VStack {
                                    Spacer()
                                    HStack {
                                        Button(action: {
                                            withAnimation {
                                                _ = media.remove(at:media.firstIndex(of: snippet)!)
                                            }
                                        }) {
                                            Image(systemName: "trash")
                                                .resizable()
                                                .foregroundStyle(.white)
                                                .padding(5)
                                                .frame(width:25, height:25)
                                        }
                                        .background(.black.opacity(0.3))
                                        .cornerRadius(20)
                                        .padding(5)
                                        Spacer()
                                    }
                                }
                            }
                    }
                }
            }
        } else {
            VStack {
                HStack {
                    Text("No media selected")
                        .bold()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(Color(uiColor: UIColor.systemGray6))
            .cornerRadius(10)
        }
    }
    
}

struct PVView: View {
    
//    var url: String
    var data: Data
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: data)!)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
}

struct SongCardView: View {
    
    @EnvironmentObject var spotifyController: SpotifyController
    var uri: String
    @State var url = URL(string: "")
    @State var track: Track? = nil
    @State var trackCancellable: AnyCancellable? = nil
    
    var body: some View {
        VStack {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                Image("blank")
                    .resizable()
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(uiColor:UIColor.systemGray6), lineWidth: 1)
                        if spotifyController.isAuthorized {
                            ProgressView()
                        } else {
                            Text("Connect to Spotify")
                                .font(.caption)
                                .foregroundStyle(Color(uiColor:UIColor.systemGray3))
                                .padding()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .aspectRatio(contentMode: .fit)
            .cornerRadius(6)
            .overlay {
                HStack {
                    VStack(alignment:.leading) {
                        Text(self.track?.name ?? "")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                            .bold()
                            .lineLimit(1)
                        Text(SearchableSongView.artistsToString(self.track?.artists ?? []))
                            .foregroundStyle(.white)
                            .font(.caption)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
                .background(.black.opacity(0.1))
                .cornerRadius(10)
            }
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
                        self.track = results
                        self.url = results.album!.images![0].url
                    }
                )
        })
    }
    
}

//#Preview {
//    MediaMasonryView()
//}
