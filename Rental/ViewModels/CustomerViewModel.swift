//
//  CustomerViewModel.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/5/22.
//

import Foundation

class CustomerViewModel: ObservableObject {
    
    @Published var customerList = [Customer]()
    
    init() {
    }
    
    func getAllCustomers() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonWebToken") else {
            return
        }
        
        WebService().getAllCustomers(token: token) { (result) in
            switch result {
            case .success(let customer):
                DispatchQueue.main.async {
//                    self.customerList = customer.map(CustomerListViewModel.init)
                    self.customerList = customer
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    struct CustomerListViewModel: Identifiable {
        let customer: Customer
        let id = UUID()

        var fullName: String {
            return (customer.firstName + " " + customer.lastName)
        }

        var address: String {
            return customer.address
        }

        var city: String {
            return customer.city
        }

        var email: String {
            return customer.email
        }

        var firstName: String {
            return customer.firstName
        }

        var lastName: String {
            return customer.lastName
        }

        var notes: String {
            return customer.notes
        }

        var phoneNumber: String {
            return customer.phoneNumber
        }

        var state: String {
            return customer.state
        }

        var zip: String {
            return customer.zip
        }

        var rentals: [String] {
            return customer.rentals
        }
    }
}

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}
