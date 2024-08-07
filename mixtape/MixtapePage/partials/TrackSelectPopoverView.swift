//
//  TrackSelectPopoverView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/3/24.
//

import SwiftUI
import SpotifyWebAPI
import Combine

struct TrackSelectPopoverView: View {
    
    @EnvironmentObject var spotifyController: SpotifyController
    
    @State private var searchText = ""
    @State var searchResults: [Track] = []
    
    @State private var searchCancellable: AnyCancellable? = nil
    
    @Binding var selectedTracks: [Song]
    
    var body: some View {
        
        NavigationStack {
            if searchText != "" {
                ScrollView {
                    ForEach(searchResults, id: \.id) { track in
                        SearchableSongView(track:track, selectedTracks: $selectedTracks)
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

struct SearchableSongView: View {
    
    var track: Track
    @Binding var selectedTracks: [Song]
    
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
            
            if selectedTracks.contains(where: {selectedTrack in
                return selectedTrack.id == track.id
            }) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.blue)
            } else {
                Button(action: {
                    let select = Song(id: track.id!, cover: track.album!.images![0].url.absoluteString, artist: SearchableSongView.artistsToString(track.artists!), name: track.name, order: Double(selectedTracks.count), caption: "")
                    selectedTracks.append(select)
                }) {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .frame(height:50)
        .padding([.leading, .trailing])
    }
    
    /**
    Represent a list of SpotifyAPI `Artist` objects as a String of names
    - Parameter artists: The list of `Artist`s
    - Returns: A String of comma-separated names
    */
    static func artistsToString(_ artists: [Artist]) -> String {
        var str = artists[0].name
        for art in artists.dropFirst() {
            str.append(", \(art.name)")
        }
        return str
    }
}

//#Preview {
//    TrackSelectPopoverView()
//}
