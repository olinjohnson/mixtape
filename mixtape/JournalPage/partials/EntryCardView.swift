//
//  EntryCardView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/17/24.
//

import SwiftUI
import UIKit

struct EntryCardView: View {
    
    let entry: Entry
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: entry.cover!) ?? UIImage(named: "no_select")!)
//            Image("dog")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth:84, maxHeight:84)
                .clipped()
                .cornerRadius(5)
            VStack(alignment:.leading) {
                Text(entry.date, style:.date)
//                Text("Date")
                    .font(.caption)
                Text(entry.title)
//                Text("Title")
                    .font(.headline)
                    //.padding([.bottom], 1)
                Text(entry.body)
//                Text("Body")
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .font(.subheadline)
                    //.foregroundColor(Color(UIColor.systemGray))
            }
            .padding(.leading, 5)
            Spacer()
        }
        .frame(height:84)
        .padding(12)
        .background(Color(UIColor.systemGray6))
        //.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(UIColor.systemGray4), lineWidth:3))
        .cornerRadius(10)
        .padding([.leading, .trailing])
        .shadow(color: .black.opacity(0.1), radius:3, x:2, y:2)
    }
}


//#Preview {
//    EntryCardView()
//}

