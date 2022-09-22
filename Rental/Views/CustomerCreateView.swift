//
//  CustomerCreateView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/20/22.
//

import SwiftUI

struct CustomerCreateView: View {
    
    @ObservedObject var customerVM: CustomerViewModel
    
    @State private var customer = Customer(id: UUID().hashValue, address: "", city: "", email: "", firstName: "", lastName: "", notes: "", phoneNumber: "", state: "", zip: "", rentals: [String]())
    
    var body: some View {
        ZStack {
            // Set the background
            Color(red: 245/255, green: 245/255, blue: 249/255)
                .edgesIgnoringSafeArea(.all)
            
            Form {
                Section {
                    HStack{
                        VStack {
                            Text("FirstName:")
                                .font(K.Fonts.sectionItem)
                            TextField("", text: $customer.firstName)
                                .padding(.leading)
                            //                        .focused( $nameInFocus )
                                .frame(width: nil, height: 35)
                                .background(Color.gray.opacity(0.3).cornerRadius(10))
                                .font(.headline)
                        }
                        VStack {
                            Text("LastName:")
                                .font(K.Fonts.sectionItem)
                            TextField("", text: $customer.lastName)
                                .padding(.leading)
                            //                        .focused( $nameInFocus )
                                .frame(width: nil, height: 35)
                                .background(Color.gray.opacity(0.3).cornerRadius(10))
                                .font(.headline)
                        }
                    }
                } header: {
                    Text("Name")
                        .font(K.Fonts.sectionHeader)
                    }
                
                Section {
                    Text("Address:")
                        .font(K.Fonts.sectionItem)
                    TextField("", text: $customer.address)
                        .padding(.leading)
                    //                        .focused( $nameInFocus )
                        .frame(width: nil, height: 35)
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .font(.headline)
                    
                    HStack {
                        VStack {
                            Text("City")
                                .font(K.Fonts.sectionItem)
                            TextField("", text: $customer.city)
                                .padding(.leading)
                            //                        .focused( $nameInFocus )
                                .frame(width: nil, height: 35)
                                .background(Color.gray.opacity(0.3).cornerRadius(10))
                                .font(.headline)
                        }
                        
                        VStack {
                            Text("State")
                                .font(K.Fonts.sectionItem)
                            TextField("", text: $customer.state)
                                .padding(.leading)
                            //                        .focused( $nameInFocus )
                                .frame(width: 50, height: 35)
                                .background(Color.gray.opacity(0.3).cornerRadius(10))
                                .font(.headline)
                        }
                        
                        VStack {
                            Text("Zip")
                                .font(K.Fonts.sectionItem)
                            TextField("", text: $customer.zip)
                                .padding(.leading)
                            //                        .focused( $nameInFocus )
                                .frame(width: nil, height: 35)
                                .background(Color.gray.opacity(0.3).cornerRadius(10))
                                .font(.headline)
                        }
                    }
                } header: {
                    Text("Address, City, State, Zip")
                        .font(K.Fonts.sectionHeader)
                    }
                
                Section {
                    Text("Phone:")
                        .font(K.Fonts.sectionItem)
                    TextField("", text: $customer.phoneNumber)
                        .keyboardType(.numberPad)
                        .padding(.leading)
                    //                        .focused( $nameInFocus )
                        .frame(width: nil, height: 35)
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .font(.headline)
                    Text("Email:")
                        .font(K.Fonts.sectionItem)
                    TextField("", text: $customer.email)
                        .keyboardType(.emailAddress)
                        .padding(.leading)
                    //                        .focused( $nameInFocus )
                        .frame(width: nil, height: 35)
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .font(.headline)
                } header: {
                    Text("Comunication")
                        .font(K.Fonts.sectionHeader)
                    }
                Section {
                    Button(action: {customerVM.createCustomer(passedCustomer: customer)},
                           label: {
                        Text("Submit".uppercased())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(30)
                            .foregroundColor(.white)
                            .font(K.Fonts.buttonText.bold())
                    })
                        .padding()
                }
            }
        }
        .padding()
        .navigationTitle("Create Customer")
    }
}

struct CustomerCreateView_Previews: PreviewProvider {
    static var previews: some View {
//        let c = Customer(id: 1, address: "123 City Road", city: "Manfield", email: "KennyBoy@gmail.com", firstName: "Kenneth", lastName: "Chatham", notes: "This is a note", phoneNumber: "8179377432", state: "AL", zip: "35126", rentals: [String]())

        CustomerCreateView(customerVM: CustomerViewModel())
    }
}
