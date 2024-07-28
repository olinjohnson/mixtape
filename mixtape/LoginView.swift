//
//  LoginView.swift
//  mixtape
//
//  Created by Olin Johnson on 2/23/24.
//

import SwiftUI
import Auth0
import JWTDecode

struct LoginView: View {
    
    @Binding var isAuthenticated: Bool
    @Binding var userProfile: User
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(alignment: .center) {
                    Spacer()
                    VStack {
                        Text("Welcome to Mixtape")
                            .font(.largeTitle)
                            .bold()
                            .padding([.bottom], 4)
                        Text("Log in or create an account to continue")
                            .padding([.bottom], 40)
                        Button(action:{
                            //login()
                            self.isAuthenticated = true
                        }) {
                            Text("Log in")
                                .font(.title2)
                                .bold()
                                .frame(maxWidth:.infinity, minHeight: 50)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding([.top])
                        
                        HStack{
                            VStack {
                                Divider()
                                    .background(.black)
                                    .frame(height:1)
                                    .overlay(.black)
                                    .padding([.leading, .trailing], 20)
                            }
                            Text("or")
                                .bold()
                                .padding(10)
                            VStack{
                                Divider()
                                    .background(.black)
                                    .frame(height:1)
                                    .overlay(.black)
                                    .padding([.leading, .trailing], 20)
                            }
                        }
                        
                        Button(action:{
                            login(["screen_hint": "signup"])
                        }) {
                            Text("Create an account")
                                .font(.title2)
                                .bold()
                                .frame(maxWidth:.infinity, minHeight: 50)
                                .background(.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

extension LoginView {
    private func login(_ parameters: [String : String] = ["" : ""]) {
        Auth0
            .webAuth()
            .parameters(parameters)
            .start { result in
                switch result {
                    case .failure(let error):
                        print("Failed with \(error)")
                    case .success(let credentials):
                    self.userProfile = User.from(credentials.idToken)
                        self.isAuthenticated = true
                }
            }
    }
}


//#Preview {
//    LoginView(isAuthenticated: false)
//}
