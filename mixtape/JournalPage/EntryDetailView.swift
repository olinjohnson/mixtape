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
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) private var dismiss
    
    @State var showingDeleteAlert = false
    
    @State private var imageHeight: CGFloat = 350
    
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
                                .frame(width: gr.size.width, height: gr.size.height + max(0, gr.frame(in: .global).origin.y))//, alignment:.bottom)
                                .offset(y: -gr.frame(in: .global).origin.y)
                                //.blur
                            HStack{
                                NavigationLink(destination: JournalView().toolbar(.hidden, for: .tabBar)) {
                                    NavBackView(dismiss:self.dismiss)
                                }
                                Spacer()
                                Menu {
                                    Button(action:{}) {
                                        Label("Edit entry", systemImage: "pencil")
                                    }
                                    Button(role: .destructive, action:{showingDeleteAlert = true}) {
                                        Label("Delete entry", systemImage: "trash")
                                    }
                                } label: {
                                    Text(Image(systemName: "ellipsis"))
                                        .font(.system(size: 16))
                                        .bold()
                                        .padding(10)
                                        .foregroundColor(.white)
                                        .frame(minWidth:40, minHeight:40)
                                        .background(.gray.opacity(0.5))
                                        .cornerRadius(14)
                                        .padding(40)
                                }
                                .alert(isPresented:$showingDeleteAlert) {
                                    Alert(
                                        title:Text("Are you sure you want to delete this entry?"),
                                        message:Text("This operation cannot be undone."),
                                        primaryButton: .destructive(Text("I'm sure")) {
                                            modelContext.delete(entry)
                                            dismiss()
                                        },
                                        secondaryButton: .cancel(Text("No, go back"))
                                    )
                                }
                            }
                                .offset(y: -gr.frame(in: .global).origin.y + 20)
                        }
                        .frame(height:350)
                        
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
                            Spacer()
                        }
                            .overlay {
                                GeometryReader { gr2 in
                                    Color.clear.onAppear() {
                                        imageHeight = reader.size.height - abs(-gr2.frame(in:.local).origin.y) + 2 * reader.frame(in: .local).origin.y
                                    }
                                }
                            }
                            .padding()
                            .edgesIgnoringSafeArea(.bottom)
                            /*
                            .frame(minHeight:abs(reader.size.height - 350 + reader.frame(in: .global).origin.y + gr2.frame(in: .global).origin.y))
                            .frame(minHeight:(reader.size.height - abs(-gr2.frame(in:.global).origin.y) + 2 * reader.frame(in: .global).origin.y))
                            .frame(minHeight: abs(-gr2.frame(in:.global).origin.y))
                            https://appbakery.medium.com/passing-geometry-information-to-parent-sibling-views-in-swiftui-c2fff433afc1
                        
                            */
                            .frame(minHeight: reader.size.height - 350 + reader.frame(in: .global).origin.y)
                            .background(.white)
                    }
                    //.frame(maxHeight:.infinity)
                }
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
