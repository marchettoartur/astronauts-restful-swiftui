//
//  HomeRootViewModel.swift
//  Astronaut
//
//  Created by Artur Marchetto on 03/05/2022.
//

import SwiftUI
import Combine

final class HomeRootViewModel: ObservableObject {
    
    weak var coordinator: HomeCoordinator?
    let astronautsService = AstronautsService(apiSession: APISession())
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var loading = false
    @Published var astronautViewModels = [AstronautsCardViewModel]()
    @Published var selectedStatus = ""
    
    // Updated as we fetch more astronauts.
    @Published var statuses = [StatusOption]()
    @Published var offset = 0
    
    @State private var totalNumberOfAstronauts = 0
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        fetchAstronauts(append: false)
    }
    
    private func fetchAstronauts(append: Bool) {
        
        if append {
            // Size of each page
            offset += 10
        } else {
            offset = 0
        }
        
        astronautsService
            .fetchAstronauts(status: selectedStatus, offset: offset)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { [weak self] astronautResponse in
                    guard
                        let self = self,
                        let astronauts = astronautResponse.astronauts
                    else { return }
                    
                    // Assign astronaut count
                    self.totalNumberOfAstronauts = astronautResponse.count ?? 0
                    
                    // As we get more astronauts, we get more statuses.
                    // Add the unique ones to the list.
                    let statuses = astronauts.map { StatusOption(id: $0.status?.id ?? "", title: $0.status?.name ?? "") }
                    
                    statuses.forEach {
                        if !self.statuses.contains($0) {
                            self.statuses.append($0)
                        }
                    }
                    
                    // Create a view model for each astronaut that will be displayed on the list.
                    let astronautViewModels = astronauts
                        .map { AstronautsCardViewModel(astronaut: $0) }
                    
                    if append {
                        self.astronautViewModels
                            .append(contentsOf: astronautViewModels)
                    } else {
                        self.astronautViewModels = Array(Set(astronautViewModels))
                    }
                }
            )
            .store(in: &self.cancellables)
    }
    
    func didSelectAstronautStatus(_ optionID: String) {
        fetchAstronauts(append: false)
    }
    
    func showDetailsView(using astronaut: Astronaut) {
        self.coordinator?.showDetailsView(using: astronaut)
    }
    
    func loadMoreAstronautsIfNeeded(_ astronaut: Astronaut) {
        
        // Loads when the user has X cards left to scroll.
        let startLoadingFromIndex = astronautViewModels.index(astronautViewModels.endIndex, offsetBy: -2)
        
        let firstIndexToLoadFrom = astronautViewModels
            .firstIndex(where: { $0.astronaut.id == astronaut.id })
        
        if firstIndexToLoadFrom == startLoadingFromIndex {
            fetchAstronauts(append: true)
        }
    }
}

let mockAstronautModel = AstronautsCardViewModel(
    astronaut:
        Astronaut(id: "276", url: "https://lldev.thespacedevs.com/2.2.0/astronaut/276/", name: "Franz Viehböck", status: AstronautStatus(id: "2", name: "Retired"), type: AstronautType(id: "2", name: "Government"), dateOfBirth: "1960-08-24", dateOfDeath: "null", nationality: "Austrian", bio: "Franz Artur Viehböck (born August 24, 1960 in Vienna) is an Austrian electrical engineer, and was Austria's first cosmonaut. He was titulated „Austronaut“ by his country's media. He visited the Mir space station in 1991 aboard Soyuz TM-13, returning aboard Soyuz TM-12 after spending just over a week in space.", twitter: "https://www.wikihow.com/Main-Page", instagram: "null", wiki: "https://en.wikipedia.org/wiki/Franz_Viehböck", agency: AstronautAgency(id: "8", url: "https://lldev.thespacedevs.com/2.2.0/agencies/8/", name: "Austrian Space Agency", featured: false, type: "Government", countryCode: "AUT", abbrev: "ALR", description: "The Austrian Space Agency was founded in 1972 and joined the ESA as a member in 1987. In 2005, control of the ALR was transferred to the Austrian Agency for Aerospace. They coordinated the first flight of an Austrian in space with a Soyuz launch in 1990.", administrator: "Andreas Geisler", foundingYear: "1972", launchers: "", spacecraft: "Spacelab | GALILEO", parent: "null", imageUrl: "null"), profileImage: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/franz2520viehb25c325b6ck_image_20181201223901.jpg",profileImageThumbnail: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/default/cache/54/57/5457ce75acb7b188196eb442e3f17b64.jpg", lastFlight: "1991-10-02T05:59:38Z", firstFlight: "1991-10-02T05:59:38Z"
                 )
)
