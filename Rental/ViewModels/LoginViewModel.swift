//
//  LoginViewModel.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/2/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var rememberMe: Bool = true
    @Published var isAuthenticated: Bool = false
    
    init() {
        
    }
    
    func login() {
        
        let defaults = UserDefaults.standard
        
//        WebService().login(email: email.lowercased(), password: password, rememberMe: rememberMe) { result in
        WebService().login(email: "kevin@machdata.com", password: "Test@123", rememberMe: true) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "jsonWebToken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signout() {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonWebToken")
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
    
}
