//
//  HomeContainer.swift
//  Astronaut
//
//  Created by Artur Marchetto on 03/05/2022.
//

import SwiftUI

struct HomeContainer: View {
    
    @StateObject private var coordinator = HomeCoordinator()
    
    var body: some View {
        
        NavigationView {
            
            HomeRootView(viewModel: coordinator.homeRootViewModel)
            
                .navigation(viewModel: $coordinator.astronautDetailsViewModel) {
                    AstronautDetailsView(viewModel: $0)
                }
        }.navigationViewStyle(.stack)
    }
}
