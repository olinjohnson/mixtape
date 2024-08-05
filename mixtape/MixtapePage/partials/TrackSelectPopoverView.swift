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
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
//                if searchText != "" {
                ForEach(searchResults, id: \.id) { track in
                    
                    HStack {
                        Image(uiImage: UIImage(named: "dog")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(6)
                        VStack(alignment:.leading) {
                            Spacer()
                            Text(track.name)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            Text(artistsToString(track.artists!))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(height:50)
                    .padding([.leading, .trailing])
                    
                }
                .padding(.top, 5)
//                }
            }
            .navigationTitle("Find tracks")
        }
        .searchable(text: $searchText)
        .onChange(of:searchText) {
            retrieveSearchResults()
        }
        
    }
    
    func artistsToString(_ artists: [Artist]) -> String {
        var str = artists[0].name
        for art in artists.dropFirst() {
            str.append(", \(art.name)")
        }
        return str
    }
    
//    func getAlbumCover(_ album: Album) -> Image {
//        let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.chucknorris.io/jokes/random")!)
//    }
    
    func retrieveSearchResults() {
        
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
//                let song = Song(id: UUID(), cover: track., artist: track.artists., name: track.tracks)
                }
            )

    }
}
    
//#Preview {
//    TrackSelectPopoverView()
//}
