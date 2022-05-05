//
//  SwiftActivityIndicator.swift
//  Astronaut
//
//  Created by Artur Marchetto on 04/05/2022.
//

import UIKit
import SwiftUI

struct SwiftActivityIndicator: UIViewRepresentable {
    
    private let color: UIColor
    private let style: UIActivityIndicatorView.Style
    
    init(
        style: UIActivityIndicatorView.Style = .large,
        color: UIColor = .darkGray
    ) {
        self.style = style
        self.color = color
    }
    
    func makeUIView(
        context: UIViewRepresentableContext<SwiftActivityIndicator>
    ) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        view.startAnimating()
        view.color = color
        return view
    }
    
    func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: UIViewRepresentableContext<SwiftActivityIndicator>
    ) {}
}
