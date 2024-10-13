//
//  AMTrackSelectPopoverView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/3/24.
//

import SwiftUI
import MusicKit
import Combine

struct AMTrackSelectPopoverView: View {
    
    @MainActor @State private var searchText = ""
    @MainActor @State var searchResults: [Song] = []
    @State var isFetching = false
    
    @Binding var selectedTracks: [Song]
    
    var body: some View {
        
        NavigationStack {
            if searchText != "" {
                if isFetching {
                    ProgressView("Searching...")
                        .navigationTitle("Find tracks")
                } else {
                    ScrollView {
                        ForEach(searchResults, id: \.id) { track in
                            AMSearchableSongView(track:track, selectedTracks: $selectedTracks)
                        }
                        .padding(.top, 5)
                    }
                    .navigationTitle("Find tracks")
                }
            } else {
                Text("Search by track name, album, artist, or lyrics")
                    .foregroundStyle(Color(uiColor: UIColor.systemGray2))
                    .navigationTitle("Find tracks")
                    .padding([.leading, .trailing])
            }
        }
        .searchable(text: $searchText)
        .onChange(of:searchText) {
            Task.detached { @MainActor in
                isFetching = true
                await _retrieveSearchResults()
            }
        }
        
    }
    
    /**
    Fetch the results of an Apple Music search query
     
    This method does not accept any arguments - the value of `self.searchText` is used as the search query
     
    - Returns: No return value; this method populates `self.searchResults` with a list of `Song`s
    */
    func _retrieveSearchResults() async {
        
        var request = MusicCatalogSearchRequest(term: self.searchText, types: [MusicKit.Song.self])
        request.limit = 15
        do {
            let response = try await request.response()
            self.searchResults = []
            for song in response.songs {
                if !self.searchResults.map({$0.id}).contains(song.isrc) {
                    self.searchResults.append(Song(id: song.isrc, cover: song.artwork?.url(width:512, height:512)?.absoluteString ?? "", artist: song.artistName, name: song.title, caption: ""))
                }
            }
            self.isFetching = false
        } catch {
            print("Error in search")
        }

    }
}

struct AMSearchableSongView: View {
    
    var track: Song
    @Binding var selectedTracks: [Song]
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: track.cover)) { image in
                image.resizable()
            } placeholder: {
                VStack(alignment:.center) {
                    ProgressView()
                }
                .padding(.trailing)
            }
            .aspectRatio(contentMode: .fit)
            .cornerRadius(6)
            
            VStack(alignment:.leading) {
                Spacer()
                Text(track.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Text(track.artist)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
//                Text(track.album!.images![0].url.absoluteString)
                Spacer()
            }
            Spacer()
            
            if selectedTracks.contains(where: {selectedTrack in
                return selectedTrack.id == track.id
            }) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(Color.accentColor)
            } else {
                Button(action: {
                    track.order = Double(selectedTracks.count)
                    selectedTracks.append(track)
                }) {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .frame(height:50)
        .padding([.leading, .trailing])
    }
}

//#Preview {
//    TrackSelectPopoverView()
//}
