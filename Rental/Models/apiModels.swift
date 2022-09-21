//
//  apiModels.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/5/22.
//

import Foundation

class Account: Identifiable, Decodable {
    
    var email: String
    var firstName: String
    var fullName: String
    var id: Int
    var isLockedOut: Bool
    var lastLoginUtc: String
    var lastName: String
    var phoneNumber: String
    var prefersDark: Bool
    var roleName: String
}

class Customer: Identifiable, Decodable, Encodable, ObservableObject {
    var id: Int
    var address: String
    var city: String
    var email: String
    var firstName: String
    var lastName: String
    var notes: String
    var phoneNumber: String
    var state: String
    var zip: String
    var rentals: [String]
    
    init(id: Int, address: String, city: String, email: String, firstName: String, lastName: String, notes: String, phoneNumber: String, state: String, zip: String, rentals: [String]) {
        self.id = id
        self.address = address
        self.city = city
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.notes = notes
        self.phoneNumber = phoneNumber
        self.state = state
        self.zip = zip
        self.rentals = rentals
    }
}

class rentUnit: Identifiable, Decodable, Encodable, ObservableObject {
    var id: Int
    var name: String
    var description: String
    var notes: String
    var rates: [Rate]
    var rentals: [String]
    
    init(description: String, id: Int, name: String, notes: String, rates: [Rate], rentals: [String]) {
        self.id = id
        self.name = name
        self.description = description
        self.notes = notes
        self.rates = [Rate]()
        self.rentals = [String]()
    }
}

struct Rate: Decodable, Encodable {
    var intervalId: Int
    var price: Float
    var intervalName: String
}

