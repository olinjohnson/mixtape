//
//  EntryCardView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/17/24.
//

import SwiftUI

struct EntryCardView: View {
    
    let entry: Entry
    
    var body: some View {
        HStack {
            entry.cover
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
            VStack(alignment:.leading) {
                Text(entry.title)
                    .font(.headline)
                    .padding([.bottom, .top], 1)
                Text(entry.body)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .font(.subheadline)
                    //.foregroundColor(Color(UIColor.systemGray))
            }
            .padding(.leading, 5)
            Spacer()
        }
        .frame(height:74)
        .padding(12)
        .background(Color(UIColor.systemGray6))
        //.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.systemGray4), lineWidth:3))
        .cornerRadius(10)
        .padding([.leading, .trailing])
        .shadow(color: .black.opacity(0.12), radius:3, x:1, y:1)
    }
}

#Preview {
    EntryCardView(entry:Entry.sample_entries[0])
}
