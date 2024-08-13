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
                            ForEach(getEntries()) {entry in
                                NavigationLink(destination:EntryDetailView(entry: entry).toolbar(.hidden, for: .tabBar)) {
                                    EntryCardView(entry:entry)
                                }
                                .buttonStyle(PlainButtonStyle())
//                                .padding([.bottom], 2)
                            }
                            .navigationTitle("Journal")
                            .searchable(text: $searchText)
                            
                            if (getEntries().count == 0) {
                                VStack {
                                    Text("You may need to re-tune your radio 📻.")
                                        .foregroundStyle(Color(UIColor.systemGray2))
                                        .multilineTextAlignment(.center)
                                        .padding(.bottom)
                                    Text("We couldn't find any entries matching your search.")
                                        .foregroundStyle(Color(UIColor.systemGray2))
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.top, 50)
                                .padding([.leading, .trailing], 40)
                            }
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: NewEntryView().toolbar(.hidden, for: .tabBar)) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func getEntries() -> [Entry] {
        if searchText == "" {
            return entries.sorted(by: {$0.date > $1.date})
        } else {
            return entries.sorted(by: {$0.date > $1.date}).filter{$0.title.lowercased().contains(searchText.lowercased()) || $0.date.formatted(date:.long, time:.omitted).lowercased().contains(searchText.lowercased()) || $0.body.lowercased().contains(searchText.lowercased())}
        }
}
}

//#Preview {
//    JournalView()
//}
