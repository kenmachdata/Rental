//
//  CustomerViewModel.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/5/22.
//

import Foundation

class CustomerViewModel: ObservableObject {
    
    @Published var customerList = [Customer]()
    
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
    
    func createCustomer(passedCustomer: Customer) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonWebToken") else {
            return
        }
        
        // "Thursday, September 22, 2022 at 3:54:55 PM Central Daylight Time"
        passedCustomer.notes = "\(passedCustomer.firstName) \(passedCustomer.lastName) Joined us on: \( Date().mediumDateTime)"
        
        WebService().createCustomer(token: token, customer: passedCustomer) { (result) in
            switch result {
            case .success(let customer):
                print(customer.firstName)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateCustomer(selectedCustomer: Customer) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonWebToken") else {
            return
        }
        
        WebService().patchCustomer(token: token, customer: selectedCustomer) { (result) in
            switch result {
            case .success(let customer):
                print(customer.firstName)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
