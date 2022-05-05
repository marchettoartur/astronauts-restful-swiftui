//
//  AstronautsProtocol.swift
//  Astronaut
//
//  Created by Artur Marchetto on 03/05/2022.
//

import SwiftUI
import Combine

protocol AstronautsProtocol {
    func fetchAstronauts(status: String, offset: Int) -> AnyPublisher<Astronauts, Error>
}

struct AstronautsService: AstronautsProtocol {
    
    var apiSession: APISessionProvider
    
    func fetchAstronauts(status: String, offset: Int) -> AnyPublisher<Astronauts, Error> {
        
        var params = [String: Any]()
        
        params["ordering"] = "name"
        
        if !status.isEmpty {
            params["status"] = status
        }
        
        if offset != 0 {
            params["offset"] = offset
        }
        
        return apiSession
            .execute(Endpoints.fetchAstronauts(params: params))
            .map { Astronauts(from: $0) }
            .eraseToAnyPublisher()
        }
}
