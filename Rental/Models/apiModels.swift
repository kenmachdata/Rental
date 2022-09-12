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
}

class rentUnit: Identifiable, Decodable, Encodable, ObservableObject {
    var description: String
    var id: Int
    var name: String
    var notes: String
    var rates: [Rate]
    var rentals: [String]
}

struct Rate: Decodable, Encodable {
    var price: Float
    var intervalId: Int
    var intervalName: String
}
