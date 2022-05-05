//
//  HomeCoordinator.swift
//  Astronaut
//
//  Created by Artur Marchetto on 03/05/2022.
//

import SwiftUI

final class HomeCoordinator: ObservableObject {
    
    @Published var homeRootViewModel: HomeRootViewModel!
    @Published var astronautDetailsViewModel: AstronautDetailsViewModel?
    
    init() {
        homeRootViewModel = HomeRootViewModel(coordinator: self)
    }
    
    func showDetailsView(using astronaut: Astronaut) {
        astronautDetailsViewModel = AstronautDetailsViewModel(
            astronaut: astronaut
        )
    }
}
