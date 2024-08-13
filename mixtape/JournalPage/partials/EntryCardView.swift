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
            Image(uiImage: UIImage(data: entry.cover)!)
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
            .padding(.leading, 8)
//            .padding([.top, .bottom, .trailing], 12)
            Spacer()
        }
        .frame(height:84)
        .padding(12)
//        .background(Color(UIColor.systemGray6))
        .background(.white)
        .cornerRadius(10)
        .padding([.leading, .trailing])
        .shadow(color: .black.opacity(0.01), radius:2, x:2, y:2)
    }
}


//#Preview {
//    EntryCardView()
//}

