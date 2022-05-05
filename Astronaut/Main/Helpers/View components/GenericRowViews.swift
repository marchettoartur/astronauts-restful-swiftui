//
//  GenericRowViews.swift
//  Astronaut
//
//  Created by Artur Marchetto on 05/05/2022.
//

import SwiftUI

struct GenericRowLink: View {
    
    var label: String
    var urlString: String?
    
    @ViewBuilder
    var body: some View {
        if let url = URL(string: urlString ?? "") {
            VStack(alignment: .leading, spacing: 8) {
                GenericLabel(label: label)
                Link("Click to open", destination: url)
            }
        }
    }
}

struct GenericInfoRow: View {
    
    var label: String
    var text: String
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                GenericLabel(label: label)
                
                Text(text)
                    .font(Font.subheadline.bold())
                    .foregroundColor(.primary)
            }
            Spacer()
        }
    }
}

struct GenericLabel: View {
    
    var label: String
    
    var body: some View {
        Text(label)
            .font(Font.subheadline.weight(.regular))
            .foregroundColor(.gray)
    }
}
