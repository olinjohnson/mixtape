//
//  EntryDetailView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/17/24.
//


import SwiftUI
import SwiftData
import UIKit

struct EntryDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let entry: Entry
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ScrollView {
                    VStack(alignment: .leading) {
                        GeometryReader { gr in
                            Image(uiImage: UIImage(data: entry.cover)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: gr.size.width, height: gr.size.height + max(0, gr.frame(in: .global).origin.y))
                                .offset(y: -gr.frame(in: .global).origin.y)
                            
                            NavigationLink(destination: JournalView().toolbar(.hidden, for: .tabBar)) {
                                NavBackView(dismiss:self.dismiss)
                            }
                            .offset(y: -gr.frame(in: .global).origin.y)
                        }
                        .frame(height:350)
                        .border(.cyan, width:5)
                        
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
                        .padding()
                        .background(.white)
                        .border(.purple, width:4)
                    }
                    .border(.blue, width:4)
                    .frame(minHeight: reader.size.height)
                }
                //.edgesIgnoringSafeArea(.all)
                .border(.yellow, width:4)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

/*
#Preview {
    EntryDetailView(entry: Entry.sample_entries[0])
}
*/
