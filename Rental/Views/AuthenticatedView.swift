//
//  AuthenticatedView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/2/22.
//

import SwiftUI

struct AuthenticatedView: View {
    
    @StateObject var customerVm: CustomerViewModel = CustomerViewModel()
    @ObservedObject var loginVM: LoginViewModel
    
    
    //    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        VStack {
            NavigationLink(destination: CustomerView(customerVm: customerVm, loginVm: loginVM)
                .onAppear(perform: {
                    if(customerVm.customerList.isEmpty) {
                        customerVm.getAllCustomers()
                    }
                }),
                           label: {
                ZStack {
                    
                    RectangleCard(color: K.Colors.buttonBlue)
                        .frame(width: 250, height: 85, alignment: .center)
                        .padding()
                    
                    Text("Customers")
                        .foregroundColor(K.Colors.buttonTextWhite)
                        .font(.system(.title2))
                        .bold()
                }
            })
            
            NavigationLink(destination: EmptyView(), label: {
                ZStack {
                    
                    RectangleCard(color: K.Colors.buttonBlue)
                        .frame(width: 250, height: 85, alignment: .center)
                        .padding()
                    
                    Text("Units")
                        .foregroundColor(K.Colors.buttonTextWhite)
                        .font(.system(.title2))
                        .bold()
                }
            })
        }
        .navigationTitle("ManageRentals")
        
    }
}

//struct AuthenticatedView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthenticatedView()
//    }
//}
