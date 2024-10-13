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
    
    @MainActor @State private var searchText = ""
    @MainActor @State var searchResults: [Song] = []
    @State var isFetching = false
    
    @Binding var selectedTracks: [Song]
    @Binding var alreadyAddedTracks: [String]
    
    var body: some View {
        
        NavigationStack {
            if searchText != "" {
                if isFetching {
                    ProgressView("Searching...")
                        .navigationTitle("Find tracks")
                }else{
                    ScrollView {
                        ForEach(searchResults, id: \.id) { track in
                            AMAlternateSearchableSongView(track:track, selectedTracks: $selectedTracks, alreadyAddedTracks: $alreadyAddedTracks)
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
        
        //TODO: FIX MULTIPLE RESULT BUG
        self.searchResults = []
        var request = MusicCatalogSearchRequest(term: self.searchText, types: [MusicKit.Song.self])
        request.limit = 15
        do {
            let response = try await request.response()
            for song in response.songs {
                //id: song.id.rawValue,
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

//#Preview {
//    MusicSelectorView()
//}


struct AMAlternateSearchableSongView: View {
    
    var track: Song
    @Binding var selectedTracks: [Song]
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
            
            if alreadyAddedTracks.contains(where: { tr in
                tr == track.id
            }) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(Color.accentColor)
            } else {
                Button(action: {
                    // TODO: implement a consistent method to record already added tracks between spotify and apple music (names cant be used, but ID's aren't the same
                    selectedTracks.append(track)
                    //TODO: improve this code to be more defensive (i suppose track.id could be nil)
                    alreadyAddedTracks.append(track.id!)
                }) {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .frame(height:50)
        .padding([.leading, .trailing])
    }
}
