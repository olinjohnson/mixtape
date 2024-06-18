//
//  JournalView.swift
//  mixtape
//
//  Created by Olin Johnson on 3/10/24.
//

import SwiftUI

struct JournalView: View {
    let entries: [Entry] = Entry.sample_entries
    //@State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                VStack(spacing:0) {
                    ScrollView(showsIndicators: false) {
                        ForEach(entries, id: \.title) {entry in
                            HStack {
                                Image("dog")
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
                            .cornerRadius(10)
                            /*NavigationLink(destination:MixtapeDetailView(mixtape: tape).toolbar(.hidden, for: .tabBar)) {
                                TapeCardView(tape:tape)
                                    .padding(5)
                            }*/
                        }
                        .navigationTitle("Journal")
                        //.searchable(text: $searchText)
                        Spacer()
                        Spacer()
                    }
                    .padding([.leading, .trailing, .top], 20)
                    .scrollClipDisabled()
                }
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
