//
//  TrackSelectPopoverView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/3/24.
//

import SwiftUI

struct TrackSelectPopoverView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
            }
            .navigationTitle("Find tracks")
        }
        .searchable(text: $searchText)
        
    }
}

//#Preview {
//    TrackSelectPopoverView()
//}
