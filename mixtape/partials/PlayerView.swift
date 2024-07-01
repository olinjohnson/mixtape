//
//  PlayerView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/27/24.
//

import SwiftUI

struct PlayerView: View {
    var body: some View {
        HStack(alignment:.center) {
            Image("dog")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth:40, maxHeight:40)
                .clipped()
                .cornerRadius(5)
            Text("Song title goes here song title goes here")
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
                Button(action:{}) {
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
        .frame(maxWidth: .infinity, minHeight:40, maxHeight:40)
        .padding(12)
        .background(Color(UIColor.systemGray6))
        //.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.systemGray4), lineWidth:3))
        .cornerRadius(10)
        .edgesIgnoringSafeArea(.horizontal)
    }
}

#Preview {
    PlayerView()
}
