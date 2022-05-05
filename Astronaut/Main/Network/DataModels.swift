//
//  DataModels.swift
//  Astronaut
//
//  Created by Artur Marchetto on 03/05/2022.
//

import SwiftUI

// MARK: - Data models

struct AstronautStatus: Identifiable {
    let id: String
    let name: String?
}

struct AstronautType: Identifiable {
    let id: String
    let name: String?
}

struct AstronautAgency: Identifiable {
    let id: String
    let url: String?
    let name: String?
    let featured: Bool?
    let type: String?
    let countryCode: String?
    let abbrev: String?
    let description: String?
    let administrator: String?
    let foundingYear: String?
    let launchers: String?
    let spacecraft: String?
    let parent: String?
    let imageUrl: String?
}

struct Astronaut: Identifiable {
    let id: String
    let url: String?
    let name: String?
    var status: AstronautStatus? = nil
    var type: AstronautType? = nil
    let dateOfBirth: String?
    let dateOfDeath: String?
    let nationality: String?
    let bio: String?
    let twitter: String?
    let instagram: String?
    let wiki: String?
    var agency: AstronautAgency? = nil
    let profileImage: String?
    let profileImageThumbnail: String?
    let lastFlight: String?
    let firstFlight: String?
}

struct Astronauts: Identifiable {
    let id = UUID()
    let count: Int?
    let next: String?
    let previous: String?
    let astronauts: [Astronaut]?
}

// MARK: - Extensions

extension AstronautStatus {
    init(from response: AstronautStatusResponse) {
        self.id = response.id == nil ? UUID().uuidString : String(response.id!)
        self.name = response.name
    }
}

extension AstronautType {
    init(from response: AstronautTypeResponse) {
        self.id = response.id == nil ? UUID().uuidString : String(response.id!)
        self.name = response.name
    }
}

extension AstronautAgency {
    init(from response: AstronautAgencyResponse) {
        self.id = response.id == nil ? UUID().uuidString : String(response.id!)
        self.url = response.url
        self.name = response.name
        self.featured = response.featured
        self.type = response.type
        self.countryCode = response.country_code
        self.abbrev = response.abbrev
        self.description = response.description
        self.administrator = response.administrator
        self.foundingYear = response.founding_year
        self.launchers = response.launchers
        self.spacecraft = response.spacecraft
        self.parent = response.parent
        self.imageUrl = response.image_url
    }
}

extension Astronaut: Hashable, Equatable {
    init(from response: AstronautResponse) {
        self.id = response.id == nil ? UUID().uuidString : String(response.id!)
        self.url = response.url
        self.name = response.name
        if let status = response.status {
            self.status = AstronautStatus(from: status)
        }
        if let type = response.type {
            self.type = AstronautType(from: type)
        }
        self.dateOfBirth = response.date_of_birth
        self.dateOfDeath = response.date_of_death
        self.nationality = response.nationality
        self.bio = response.bio
        self.twitter = response.twitter
        self.instagram = response.instagram
        self.wiki = response.wiki
        if let agency = response.agency {
            self.agency = AstronautAgency(from: agency)
        }
        self.profileImage = response.profile_image
        self.profileImageThumbnail = response.profile_image_thumbnail
        self.lastFlight = response.last_flight
        self.firstFlight = response.first_flight
    }
    
    static func == (lhs: Astronaut, rhs: Astronaut) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Astronauts {
    init(from response: AstronautsResponse) {
        self.count = response.count
        self.next = response.next
        self.previous = response.previous
        
        var astronauts = [Astronaut]()
        
        response.results?.forEach {
            astronauts.append(Astronaut(from: $0))
        }
        
        self.astronauts = astronauts
    }
}

// MARK: - Responses

struct AstronautStatusResponse: Codable {
    let id: Int?
    let name: String?
}

struct AstronautTypeResponse: Codable {
    let id: Int?
    let name: String?
}

struct AstronautAgencyResponse: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let featured: Bool?
    let type: String?
    let country_code: String?
    let abbrev: String?
    let description: String?
    let administrator: String?
    let founding_year: String?
    let launchers: String?
    let spacecraft: String?
    let parent: String?
    let image_url: String?
}

struct AstronautResponse: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let status: AstronautStatusResponse?
    let type: AstronautTypeResponse?
    let date_of_birth: String?
    let date_of_death: String?
    let nationality: String?
    let bio: String?
    let twitter: String?
    let instagram: String?
    let wiki: String?
    let agency: AstronautAgencyResponse?
    let profile_image: String?
    let profile_image_thumbnail: String?
    let last_flight: String?
    let first_flight: String?
}

struct AstronautsResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [AstronautResponse]?
}
