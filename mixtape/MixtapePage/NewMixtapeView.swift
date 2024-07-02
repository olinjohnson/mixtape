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
    
    @EnvironmentObject var nBar: NBar
    @Environment(\.dismiss) private var dismiss
    private let titleCharLimit = 100
    
    @State var inputTitle = "Untitled Mixtape"
    @State var inputHeading = ""
    @State var inputBody = ""
    @State var inputDate = Date()
    
    @FocusState private var textFieldFocus: Fields?
    @State private var keyboardOffsetAmt = 0
    
    @State var showingCancelAlert = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { reader in
                ScrollView {
                    VStack(alignment: .leading) {
                        GeometryReader { gr in
                            /*ImagePickerView(gr:gr)
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
                                }*/
                            HStack {
                                VStack(alignment:.leading){
                                    Text("New entry")
                                        .font(.title2)
                                        .bold()
                                        .padding([.bottom], 2)
                                    Text("Add an image  |  Add text  | Add music")
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
                            .offset(y: -gr.frame(in: .global).origin.y + 60)
                            .padding([.leading, .trailing])
                        }
                        .frame(height:350)
                            
                        
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
                            .padding([.leading, .trailing, .bottom])
                            
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
                                        primaryButton: .destructive(Text("I'm sure")) {dismiss()},
                                        secondaryButton: .cancel(Text("No, go back"))
                                    )
                                }
                                //TODO: UPDATE THIS BUTTON FUNCTIONALITY (MAKE SURE IT SWIPES THE RIGHT DIRECTION) WHEN MIXTAPE SAVING IS IMPLEMENTED
                                Button(action:{self.dismiss()}) {
                                    //NavigationLink(destination:MixtapesView().toolbar(.visible, for: .tabBar)) {
                                        Text("Create")
                                            .padding()
                                            .frame(maxWidth:.infinity)
                                            .background(.green)
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                            .font(.title3)
                                            .bold()
                                    //}
                                }
                                .shadow(color: .black.opacity(0.2), radius: 8, x: 1, y: 1)
                            }
                            .padding([.top])
                        }
                        .padding()
                        .background(.white)
                    }
                    .frame(minHeight: reader.size.height)
                    .offset(y:CGFloat(-keyboardOffsetAmt))
                }
                //.edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {nBar.isShowing = false})
    }
}

//#Preview {
//    NewMixtapeView()
//}
