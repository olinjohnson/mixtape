//
//  MusicSelectorView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/8/24.
//

import SwiftUI
import MusicKit
import Combine

struct AppleMusicSelectPopoverView: View {
    
    @EnvironmentObject var appleMusicController: AppleMusicController
    
    @State private var searchText = ""
    @State var searchResults: [Song] = []
    
    @Binding var selectedTracks: [String]
    @Binding var alreadyAddedTracks: [String]
    
    var body: some View {
        
        NavigationStack {
            if searchText != "" {
                ScrollView {
                    ForEach(searchResults, id: \.id) { track in
                        AMAlternateSearchableSongView(track:track, selectedTracks: $selectedTracks, alreadyAddedTracks: $alreadyAddedTracks)
                    }
                    .padding(.top, 5)
                }
                .navigationTitle("Find tracks")
            } else {
                Text("Search by track name, album, or artist")
                    .foregroundStyle(Color(uiColor: UIColor.systemGray3))
                    .navigationTitle("Find tracks")
            }
        }
        .searchable(text: $searchText)
        .onChange(of:searchText) {
            Task {
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
                self.searchResults.append(Song(id: song.id.rawValue, cover: song.artwork?.url(width:512, height:512)?.absoluteString ?? "", artist: song.artistName, name: song.title, caption: ""))
            }
        } catch {
            print("Error in search")
        }

    }
}

//#Preview {
//    MusicSelectorView()
//}


struct AMAlternateSearchableSongView: View {
    
    var track: Song
    @Binding var selectedTracks: [String]
    @Binding var alreadyAddedTracks: [String]
    
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
            
            if alreadyAddedTracks.contains(track.id) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)
            } else {
                Button(action: {
                    // TODO: implement a consistent method to record already added tracks between spotify and apple music (names cant be used, but ID's aren't the same
                    selectedTracks.append(track.id)
                    alreadyAddedTracks.append(track.id)
                }) {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .frame(height:50)
        .padding([.leading, .trailing])
    }
}
