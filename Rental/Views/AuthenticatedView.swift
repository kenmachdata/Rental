//
//  AuthenticatedView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/2/22.
//

import SwiftUI

struct AuthenticatedView: View {
    
    @StateObject var customerVm: CustomerViewModel = CustomerViewModel()
    @StateObject var unitVm: UnitViewModel = UnitViewModel()
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
                    
                    Text("Customers".uppercased())
                        .foregroundColor(K.Colors.buttonTextWhite)
                        .font(K.Fonts.buttonText.bold())
                }
            })
            
            NavigationLink(destination: UnitView(unitVm: unitVm, customerVm: customerVm, loginVm: loginVM)
                .onAppear(perform: {
                    if unitVm.unitList.isEmpty {
                        unitVm.getAllUnits()
                    }
                }), label: {
                
                ZStack {
                    
                    RectangleCard(color: K.Colors.buttonBlue)
                        .frame(width: 250, height: 85, alignment: .center)
                        .padding()
                    
                    Text("Units".uppercased())
                        .foregroundColor(K.Colors.buttonTextWhite)
                        .font(K.Fonts.buttonText.bold())
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
