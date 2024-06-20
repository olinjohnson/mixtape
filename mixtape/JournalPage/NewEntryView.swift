//
//  NewEntryView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/19/24.
//

import SwiftUI

struct NewEntryView: View {
    enum Fields {
        case title
        case body
    }
    
    @Environment(\.dismiss) private var dismiss
    private let titleCharLimit = 100
    
    @State var inputTitle = ""
    @State var inputBody = ""
    @State var inputDate = Date()
    
    @FocusState private var textFieldFocus: Fields?
    @State private var keyboardOffsetAmt = 0
    
    @State var showingCancelAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        GeometryReader { gr in
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                                Image("ed_sheeran")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: gr.size.width, height: gr.size.height + max(0, gr.frame(in: .global).origin.y))
                                    .offset(y: -gr.frame(in: .global).origin.y)
                            }
                        }
                        .frame(height:400)
                        VStack {
                            VStack(alignment:.leading) {
                                DatePicker("What date?       \(Image(systemName: "arrow.right"))", selection: $inputDate, displayedComponents: .date)//.labelsHidden()
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
                            .padding([.leading, .trailing])
                        }
                        .padding()
                        .background(.white)
                        // Cover image box
                        // add music
                    }
                    .offset(y:CGFloat(-keyboardOffsetAmt))
                }
                .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        VStack(alignment:.leading){
                            Text("Click text to edit")
                                .font(.title2)
                                .bold()
                            Text("Bottom buttons to create or cancel")
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
                        
                        Button(action:{}) {
                            NavigationLink(destination:JournalView().toolbar(.visible, for: .tabBar)) {
                                Text("Create")
                                    .padding()
                                    .frame(maxWidth:.infinity)
                                    .background(.green)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                            }
                        }
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 1, y: 1)
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NewEntryView()
}
