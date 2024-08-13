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
    
    @EnvironmentObject var nBar: NBar
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                VStack(spacing:0) {
                    ScrollView(showsIndicators: false) {
                        if (entries.count > 0) {
                            ForEach(entries.sorted(by: {$0.date < $1.date}).reversed()) {entry in
                                NavigationLink(destination:EntryDetailView(entry: entry)) {
                                    EntryCardView(entry:entry)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding([.bottom], 5)
                            }
                            .navigationTitle("Journal")
                            //.searchable(text: $searchText)
                        } else {
                            VStack {
                                Text("No entries yet")
                                    .navigationTitle("Journal")
                                    .font(.title)
                                    .bold()
                                NavigationLink(destination: NewEntryView()) {
                                    Text(" Write your first entry")
                                }
                            }
                            .frame(maxWidth:.infinity)
                            .padding([.top], 160)
                        }
                        
                    }
//                    .padding([.top], 10)
                }

                // "New" button
                /*
                NavigationLink(destination: NewEntryView()) {
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
                .shadow(color: .black.opacity(0.2), radius: 10, x: 2, y: 2)
                .offset(x: -16, y:-30)
                 */
                
            }
            .background(Color(UIColor.systemGray6))
            //.edgesIgnoringSafeArea(.bottom)
            //.background(Theme.secondary_accent_color)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: NewMixtapeView()) {
                    Image(systemName: "plus.circle")
                }
            }
        }
    }
}

//#Preview {
//    JournalView()
//}
