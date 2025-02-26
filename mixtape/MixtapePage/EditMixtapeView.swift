//
//  EditMixtapeView.swift
//  mixtape
//
//  Created by Olin Johnson on 8/3/24.
//

import SwiftUI

struct EditMixtapeView: View {
    
    enum Fields {
        case title
        case heading
        case body
    }
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    private let titleCharLimit = 100
    
    @State var inputTitle = "Untitled Mixtape"
    @State var inputHeading = ""
    @State var inputBody = ""
    @State var inputDate = Date()
    @State var inputCover: Data?
    @State var inputTracks: [Song] = []
    
    @State private var saveNavigationReady = false
    
    @FocusState private var textFieldFocus: Fields?
//    @State private var keyboardOffsetAmt = 0
    
    @State var showingCancelAlert = false
    
    @Binding var mixtape: Tape
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ScrollView {
                    VStack(alignment: .leading) {
                        GeometryReader { gr in
                            ImagePickerView(gr:gr, imageData:self.$inputCover)
                                .overlay {
                                    HStack {
                                        VStack {
                                            Spacer()
                                            TextField("Untitled Mixtape", text: $inputTitle, axis:.vertical)
                                                .foregroundStyle(.white)
                                                .font(.largeTitle)
                                                .bold()
                                                .padding(20)
                                                .padding([.leading, .trailing], 6)
                                                .multilineTextAlignment(.leading)
                                                .shadow(color:.black.opacity(0.2), radius:3, x:0, y:0)
                                                .focused($textFieldFocus, equals:.title)
                                        }
                                        Spacer()
                                    }
                                    .offset(y: -gr.frame(in: .global).origin.y)
                                }
                            /*ImagePickerView(gr:gr)*/
                            /*
                            HStack {
                                VStack(alignment:.leading){
                                    Text("Edit mixtape")
                                        .font(.title2)
                                        .bold()
                                        .padding([.bottom], 2)
                                    Text("Edit cover image  |  Edit text  |  Edit music")
                                        .font(.caption)
                                        .foregroundStyle(.black.opacity(0.6))
                                }
                                Spacer()
                                
                                if textFieldFocus == .body || textFieldFocus == .heading || textFieldFocus == .title{
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
                            .padding([.leading, .trailing])
                             */
                        }
                        .frame(height:350)
                            
                        
                        VStack {
                            VStack(alignment:.leading) {
                                DatePicker("Date       \(Image(systemName: "arrow.right"))", selection: $inputDate, displayedComponents: .date)
                                    .labelsHidden()
//                                    .padding([.bottom, .top], 5)
                                    .font(.title3)
                                    .padding(.bottom, 5)
                                //.bold()
//                                Divider()
//                                    .padding([.top, .bottom])
                                TextField("", text: $inputHeading, axis:.vertical)
                                    .font(.title)
                                    .bold()
                                    .focused($textFieldFocus, equals:.heading)
                                TextField("Write about your mixtape here...", text: $inputBody, axis:.vertical)
                                    .focused($textFieldFocus, equals:.body)
//                                    .padding(.bottom, 40)
                                Text("Tracks")
                                    .font(.title3)
                                    .bold()
                                    .padding(.top, 40)
                            }
                            .padding([.leading, .trailing])
                            
                            TracksSelectorView(tracks: self.$inputTracks)
                            // ADD TRACKS BUTTON
                            
                            Spacer()
                            
                            // Bottom buttons
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
                                        primaryButton: .destructive(Text("I'm sure")) {
//                                            dismiss()
                                            saveNavigationReady = true
                                        },
                                        secondaryButton: .cancel(Text("No, go back"))
                                    )
                                }
                                Button(action:{
                                    modelContext.delete(mixtape)
                                    mixtape = Tape(id: mixtape.id, cover: inputCover!, date: inputDate, title: inputTitle.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "Untitled Mixtape" : inputTitle, heading: inputHeading.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "Untitled Mixtape" : inputHeading, body: inputBody.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "There's nothing here yet" : inputBody, songs: [])
                                    mixtape.songs = inputTracks
                                    modelContext.insert(mixtape)
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
                            }
                            .padding([.top])
                        }
                        .padding()
                        .background(.white)
                    }
                    .frame(minHeight: reader.size.height)
//                    .offset(y:CGFloat(-keyboardOffsetAmt))
                    .navigationDestination(isPresented: $saveNavigationReady, destination: {
                        MixtapeDetailView(mixtape: mixtape).toolbar(.hidden, for: .tabBar)
                    })
                }
                //.edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            inputTitle = mixtape.title
            inputHeading = mixtape.heading
            inputBody = mixtape.body
            inputDate = mixtape.date
            inputCover = mixtape.cover
//            inputTracks = mixtape.songs
            for song in mixtape.songs ?? [] {
                inputTracks.append(Song(id: song.id, cover: song.cover, artist: song.artist, name: song.name, order: song.order, caption: song.caption))
            }
        })
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
    }
}

//#Preview {
//    EditMixtapeView()
//}
