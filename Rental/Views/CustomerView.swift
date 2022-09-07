//
//  CustomerView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/5/22.
//

import SwiftUI

struct CustomerView: View {
    
    @ObservedObject var customerVm: CustomerViewModel
    @ObservedObject var loginVm: LoginViewModel
    
    
//    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        VStack {
            if loginVm.isAuthenticated && !customerVm.customerList.isEmpty {
                
                HStack {
                    Text("Customer:")
                        .fontWeight(.bold)
                        .padding(.leading, 20.0)
                        .padding(.vertical, 0)
                        .font(K.Fonts.sectionTitle)
                    Spacer()
                    Text("Phone:")
                        .fontWeight(.bold)
                        .padding(.trailing, 40.0)
                        .padding(.vertical, 0)
                        .font(K.Fonts.sectionTitle)
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(customerVm.customerList) { customer in
                            
                            NavigationLink(
                                destination: CustomerDetailView(customer: customer, customerVM: customerVm),
                                label: {
                                    
                                    // MARK: Row item
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(customer.firstName + " " + customer.lastName)
                                            Spacer()
                                            Text(customer.phoneNumber.applyPatternOnNumbers(pattern: "(###) ###-####", replacementCharacter: "#"))
                                        }
                                        .foregroundColor(K.Colors.buttonBlue)
                                        .font(K.Fonts.link)
                                        .padding(.horizontal)
                                        .padding(.vertical, 2)
                                    }
                                }
                            )
                        }
                    }
                }
            }
        }
        .navigationTitle("ManageCustomers")
    }
}

//struct CustomerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomerView()
//    }
//}
