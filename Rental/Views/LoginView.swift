//
//  LoginView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/2/22.
//

import SwiftUI

struct AuthView: View {
    
    var body: some View {
        
        VStack {
            Text("This is my test view")
            
        }.navigationTitle("Test Auth")
    }
    
    
}


struct LoginView: View {
    
    @ObservedObject var loginVM: LoginViewModel
    
    var body: some View {
        
        VStack {
            Form {
                HStack {
                    Spacer()
                    Image(systemName: loginVM.isAuthenticated ? "lock.fill": "lock.open")
                }
                TextField("Email", text: $loginVM.email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    
                
                SecureField("Password", text: $loginVM.password)
                HStack {
                    Spacer()
                    Button("Login") {
                        loginVM.login()
                    }
                    Spacer()
                    Button("Signout") {
                        loginVM.signout()
                    }
                    Spacer()
                    Text("State: \(loginVM.isAuthenticated ? "True":"False")")
                }
//
//                NavigationLink(destination: authenticatedView(), isActive: $loginVM.isAuthenticated, label: {
//                    Text("")
//                })
                
//                if loginVM.isAuthenticated {
//
//                    AnyView(authenticatedView())
                    
//                    NavigationLink(destination: authenticatedView(),
//                                   label: {
//                        ZStack {
//
//                            RectangleCard(color: Color.green)
//                                .frame(height: 50)
//                                .padding()
//
//                            Text("Customers")
//                                .foregroundColor(Color.white)
//                                .font(.system(.title2))
//                                .bold()
//                        }
//                    })
//                }
            }.buttonStyle(PlainButtonStyle())
        }
        .navigationTitle("Rentals Login")
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginVM: LoginViewModel())
    }
}
