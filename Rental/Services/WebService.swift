//
//  WebService.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/2/22.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
    let rememberMe: Bool
}

struct LoginResponse: Codable {
    let isAuthSuccessful: Bool?
    let errorMessage: String?
    let token: String?
}
    
struct CustomerRequestBody: Codable {
    let email: String
    let password: String
    let rememberMe: Bool
}
    

class WebService: ObservableObject {
    
    // Login Function authenticate to the Rental API
    func login(email: String, password: String, rememberMe: Bool, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "http://localhost:5000/api/authentication/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: email, password: password, rememberMe: rememberMe)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
            
        }.resume()
        
    }
    
    // Request the API reveal all the Customers
    func getAllCustomers(token: String, completion: @escaping (Result<[Customer], NetworkError>) -> Void) {
        
        // Construct the URL
        guard let url = URL(string: "http://localhost:5000/api/customers/all") else {
            completion(.failure(.invalidURL))
            return
        }
        
        // Build the request
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        // Get the session and kick off the task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let customers = try? JSONDecoder().decode([Customer].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(customers))
            
        }.resume()
    }
    
//    // Request the Rental API reveal all the units
//    func getAllUnits(token: String, completion: @escaping (Result<[rentUnit], NetworkError>) -> Void) {
//        
//        // Construct the URL
//        guard let url = URL(string: "http://localhost:5000/api/units/all") else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        // Build the request
//        var request = URLRequest(url: url)
//        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        request.httpMethod = "GET"
//        
//        // Get the session and kick off the task
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            
//            guard let data = data, error == nil else {
//                completion(.failure(.noData))
//                return
//            }
//            
//            guard let units = try? JSONDecoder().decode([rentUnit].self, from: data) else {
//                completion(.failure(.decodingError))
//                return
//            }
//            completion(.success(units))
//            
//        }.resume()
//    }

}
