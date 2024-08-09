//
//  EditEntryView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/23/24.
//

import SwiftUI

struct EditEntryView: View {
    
    enum Fields {
        case title
        case body
    }
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) private var dismiss
    private let titleCharLimit = 100
    
    @State private var inputTitle = ""
    @State private var inputBody = ""
    @State private var inputDate = Date()
    @State private var inputCover: Data?
    @State private var inputMedia: [Media] = []
    
    @State private var saveNavigationReady = false
    
    @FocusState private var textFieldFocus: Fields?
//    @State private var keyboardOffsetAmt = 0
    
    @State var showingCancelAlert = false
    
    @Binding var entry: Entry
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ScrollView {
                    VStack(alignment: .leading) {
                        GeometryReader { gr in
                            ImagePickerView(gr:gr, imageData:$inputCover)
                            /*HStack {
                                VStack(alignment:.leading){
                                    Text("Edit entry")
                                        .font(.title2)
                                        .bold()
                                        .padding([.bottom], 2)
                                    Text("Edit cover image  |  Edit text")
                                        .font(.caption)
                                        .foregroundStyle(.black.opacity(0.6))
                                }
                                Spacer()
                                
                                if textFieldFocus == .body || textFieldFocus == .title{
                                    Button(action:{
                                        textFieldFocus = nil
                                    }) {
                                        Text("Done")
                                    }
//                                    .onAppear {
//                                        if textFieldFocus != .title {
//                                            keyboardOffsetAmt = 210
//                                        }
//                                    }
                                }else{
                                    Button(action:{
                                        textFieldFocus = .body
                                    }) {
                                        Image(systemName: "pencil")
                                            .font(.largeTitle)
                                            .foregroundColor(.blue)
                                    }
//                                    .onAppear {
//                                        keyboardOffsetAmt = 0
//                                    }
                                }
                            }
                            .padding(20)
                            .frame(maxWidth:.infinity)
                            .background(.white.opacity(0.9))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 2, y: 2)
                            .offset(y: -gr.frame(in: .global).origin.y + 60)
                            .padding([.leading, .trailing])*/
                        }
                        .frame(height:350)
                        
                        VStack {
                            VStack(alignment:.leading) {
                                DatePicker("Date       \(Image(systemName: "arrow.right"))", selection: $inputDate, displayedComponents: .date)
                                    .labelsHidden()
//                                    .padding([.bottom, .top])
                                    .font(.title3)
                                    .padding(.bottom, 5)
                                //.bold()
//                                Divider()
//                                    .padding([.top, .bottom])
                                TextField("", text: $inputTitle, axis:.vertical)
                                    .font(.title)
                                    .bold()
                                    .focused($textFieldFocus, equals:.title)
                                TextField(inputBody.count > 0 ? inputBody : "There's nothing here yet.", text: $inputBody, axis:.vertical)
                                    .focused($textFieldFocus, equals:.body)
                            }
                            .padding([.leading, .trailing])
                            
                            MediaSelectorView(media: $inputMedia)
                                .padding(.top, 35)
                                .padding(.bottom, 10)
                            
                            Spacer()
                            
                            // Bottom Buttons
                            HStack {
                                Button(action:{showingCancelAlert = true}) {
                                    Text("Cancel")
                                        .padding()
                                        .frame(maxWidth:.infinity)
                                        .background(.red)
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .font(.title3)
                                        .bold()
                                }
                                .shadow(color: .black.opacity(0.2), radius: 8, x: 1, y: 1)
                                .alert(isPresented:$showingCancelAlert) {
                                    Alert(
                                        title:Text("Are you sure you want to cancel?"),
                                        message:Text("Your changes will not be saved."),
                                        primaryButton: .destructive(Text("I'm sure")) {saveNavigationReady = true},
                                        secondaryButton: .cancel(Text("No, go back"))
                                    )
                                }
                                
                                Button(action:{
                                    modelContext.delete(entry)
                                    entry = Entry(id: entry.id, cover: inputCover!, title: inputTitle == "" ? "Untitled entry" : inputTitle, body: inputBody, date: inputDate, media: inputMedia)
                                    modelContext.insert(entry)
                                    do { try modelContext.save() } catch {}
                                    saveNavigationReady = true
                                }) {
                                    Text("Save")
                                        .padding()
                                        .frame(maxWidth:.infinity)
                                        .background(.green)
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .font(.title3)
                                        .bold()
                                }
                                .shadow(color: .black.opacity(0.2), radius: 8, x: 1, y: 1)
                                
//                                NavigationLink(destination:JournalView().toolbar(.visible, for: .tabBar)) {
//                                    Text("Save")
//                                        .padding()
//                                        .frame(maxWidth:.infinity)
//                                        .background(.green)
//                                        .cornerRadius(10)
//                                        .foregroundColor(.white)
//                                        .font(.title3)
//                                        .bold()
//                                        .shadow(color: .black.opacity(0.2), radius: 8, x: 1, y: 1)
//                                }
//                                .simultaneousGesture(TapGesture().onEnded {
//                                    do {
//                                        try modelContext.save()
//                                    } catch {dismiss()}
//                                })
                            }
                        }
                        .padding()
                        .background(.white)
                        // Cover image box
                        // add music
                    }
                    //.offset(y:CGFloat(-keyboardOffsetAmt))
                    .frame(minHeight: reader.size.height)
                    .navigationDestination(isPresented: $saveNavigationReady, destination: {
                        EntryDetailView(entry: entry)
                    })
                }
                //.edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack{
                    Spacer()
                    Button("Done") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
        }
        .onAppear(perform: {
            inputCover = entry.cover
            inputTitle = entry.title
            inputBody = entry.body
            inputDate = entry.date
            
            // creates a deep copy of entry.media
            for snippet in entry.media {
                if snippet.song != nil {
                    inputMedia.append(Media(song: snippet.song))
                } else if snippet.image != nil {
                    inputMedia.append(Media(image: snippet.image))
                }

            }
        })
    }
}

//#Preview {
//    EditEntryView()
//}
