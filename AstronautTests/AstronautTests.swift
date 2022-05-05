//
//  AstronautTests.swift
//  AstronautTests
//
//  Created by Artur Marchetto on 02/05/2022.
//

import XCTest
import SwiftUI
import Combine
@testable import Astronaut

class AstronautTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    var astronautsList = [Astronaut]()

    func testFetchAstronautsPageOne() throws {
        
        let astronautsService = AstronautsService(apiSession: APISession())
        
        astronautsService
            .fetchAstronauts(status: "", offset: 0)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { [weak self] astronautResponse in
                    
                    XCTAssertNotNil(astronautResponse.astronauts)
                    XCTAssert(astronautResponse.astronauts?.count == 10)
                    
                    if let astronauts = astronautResponse.astronauts {
                        self?.astronautsList = astronauts
                    }
                }
            ).store(in: &self.cancellables)
    }
    
    func testFetchAstronautsPageTwo() {
        
        let astronautsService = AstronautsService(apiSession: APISession())
        
        astronautsService
            .fetchAstronauts(status: "", offset: 10)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { [weak self] astronautResponse in
                    
                    XCTAssertNotNil(astronautResponse.astronauts)
                    XCTAssert(astronautResponse.astronauts?.count == 10)
                    
                    guard let self = self else {
                        XCTAssert(false)
                        return
                    }
                    
                    if let astronauts = astronautResponse.astronauts {
                        self.astronautsList.append(contentsOf: astronauts)
                    }
                    
                    // Check for duplicates when adding astronauts. That we didnt fetch already present astronauts.
                    XCTAssert(Set(self.astronautsList).count == self.astronautsList.count)
                }
            ).store(in: &self.cancellables)
    }
    
    func testFetchStatusAstronauts() {
        
        let astronautsService = AstronautsService(apiSession: APISession())
        
        astronautsService
            .fetchAstronauts(status: "1", offset: 0)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { astronautResponse in
                    
                    guard let astronauts = astronautResponse.astronauts else {
                        XCTAssert(false)
                        return
                    }
                    
                    // Check that the status of "Active" works by including an active astronaut.
                    XCTAssert(astronauts.filter { $0.name ?? "" == "Alvin Drew" }.count == 1)
                }
            ).store(in: &self.cancellables)
    }
}
