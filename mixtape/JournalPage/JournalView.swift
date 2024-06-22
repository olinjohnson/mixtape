//
//  JournalView.swift
//  mixtape
//
//  Created by Olin Johnson on 3/10/24.
//

import SwiftUI
import SwiftData
import UIKit

struct JournalView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var entries: [Entry]
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                VStack(spacing:0) {
                    ScrollView(showsIndicators: false) {
                        if (entries.count > 0) {
                            ForEach(entries.sorted(by: {$0.date < $1.date}).reversed()) {entry in
                                NavigationLink(destination:EntryDetailView(entry: entry).toolbar(.hidden, for: .tabBar)) {
                                    EntryCardView(entry:entry)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding([.bottom], 8)
                            }
                            .navigationTitle("Journal")
                            .searchable(text: $searchText)
                        } else {
                            VStack {
                                Text("No entries yet")
                                    .navigationTitle("Journal")
                                    .font(.title)
                                    .bold()
                                NavigationLink(destination: NewEntryView().toolbar(.hidden, for: .tabBar)) {
                                    Text(" Write your first entry")
                                }
                            }
                            .padding([.top], 40)
                            .searchable(text: $searchText)
                        }
                        
                    }
                    .padding([.top], 20)
                    .scrollClipDisabled()
                }

                // "New" button
                HStack {
                    Spacer()
                    NavigationLink(destination: NewEntryView().toolbar(.hidden, for: .tabBar)) {
                        VStack {
                            Text("+")
                                .font(.title2)
                            //                            .font(.title3)
                                .bold()
                            //.foregroundColor(.white)
                            //.background(Theme.accent_color)
                                .foregroundColor(.black)
                        }
                        .frame(width:50, height:50)
                        .background(.white)
                        .cornerRadius(100)
                        .padding([.leading, .trailing], 10)
                    }
                }
                .shadow(color: .black.opacity(0.2), radius: 10, x: 2, y: 2)
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
