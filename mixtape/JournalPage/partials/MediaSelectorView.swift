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

struct MediaSelectorView: View {
    
    @EnvironmentObject var spotifyController: SpotifyController
    @EnvironmentObject var appleMusicController: AppleMusicController
    @Environment(\.modelContext) private var modelContext
    
    @Binding var media: [Media]
    @State var selectedPhotos: [PhotosPickerItem] = []
    @State var selectedTracks: [Song] = []
    @State var alreadyAddedTracks: [String] = []
    
    @State var trackSelectPopover = false
    @State var showingConnectAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Media")
                    .font(.title3)
                    .bold()
                    .padding([.leading, .trailing])
                Spacer()
                HStack(){
                    Button(action: {
                        withAnimation {
                            media = media.shuffled()
                        }
                    }) {
                        Image(systemName: "shuffle")
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
//                    .padding(.trailing, 5)
                    // TODO: add voice memos capability
//                    Button(action: {}) {
//                        Image(systemName: "waveform.badge.plus")
//                            .font(.title3)
//                            .foregroundStyle(.black)
//                    }
                    
                    Button(action: {
                        if spotifyController.isAuthorized || appleMusicController.isAuthorized {
                            trackSelectPopover = true
                        } else {
                            showingConnectAlert = true
                        }
                    }) {
                        Image(systemName: "music.note.list")
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
                    .sheet(isPresented: $trackSelectPopover) {
                        
                        if spotifyController.isAuthorized {
                            //TODO: FIX THIS (Media DATA TYPES)
                            //SpotifyMusicSelectPopoverView(selectedTracks:$selectedTracks, alreadyAddedTracks: $alreadyAddedTracks)
                        } else {
                            AppleMusicSelectPopoverView(selectedTracks: $selectedTracks, alreadyAddedTracks: $alreadyAddedTracks)
                        }
                        
                    }
                    .alert(isPresented:$showingConnectAlert) {
                        Alert(
                            title:Text("Connect to a music streaming service to add tracks."),
                            message:Text("Navigate to the Account page to manage your music integrations.")
                        )
                    }
                    .padding([.leading, .trailing], 5)
                    
                    PhotosPicker(selection:$selectedPhotos, matching:.images) {
                        Image(systemName: "camera.viewfinder")
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
                    
                }
                .padding(.trailing)
            }
            .onChange(of: selectedPhotos) {
                Task {
                    for image in selectedPhotos {
                        if let imageData = try? await image.loadTransferable(type: Data.self) {
                            media.append(Media(image:imageData))
                        }
                    }
                    selectedPhotos = []
                }
            }

            .onChange(of: trackSelectPopover) {
                for track in selectedTracks {
                    let m = Media(isrc: track.id, songCover: track.cover, songName: track.name, songArtist: track.artist)
                    media.append(m)
                }
                selectedTracks = []
            }
            MediaMasonrySelectionView(media:$media)
                .padding(.top)
        }
        .onAppear(perform: {
            for snippet in media {
                if snippet.songCover != nil {
                    alreadyAddedTracks.append(snippet.isrc!)
                }
            }
        })

    }
    
}

//#Preview {
//    PhotosSelectorView()
//}
