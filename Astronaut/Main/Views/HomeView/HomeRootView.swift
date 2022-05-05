//
//  HomeRootView.swift
//  Astronaut
//
//  Created by Artur Marchetto on 03/05/2022.
//

import SwiftUI

struct HomeRootView: View {
    
    @ObservedObject var viewModel: HomeRootViewModel
    
    var body: some View {
        
        mainView
        .navigationTitle("Astronauts")
    }
    
    @ViewBuilder
    var mainView: some View {
        if viewModel.loading {
            SwiftActivityIndicator()
        } else {
            VStack(spacing: 25) {
                
                listOfStatuses
                    .padding(.top, 10)
                
                listOfAstronauts
            }.padding(.horizontal, 15)
        }
    }
    
    var listOfAstronauts: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.astronautViewModels, id: \.astronaut.id) { model in
                    Button {
                        viewModel.showDetailsView(using: model.astronaut)
                    } label: {
                        AstronautsCardView(viewModel: model)
                    }
                    .onAppear {
                        viewModel.loadMoreAstronautsIfNeeded(model.astronaut)
                    }
                }
            }
        }
    }
    
    var listOfStatuses: some View {
        AstronautStatusGroup(
            statuses: viewModel.statuses,
            selectedID: $viewModel.selectedStatus
        ) { optionID in
            viewModel.didSelectAstronautStatus(optionID)
        }
    }
}
