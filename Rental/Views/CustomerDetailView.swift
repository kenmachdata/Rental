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
                        .font(K.Fonts.sectionTitle)
                }
               
                Section {
                    Text("First Name: \(customer.firstName)")
                        .font(K.Fonts.sectionItem)
                    TextField("First Name", text: $customer.firstName, onEditingChanged: {edit in
                        self.isEditing = edit})
//                    .textFieldStyle(MyTextFieldStyle(focused: $isEditing)).font(.title).border(Color.blue)
                    
                    .modifier(customViewModifier(focused: $isEditing,
                                                 roundedCornes: 6,
                                                 startColor: K.Colors.gradientStartBlue,
                                                 endColor: K.Colors.gradientEndBlue,
                                                 textColor: .black,
                                                 horizontalPad: 10,
                                                 verticalPad: 3))

//                        .modifier(customViewModifier(roundedCornes: 6, startColor: Color(red: 163 / 255.0, green: 243 / 255.0, blue: 7 / 255.0), endColor: Color(red: 226 / 255.0, green: 247 / 255.0, blue: 5 / 255.0), textColor: .black, horizontalPad: 10, verticalPad: 3))

                    Text("Last Name: \(customer.lastName)")
                        .font(K.Fonts.sectionItem)
                    TextField("Last Name", text: $customer.lastName, onEditingChanged: {edit in
                        self.isEditing = edit})
                    .modifier(customViewModifier(focused: $isEditing,
                                                 roundedCornes: 6,
                                                 startColor: K.Colors.gradientStartBlue,
                                                 endColor: K.Colors.gradientEndBlue,
                                                 textColor: .black,
                                                 horizontalPad: 10,
                                                 verticalPad: 3))
                } header: {
                    Text("Edit Name")
                        .font(K.Fonts.sectionHeader)
                }
                
                Section {
                    Text("Address: \(customer.address)")
                        .font(K.Fonts.sectionItem)
                    TextField("Address", text: $customer.address, onEditingChanged: {edit in
                        self.isEditing = edit})
                        .modifier(customViewModifier(focused: $isEditing,
                                                     roundedCornes: 6,
                                                     startColor: K.Colors.gradientStartBlue,
                                                     endColor: K.Colors.gradientEndBlue,
                                                     textColor: .black,
                                                     horizontalPad: 10,
                                                     verticalPad: 3))
                    Text("City: \(customer.city)")
                        .font(K.Fonts.sectionItem)
                    TextField("City", text: $customer.city, onEditingChanged: {edit in
                        self.isEditing = edit})
                        .modifier(customViewModifier(focused: $isEditing,
                                                     roundedCornes: 6,
                                                     startColor: K.Colors.gradientStartBlue,
                                                     endColor: K.Colors.gradientEndBlue,
                                                     textColor: .black,
                                                     horizontalPad: 10,
                                                     verticalPad: 3))
                    Text("State: \(customer.state)")
                        .font(K.Fonts.sectionItem)
                    TextField("State", text: $customer.state, onEditingChanged: {edit in
                        self.isEditing = edit})
                        .modifier(customViewModifier(focused: $isEditing,
                                                     roundedCornes: 6,
                                                     startColor: K.Colors.gradientStartBlue,
                                                     endColor: K.Colors.gradientEndBlue,
                                                     textColor: .black,
                                                     horizontalPad: 10,
                                                     verticalPad: 3))
                    Text("Zip: \(customer.zip)")
                        .font(K.Fonts.sectionItem)
                    TextField("Zip", text: $customer.zip, onEditingChanged: {edit in
                        self.isEditing = edit})
                        .modifier(customViewModifier(focused: $isEditing,
                                                     roundedCornes: 6,
                                                     startColor: K.Colors.gradientStartBlue,
                                                     endColor: K.Colors.gradientEndBlue,
                                                     textColor: .black,
                                                     horizontalPad: 10,
                                                     verticalPad: 3))
                } header: {
                    Text("Edit Address")
                        .font(K.Fonts.sectionHeader)
                }
                
                Section {
                    Text("Phone: \(customer.phoneNumber.applyPatternOnNumbers(pattern: "(###) ###-####", replacementCharacter: "#"))")
                        .font(K.Fonts.sectionItem)
                    TextField("Phone Number: ", text: $customer.phoneNumber, onEditingChanged: {edit in
                        self.isEditing = edit})
                        .modifier(customViewModifier(focused: $isEditing,
                                                     roundedCornes: 6,
                                                     startColor: K.Colors.gradientStartBlue,
                                                     endColor: K.Colors.gradientEndBlue,
                                                     textColor: .black,
                                                     horizontalPad: 10,
                                                     verticalPad: 3))
                    
                    //                Text("Rentals: \(customerVM.rentals[0])")
                }header: {
                    Text("Edit Phone")
                        .font(K.Fonts.sectionHeader)
                }
            }
            Button(action: {
                self.customerVM.objectWillChange.send()
                self.isEditing = false
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
