//
//  CustomerDetailView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/5/22.
//

import SwiftUI

struct CustomerDetailView: View {
    
    @State var customer: Customer
    
    /// Whether the user is focused on this `TextField`.
    @State private var isEditing: Bool = false
    
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
                    Text("First Name: \(customer.firstName)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    TextField("First Name", text: $customer.firstName, onEditingChanged: {edit in
                        self.isEditing = edit})
//                    .textFieldStyle(MyTextFieldStyle(focused: $isEditing)).font(.title).border(Color.blue)
                    
                    .modifier(customViewModifier(focused: $isEditing, roundedCornes: 6, startColor: Color(red: 153 / 255.0, green: 204 / 255.0, blue: 255 / 255.0), endColor: Color(red: 51 / 255.0, green: 153 / 255.0, blue: 255 / 255.0), textColor: .black, horizontalPad: 10, verticalPad: 3))

//                        .modifier(customViewModifier(roundedCornes: 6, startColor: Color(red: 163 / 255.0, green: 243 / 255.0, blue: 7 / 255.0), endColor: Color(red: 226 / 255.0, green: 247 / 255.0, blue: 5 / 255.0), textColor: .black, horizontalPad: 10, verticalPad: 3))

                    Text("Last Name: \(customer.lastName)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    TextField("Last Name", text: $customer.lastName)
                } header: {
                    Text("Edit Name")
                        .font(Font.custom("Avenir", size: 14))
                }
                
                Section {
                    Text("Address: \(customer.address)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    TextField("Address", text: $customer.address)
                    Text("City: \(customer.city)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    TextField("City", text: $customer.city)
                    Text("State: \(customer.state)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    TextField("State", text: $customer.state)
                    Text("Zip: \(customer.zip)")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    TextField("Zip", text: $customer.zip)
                } header: {
                    Text("Edit Address")
                        .font(Font.custom("Avenir", size: 14))
                }
                
                Section {
                    Text("Phone: \(customer.phoneNumber.applyPatternOnNumbers(pattern: "(###) ###-####", replacementCharacter: "#"))")
                        .font(Font.custom("Avenir Heavy", size: 18))
                    TextField("Phone Number: ", text: $customer.phoneNumber)
                    
                    //                Text("Rentals: \(customerVM.rentals[0])")
                }header: {
                    Text("Edit Phone")
                        .font(Font.custom("Avenir", size: 14))
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
