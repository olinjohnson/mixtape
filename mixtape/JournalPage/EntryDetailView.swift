//
//  EntryDetailView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/17/24.
//


import SwiftUI
import SwiftData

struct EntryDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let entry: Entry
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // header image
                VStack {
                    GeometryReader { gr in
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                            entry.cover
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: gr.size.width, height: gr.size.height + max(0, gr.frame(in: .global).origin.y))
                                .offset(y: -gr.frame(in: .global).origin.y)

                            NavigationLink(destination: JournalView().toolbar(.hidden, for: .tabBar)) {
                                NavBackView(dismiss:self.dismiss)
                            }
                            .offset(y: -gr.frame(in: .global).origin.y + 20)
                        }
                    }
                    .frame(height:400)
                    
                    // Info stack
                    VStack {
                        // date
                        HStack {
                            Text(entry.date, style: .date)
                                .font(.footnote)
                                .padding([.leading, .trailing])
                            Spacer()
                        }
                        
                        // title
                        HStack {
                            Text(entry.title)
                                .font(.title)
                                .bold()
                                .padding([.leading, .trailing, .bottom])
                            Spacer()
                        }
                        
                        // body text
                        HStack {
                            Text(entry.body)
                                .padding([.leading, .trailing])
                            Spacer()
                        }
                        .padding(.bottom)
                    }
                    .padding([.leading, .trailing, .top])
                    .background(.white)
                }
                .padding(.bottom)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
    }
}

/*
#Preview {
    EntryDetailView(entry: Entry.sample_entries[0])
}
*/
