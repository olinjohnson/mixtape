//
//  FormButtonsView.swift
//  mixtape
//
//  Created by Olin Johnson on 6/20/24.
//

import SwiftUI

struct FormButtonsView: View {
    
    @State var showingCancelAlert = false
    let dismiss: DismissAction
    let destination: AnyView
    
    var body: some View {
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
                NavigationLink(destination:destination.toolbar(.visible, for: .tabBar)) {
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
}

//#Preview {
//    FormButtonsView()
//}
