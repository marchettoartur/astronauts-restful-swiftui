//
//  AstronautsCardViewModel.swift
//  Astronaut
//
//  Created by Artur Marchetto on 05/05/2022.
//

import SwiftUI

final class AstronautsCardViewModel: ObservableObject {
    
    let astronaut: Astronaut
    
    @Published var profilePic: Image?
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        fetchProfilePic()
    }
    
    private func fetchProfilePic() {
        guard let profileImageThumbnail = astronaut.profileImageThumbnail,
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

extension AstronautsCardViewModel: Hashable, Equatable {
    
    static func == (lhs: AstronautsCardViewModel, rhs: AstronautsCardViewModel) -> Bool {
        lhs.astronaut.id == rhs.astronaut.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(astronaut.id)
    }
}
