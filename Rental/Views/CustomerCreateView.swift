//
//  CustomerCreateView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/20/22.
//

import SwiftUI

struct CustomerCreateView: View {
    @ObservedObject var customerVM: CustomerViewModel
    @State var customer: Customer
    
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
                        .keyboardType(.phonePad)
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
                    Button(action: {},
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
    }
}

struct CustomerCreateView_Previews: PreviewProvider {
    static var previews: some View {
        let c = Customer(id: 1, address: "123 City Road", city: "Manfield", email: "KennyBoy@gmail.com", firstName: "Kenneth", lastName: "Chatham", notes: "This is a note", phoneNumber: "8179377432", state: "AL", zip: "35126", rentals: [String]())

        CustomerCreateView(customerVM: CustomerViewModel(), customer: c)
    }
}


//// Setup the fields
//HStack{
//    VStack(alignment:.leading) {
//        Text("FirstName:")
//            .font(K.Fonts.sectionItem)
//            .multilineTextAlignment(.leading)
//            .padding(.leading, 12.0)
//            .padding(.bottom, 0)
//        TextField("", text: $customer.firstName)
//            .frame(width: nil, height: 35)
//            .background(Color(.white))
//            .font(K.Fonts.sectionTitle)
//            .multilineTextAlignment(.leading)
//            .cornerRadius(22)
//            .padding(.top, 0)
//    }
//    VStack(alignment:.leading) {
//        Text("LastName:")
//            .font(K.Fonts.sectionItem)
//            .multilineTextAlignment(.leading)
//            .padding(.leading, 12.0)
//            .padding(.bottom, 0)
//        TextField("", text: $customer.lastName)
//            .frame(width: nil, height: 35)
//            .background(Color(.white))
//            .font(K.Fonts.sectionTitle)
//            .multilineTextAlignment(.leading)
//            .cornerRadius(22)
//    }
//}
//.padding()
