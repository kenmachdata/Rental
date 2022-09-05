//
//  ContentView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Image("rentimg")
                    .resizable()
                //.scaledToFit()
                //.scaledToFill()
                    .frame(width: 300, height: 300)
                //.clipped()
                    .clipShape(
                        //Circle()
                        RoundedRectangle(cornerRadius: 55)
                        //Ellipse()
                    )
                //.cornerRadius(25)
                    .padding(.top, 60.0)
                
                Spacer()
                
                NavigationLink(destination:
                                loginVM.isAuthenticated == true ? AnyView(AuthenticatedView(loginVM: loginVM)):
                                 AnyView(LoginView(loginVM: loginVM)), label: {
                    ZStack {
                        
                        RectangleCard(color: Color.blue)
                            .frame(width: 250, height: 85, alignment: .center)
                            .padding()
                        
                        Text(loginVM.isAuthenticated ? "Manage" : "LogIn")
                            .foregroundColor(Color.white)
                            .font(.system(.title2))
                            .bold()
                    }
                })
            }
            .navigationBarHidden(true)
        }
//        .navigationViewStyle(.stack)
        .accentColor(Color(.label))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
