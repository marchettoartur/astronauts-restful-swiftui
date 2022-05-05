//
//  Endpoints.swift
//  Astronaut
//
//  Created by Artur Marchetto on 03/05/2022.
//

import SwiftUI

typealias RequestParams = [String: Any]

protocol RequestProviding {
    var baseURL: String { get }
    var method: String { get }
    func urlRequest() -> URLRequest
}

@frozen enum Endpoints {
    case fetchAstronauts(params: RequestParams)
    case fetchAstronaut(id: String)
}

extension Endpoints: RequestProviding {
    
    func urlRequest() -> URLRequest {
        
        var path = ""
        
        switch self {
            
            // MARK: - User
        case .fetchAstronauts(let params):
            path = "/astronaut\(queryParams(from: params))"
        case .fetchAstronaut(let id):
            path = "/astronaut/\(id)"
        }
        
        guard let url = URL(string: "\(baseURL)\(path)") else {
            preconditionFailure("Invalid URL used to create URL instance")
        }
        
        var request = URLRequest(url: url)
        print("URL path is: ", url)
        
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    var method: String {
        switch self {
        case .fetchAstronauts,
             .fetchAstronaut:
             return "GET"
        }
    }
    
    var baseURL: String {
        return productionURLString
    }
    
    private var debugURLString: String {
        "https://lldev.thespacedevs.com"
    }
    
    private var productionURLString: String {
        "https://lldev.thespacedevs.com/2.2.0"
    }
    
    private func queryParams(from params: [String: Any]) -> String {
        
        guard !params.isEmpty else { return "" }
        
        var queryParams = "?"
        params.keys.forEach {
            queryParams.append("\($0)=\(params[$0] ?? "")&")
        }
        queryParams.removeLast()
        return queryParams
    }
}
