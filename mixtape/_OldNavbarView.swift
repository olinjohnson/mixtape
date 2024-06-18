//
//  NavbarView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/20/24.
//

import SwiftUI

struct _OldNavbarView: View {
    var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                Image(systemName: "book.closed")
                    .font(.title)
                Text("Notebook")
                    .font(.footnote)
            }
            Spacer()
            VStack {
                Image(systemName: "music.note.house")
                    .font(.title)
                Text("Home")
                    .font(.footnote)
            }
            Spacer()
            VStack {
                Image(systemName: "recordingtape")
                    .font(.title)
                Text("Mixtapes")
                    .font(.footnote)
            }
        }
        .padding(20)
        .padding()
        .background(Theme.secondary_accent_color)
        .frame(width: 380, height:70)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.2), radius: 10, x: 2, y: 2)
    }
}

#Preview {
    _OldNavbarView()
}
