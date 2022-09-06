//
//  CustomerDetailView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/5/22.
//

import SwiftUI

struct CustomerDetailView: View {
    
    @State var customer: Customer
    
    @ObservedObject var customerVM: CustomerViewModel
    
//    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        VStack {
            Form {
                Section {
                    Text("\(customer.firstName + " " + customer.lastName)")
                        .font(Font.custom("Avenir Heavy", size: 24))
                }
                Section {
                    TextField("First Name: ", text: $customer.firstName)
                        .font(Font.custom("Avenir Heavy", size: 18))
                    Text("First Name: \(customer.firstName)")
                    Text("Last Name: \(customer.lastName)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                }
                Section {
                    Text("Address: \(customer.address)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    Text("City: \(customer.city)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    Text("State: \(customer.state)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    Text("Zip: \(customer.zip)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                }
                Section {
                    Text("Phone: \(customer.phoneNumber.applyPatternOnNumbers(pattern: "(###) ###-####", replacementCharacter: "#"))")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    //                Text("Rentals: \(customerVM.rentals[0])")
                }
            }
            Button(action: {
                self.customerVM.objectWillChange.send()
            }, label: {
                Text("Submit")
                    .frame(width: 250,
                           height: 50,
                           alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
            .padding()
        }
        .navigationTitle("Customer Detail")
    }
}


//struct CustomerDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomerDetailView(customer: Customer)
//    }
//}
