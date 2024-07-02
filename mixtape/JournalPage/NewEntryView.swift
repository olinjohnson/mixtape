//
//  NewEntryView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/19/24.
//

import SwiftUI
import SwiftData

struct NewEntryView: View {
    
    enum Fields {
        case title
        case body
    }
    
    @EnvironmentObject var nBar: NBar
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    private let titleCharLimit = 100
    
    @State var inputID = UUID()
    @State var inputTitle = ""
    @State var inputBody = ""
    @State var inputDate = Date()
    @State var inputCover: Data?
    
    @FocusState private var textFieldFocus: Fields?
    @State private var keyboardOffsetAmt = 0
    
    @State var showingCancelAlert = false
    
//    @State var createNavigationReady = false
//    @State var createdEntry: Entry = Entry.empty
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ScrollView {
                    VStack(alignment: .leading) {
                        GeometryReader { gr in
                            ImagePickerView(gr:gr, imageData:self.$inputCover)
                            HStack {
                                VStack(alignment:.leading){
                                    Text("New entry")
                                        .font(.title2)
                                        .bold()
                                        .padding([.bottom], 2)
                                    Text("Add cover image  |  Add text")
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
                                    .onAppear {
                                        if textFieldFocus != .title {
                                            keyboardOffsetAmt = 210
                                        }
                                    }
                                }else{
                                    Button(action:{
                                        textFieldFocus = .body
                                    }) {
                                        Image(systemName: "pencil")
                                            .font(.largeTitle)
                                            .foregroundColor(.blue)
                                    }
                                    .onAppear {
                                        keyboardOffsetAmt = 0
                                    }
                                }
                            }
                            .padding(20)
                            .frame(maxWidth:.infinity)
                            .background(.white.opacity(0.9))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 2, y: 2)
                            .offset(y: -gr.frame(in: .global).origin.y + 60)
                            .padding([.leading, .trailing])
                        }
                        .frame(height:350)
                        
                        VStack {
                            VStack(alignment:.leading) {
                                DatePicker("What date?            \(Image(systemName: "arrow.right"))", selection: $inputDate, displayedComponents: .date)//.labelsHidden()
                                    .padding([.bottom, .top])
                                    .font(.title3)
                                //.bold()
                                Divider()
                                    .padding([.top, .bottom])
                                TextField("Put your title here...", text: $inputTitle, axis:.vertical)
                                    .font(.title)
                                    .bold()
                                    .focused($textFieldFocus, equals:.title)
                                TextField("What would you like to write about today?", text: $inputBody, axis:.vertical)
                                    .focused($textFieldFocus, equals:.body)
                            }
                            .padding([.leading, .trailing, .bottom])
                            
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
                                        primaryButton: .destructive(Text("I'm sure")) {dismiss()},
                                        secondaryButton: .cancel(Text("No, go back"))
                                    )
                                }
                                
                                Button(action:{
                                    let newEntry = Entry(id: inputID, cover: inputCover!, title: inputTitle == "" ? "Untitled entry" : inputTitle, body: inputBody, date: inputDate)
                                    modelContext.insert(newEntry)
                                    do { try modelContext.save() } catch {}
                                    dismiss()
//                                    createNavigationReady = true
                                }) {
                                    Text("Create")
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
//                                    Text("Create")
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
//                                    let newEntry = Entry(id: UUID(), cover: inputCover!, title: inputTitle == "" ? "Untitled entry" : inputTitle, body: inputBody, date: inputDate)
//                                    modelContext.insert(newEntry)
//                                    do { try modelContext.save() } catch {}
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
                }
                //.edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {nBar.isShowing = false})
    }
}

//#Preview {
//    NewEntryView()
//}
