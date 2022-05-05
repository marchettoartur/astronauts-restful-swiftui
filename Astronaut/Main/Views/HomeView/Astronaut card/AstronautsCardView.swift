//
//  AstronautsCardView.swift
//  Astronaut
//
//  Created by Artur Marchetto on 04/05/2022.
//

import SwiftUI

struct AstronautsCardView: View {
    
    @ObservedObject var viewModel: AstronautsCardViewModel
    
    var body: some View {
        
        ZStack {
            
            Color.gray.opacity(0.3)
            
            HStack(spacing: 20) {
                
                ProfilePicThumbnail(image: viewModel.profilePic)
                
                VStack {
                    astronautNameView
                    Spacer()
                    agencyNameView
                }.padding(.vertical, 5)
                
                Spacer()
            }.padding(10)
        }
        .cornerRadius(10)
    }
    
    var astronautNameView: some View {
        HStack {
            Text(viewModel.astronaut.name ?? "No name provided")
                .font(Font.headline.bold())
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
    
    var agencyNameView: some View {
        GenericInfoRow(label: "Agency:", text: viewModel.astronaut.agency?.name ?? "No agency name provided")
    }
    
    private struct ProfilePicThumbnail: View {
        
        let image: Image?
        
        let size: CGFloat = 60
        
        var body: some View {
            
            ZStack {
                
                Circle()
                    .fill(Color.white)
                    .frame(width: size, height: size)
                
                if let image = image {
                    image
                        .resizable()
                        .frame(width: size, height: size)
                        .scaledToFit()
                        .cornerRadius(15)
                }
            }
        }
    }
}
