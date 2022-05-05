//
//  AstronautDetailsViewModel.swift
//  Astronaut
//
//  Created by Artur Marchetto on 03/05/2022.
//

import SwiftUI

final class AstronautDetailsViewModel: ObservableObject {
    
    let astronaut: Astronaut
    
    @Published var profilePic: Image?
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        fetchProfilePic()
    }
    
    private func fetchProfilePic() {
        guard let profileImageThumbnail = astronaut.profileImage,
              let url = URL(string: profileImageThumbnail)
        else { return }
        
        url.downloadImage { [weak self] image, error in
            
            guard error == nil, let image = image else { return }
            
            DispatchQueue.main.async {
                self?.profilePic = image
            }
        }
    }
}
