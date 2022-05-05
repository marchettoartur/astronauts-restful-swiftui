//
//  URLExtension.swift
//  Astronaut
//
//  Created by Artur Marchetto on 05/05/2022.
//

import SwiftUI

extension URL {
    
    func downloadImage(_ completion: @escaping (Image?, Error?) -> Void) {
        
        URLSession.shared.dataTask(
            with: self,
            completionHandler: { data, _, error in
                
                guard
                    error == nil,
                    let data = data,
                    let uiImage = UIImage(data: data)
                else {
                    completion(nil, error)
                    return
                }
                
                let image = Image(uiImage: uiImage)
                
                completion(image, nil)
            }
        ).resume()
    }
}
