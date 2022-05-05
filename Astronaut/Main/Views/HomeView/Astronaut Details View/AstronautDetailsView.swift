//
//  AstronautDetailsView.swift
//  Astronaut
//
//  Created by Artur Marchetto on 03/05/2022.
//

import SwiftUI

struct AstronautDetailsView: View {
    
    @ObservedObject var viewModel: AstronautDetailsViewModel
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 20) {
                
                if let image = viewModel.profilePic {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                        .cornerRadius(15)
                }
                
                Text(viewModel.astronaut.name ?? "No name provided")
                    .font(Font.title2.bold())
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                VStack(alignment: .leading, spacing: 8) {
                    GenericLabel(label: "Biography:")
                    
                    Text(viewModel.astronaut.bio ?? "No bio provided")
                        .font(Font.subheadline.weight(.medium))
                        .foregroundColor(.primary)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    GenericLabel(label: "Date of birth:")
                    
                    Text(viewModel.astronaut.dateOfBirth ?? "No date of birth provided")
                        .font(Font.subheadline.weight(.medium))
                        .foregroundColor(.primary)
                }
                
                GenericRowLink(label: "Twitter", urlString: viewModel.astronaut.twitter)
                
                GenericRowLink(label: "Instagram", urlString: viewModel.astronaut.instagram)
                
                GenericRowLink(label: "Wikipedia", urlString: viewModel.astronaut.wiki)
                
                Spacer()
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Astronaut details")
    }
}
