//
//  PhotosSelectorView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/8/24.
//

import SwiftUI
import SwiftData
import PhotosUI
import AVKit
import MediaPicker

/*
 TODO: bugs
 - cant handle videos
 - redesign cards
 */

struct MediaSelectorView: View {
    
    @EnvironmentObject var spotifyController: SpotifyController
    @Environment(\.modelContext) private var modelContext
    
    @Binding var media: [Media]
    @State var selectedPhotos: [String] = []
    @State var selectedTracks: [String] = []
    @State var alreadyAddedTracks: [String] = []
    
    @State var trackSelectPopover = false
    @State var showingConnectAlert = false
    @State var showingPVPicker = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Media")
                    .font(.title3)
                    .bold()
                    .padding([.leading, .trailing])
                Spacer()
                HStack(){
                    Button(action: {}) {
                        Image(systemName: "shuffle")
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
                    .padding(.trailing, 5)
                    // TODO: add voice memos capability
                    Button(action: {}) {
                        Image(systemName: "waveform.badge.plus")
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
                    
                    Button(action: {
                        if spotifyController.isAuthorized {
                            trackSelectPopover = true
                        } else {
                            showingConnectAlert = true
                        }                    }) {
                        Image(systemName: "music.note.list")
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
                    .sheet(isPresented: $trackSelectPopover) {
                        MusicSelectPopoverView(selectedTracks:$selectedTracks, alreadyAddedTracks: $alreadyAddedTracks)
                    }
                    .alert(isPresented:$showingConnectAlert) {
                        Alert(
                            title:Text("Connect to Spotify to add tracks."),
                            message:Text("Navigate to the Account page to manage your Spotify connection.")
                        )
                    }
                    .padding([.leading, .trailing], 5)
                    
                    Button(action: {
                        showingPVPicker = true
                    }) {
                        Image(systemName: "camera.viewfinder")
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
                    .mediaImporter(isPresented: $showingPVPicker, allowedMediaTypes: .all, allowsMultipleSelection: true) { result in
                        switch result {
                        case .success(let urls):
                            for url in urls {
                                media.append(Media(image:url.absoluteString))
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                .padding(.trailing)
            }
//            .onChange(of: selectedPhotos) {
//                Task {
//                    for image in selectedPhotos {
//                        if let imageData = try? await image.loadTransferable(type: Data.self) {
//                            media.append(Media(image:imageData))
//                        }
//                    }
//                    selectedPhotos = []
//                }
//            }
            //Saving URI for track
            .onChange(of: trackSelectPopover) {
                for track in selectedTracks {
                    media.append(Media(song: track))
                }
                selectedTracks = []
            }
            MediaMasonryView(media:media)
                .padding(.top)
        }
        .onAppear(perform: {
            for snippet in media {
                if snippet.song != nil {
                    alreadyAddedTracks.append(snippet.song!)
                }
            }
        })

    }
    
}

//#Preview {
//    PhotosSelectorView()
//}
