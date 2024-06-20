//
//  JournalView.swift
//  mixtape
//
//  Created by Olin Johnson on 3/10/24.
//

import SwiftUI

struct JournalView: View {
    let entries: [Entry] = Entry.sample_entries
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                VStack(spacing:0) {
                    ScrollView(showsIndicators: false) {
                        ForEach(entries, id: \.id) {entry in
                            NavigationLink(destination:EntryDetailView(entry: entry).toolbar(.hidden, for: .tabBar)) {
                                EntryCardView(entry:entry)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .navigationTitle("Journal")
                        .searchable(text: $searchText)
                        Spacer()
                        Spacer()
                    }
                    .padding([.leading, .trailing, .top], 20)
                    .scrollClipDisabled()
                }
                // "New" button
                NavigationLink(destination: NewMixtapeView().toolbar(.hidden, for: .tabBar)) {
                    Text("+ NEW")
                        //.font(.title2)
                        .font(.title3)
                        .bold()
                        .padding(10)
                        //.foregroundColor(.white)
                        //.background(Theme.accent_color)
                        .foregroundColor(.black)
                        .background(.white)
                        .cornerRadius(10)
                }
                .shadow(color: .black.opacity(0.4), radius: 10, x: 2, y: 2)
                .offset(x: -16, y:-30)
                
            }
            //.edgesIgnoringSafeArea(.bottom)
            //.background(Theme.secondary_accent_color)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    JournalView()
}
