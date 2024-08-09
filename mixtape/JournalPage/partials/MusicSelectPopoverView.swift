//
//  MusicSelectorView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/8/24.
//

import SwiftUI
import SpotifyWebAPI
import Combine

struct MusicSelectPopoverView: View {
    
    @EnvironmentObject var spotifyController: SpotifyController
    
    @State private var searchText = ""
    @State var searchResults: [Track] = []
    
    @State private var searchCancellable: AnyCancellable? = nil
    
    @Binding var selectedTracks: [String]
    @Binding var alreadyAddedTracks: [String]
    
    var body: some View {
        
        NavigationStack {
            if searchText != "" {
                ScrollView {
                    ForEach(searchResults, id: \.id) { track in
                        AlternateSearchableSongView(track:track, selectedTracks: $selectedTracks, alreadyAddedTracks: $alreadyAddedTracks)
                    }
                    .padding(.top, 5)
                }
                .navigationTitle("Find tracks")
            } else {
                Text("Search by track name or artist")
                    .foregroundStyle(Color(uiColor: UIColor.systemGray3))
                    .navigationTitle("Find tracks")
            }
        }
        .searchable(text: $searchText)
        .onChange(of:searchText) {
            _retrieveSearchResults()
        }
        
    }
    
    /**
    Fetch the results of a SpotifyAPI search query
     
    This method does not accept any arguments - the value of `self.searchText` is used as the search query
     
    - Returns: No return value; this method populates `self.searchResults` with a list of SpotifyAPI `Track` objects
    */
    func _retrieveSearchResults() {
        
        self.searchCancellable = spotifyController.spotify.search(query: self.searchText, categories: [.track])
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    if case(.failure) = completion {
                        //process
                    }
                },
                receiveValue: { results in
                    self.searchResults = results.tracks?.items ?? []
                }
            )

    }
}

//#Preview {
//    MusicSelectorView()
//}


struct AlternateSearchableSongView: View {
    
    var track: Track
    @Binding var selectedTracks: [String]
    @Binding var alreadyAddedTracks: [String]
    
    var body: some View {
        HStack {
            AsyncImage(url: track.album!.images![0].url) { image in
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
                Text(SearchableSongView.artistsToString(track.artists!))
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
//                Text(track.album!.images![0].url.absoluteString)
                Spacer()
            }
            Spacer()
            
            if alreadyAddedTracks.contains(track.uri!) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)
            } else {
                Button(action: {
                    let select = track.uri
                    selectedTracks.append(select!)
                    alreadyAddedTracks.append(select!)
                }) {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .frame(height:50)
        .padding([.leading, .trailing])
    }
}
