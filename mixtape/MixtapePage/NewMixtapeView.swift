//
//  NewMixtapeView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/22/24.
//

import SwiftUI

struct NewMixtapeView: View {
    enum Fields {
        case title
        case heading
        case body
    }
    
    @Environment(\.dismiss) private var dismiss
    private let titleCharLimit = 100
    
    @State var inputTitle = "Title goes here"
    @State var inputHeading = "Put your heading here..."
    @State var inputBody = "Write about your mixtape here..."
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
                                    .overlay {
                                        HStack {
                                            VStack {
                                                Spacer()
                                                TextField("Title goes here", text: $inputTitle, axis:.vertical)
                                                    .foregroundStyle(.white)
                                                    .font(.largeTitle)
                                                    .bold()
                                                    .padding(20)
                                                    .padding([.leading, .trailing], 6)
                                                    .multilineTextAlignment(.leading)
                                                    .shadow(color:.black.opacity(0.4), radius:6, x:2, y:2)
                                                    .focused($textFieldFocus, equals:.title)
                                            }
                                            Spacer()
                                        }
                                    }
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
                                TextField("Put your heading here...", text: $inputHeading, axis:.vertical)
                                    .font(.title)
                                    .bold()
                                    .focused($textFieldFocus, equals:.heading)
                                TextField("Write about your mixtape here...", text: $inputBody, axis:.vertical)
                                    .focused($textFieldFocus, equals:.body)
                                Text("Tracks")
                                    .font(.title3)
                                    .bold()
                                    .padding(.top, 26)
                            }
                            .padding([.leading, .trailing])
                            
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
                                        primaryButton: .destructive(Text("I'm sure")) {dismiss()},
                                        secondaryButton: .cancel(Text("No, go back"))
                                    )
                                }
                                
                                Button(action:{}) {
                                    NavigationLink(destination:MixtapesView().toolbar(.visible, for: .tabBar)) {
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
                        
                        if textFieldFocus == .body || textFieldFocus == .heading || textFieldFocus == .title{
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
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NewMixtapeView()
}
