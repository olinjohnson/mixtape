//
//  PlayerView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/27/24.
//

import SwiftUI
import SpotifyWebAPI

struct PlayerView: View {
    
    @EnvironmentObject var spotifyController: SpotifyController
    
    var body: some View {
        
        HStack(alignment:.center) {
            if !spotifyController.isAuthorized {
                Text("Connect to Spotify or Apple Music to use music player")
                    .font(.caption)
                    .bold()
            } else {
                Image("dog")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth:40, maxHeight:40)
                    .clipped()
                    .cornerRadius(5)
                Text(spotifyController.spotify.currentPlayback().description)
                    .padding(.leading, 5)
                Spacer()
                HStack(alignment:.center) {
                    Button(action:{}){
                        Image(systemName: "backward.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:15)
                    }
                    .foregroundStyle(.black)
                    Button(action:{
                        print(spotifyController.playCurrentTrack())
                    }) {
                        Image(systemName: "play.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:20)
                            .padding([.leading, .trailing], 10)
                    }
                    .foregroundStyle(.black)
                    Button(action:{}) {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height:15)
                    }
                    .foregroundStyle(.black)
                }
                .padding(5)
            }
        }
        .frame(maxWidth: .infinity, minHeight:40, maxHeight:40)
        .padding(12)
        .background(Color(UIColor.systemGray6))
        //.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.systemGray4), lineWidth:3))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
        .edgesIgnoringSafeArea(.horizontal)
    }
}

#Preview {
    PlayerView()
}
