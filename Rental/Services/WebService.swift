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
    case encodingError
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
    
    // Authenticate to the Rental API
    func login(email: String, password: String, rememberMe: Bool, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: K.Url.userLogin) else {
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
        guard let url = URL(string: K.Url.customersGetAll) else {
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
    
    // Request the Rental API Create Customer
    func createCustomer(token: String, customer: Customer, completion: @escaping (Result<Customer, NetworkError>) -> Void) {

        // Construct the URL
        guard let url = URL(string: K.Url.customersCreate) else {
            completion(.failure(.invalidURL))
            return
        }

        // Define request
        var request = URLRequest(url: url)
        
        // Build the request
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        
        request.httpMethod = "POST"

        // Assure the passed in customer encodes to json
        guard let encodedResult = try? JSONEncoder().encode(customer.self) else {
            completion(.failure(.encodingError))
            return
        }
        
        // If the passed in customer correctly encodes set the request.httpBody
        request.httpBody = encodedResult


        // Get the session and kick off the task
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            //Just for my knowledge
            if let response = response as? HTTPURLResponse{
                print(response.statusCode)
            }
            
            // Check after the create for !data.isEmpty and error == nil
            guard let data = data, !data.isEmpty, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            // If data decodes all is good to go
            guard let editedCustomer = try? JSONDecoder().decode(Customer.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(editedCustomer))

        }.resume()
    }

    
    // Request the Rental API PATCH Customer
    func patchCustomer(token: String, customer: Customer, completion: @escaping (Result<Customer, NetworkError>) -> Void) {

        // Construct the URL
        guard let url = URL(string: K.Url.customersPatch) else {
            completion(.failure(.invalidURL))
            return
        }

        // Define request
        var request = URLRequest(url: url)
        
        // Build the request
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        
        request.httpMethod = "PATCH"

        // Assure the passed in customer encodes to json
        guard let encodedResult = try? JSONEncoder().encode(customer.self) else {
            completion(.failure(.encodingError))
            return
        }
        // If the passed in customer correctly encodes set the request.httpBody
        request.httpBody = encodedResult


        // Get the session and kick off the task
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            // Check after the patch for !data.isEmpty and error == nil
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            // If data decodes all is good to go
            guard let editedCustomer = try? JSONDecoder().decode(Customer.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }

            //Just for my knowledge
            if let response = response as? HTTPURLResponse{
                print(response.statusCode)
            }
            
            completion(.success(editedCustomer))

        }.resume()
    }
    
    // Request the Rental API reveal all the units
    func getAllUnits(token: String, completion: @escaping (Result<[rentUnit], NetworkError>) -> Void) {
        
        // Construct the URL
        guard let url = URL(string: K.Url.unitsGetAll) else {
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
            
            guard let units = try? JSONDecoder().decode([rentUnit].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(units))
            
        }.resume()
    }
    
    // Request the Rental API PATCH Unit
    func patchUnit(token: String, unit: rentUnit, completion: @escaping (Result<rentUnit, NetworkError>) -> Void) {

        // Construct the URL
        guard let url = URL(string: K.Url.unitsPatch) else {
            completion(.failure(.invalidURL))
            return
        }

        // Define request
        var request = URLRequest(url: url)
        
        // Build the request
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        
        request.httpMethod = "PATCH"

        // Assure the passed in unit encodes to json
        guard let encodedResult = try? JSONEncoder().encode(unit.self) else {
            completion(.failure(.encodingError))
            return
        }
        // If the passed in unit correctly encodes set the request.httpBody
        request.httpBody = encodedResult

        // Get the session and kick off the task
        URLSession.shared.dataTask(with: request) { (data, response, error) in

            // Check after the patch for !data.isEmpty and error == nil
            guard let data = data, !data.isEmpty, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            // If data decodes all is good to go
            guard let editedUnit = try? JSONDecoder().decode(rentUnit.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }

            //Just for my knowledge
            if let response = response as? HTTPURLResponse{
                print(response.statusCode)
            }
            
            completion(.success(editedUnit))

        }.resume()
    }
}
