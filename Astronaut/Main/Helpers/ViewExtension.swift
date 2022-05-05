//
//  ViewExtension.swift
//  Astronaut
//
//  Created by Artur Marchetto on 03/05/2022.
//

import SwiftUI

extension View {
    
    func onNavigation(_ action: @escaping () -> Void) -> some View {
        let isActive = Binding(
            get: { false },
            set: { newValue in
                if newValue {
                    action()
                }
            }
        )
        return NavigationLink(
            destination: EmptyView(),
            isActive: isActive
        ) {
            self
        }
    }
    
    func navigation<ViewModel, Destination: View>(
        viewModel: Binding<ViewModel?>,
        @ViewBuilder destination: (ViewModel) -> Destination
    ) -> some View {
        let isActive = Binding(
            get: { viewModel.wrappedValue != nil },
            set: { value in
                if !value {
                    viewModel.wrappedValue = nil
                }
            }
        )
        return navigation(isActive: isActive) {
            viewModel.wrappedValue.map(destination)
        }
    }
    
    func navigation<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        overlay(
            NavigationLink(
                destination: isActive.wrappedValue ? destination() : nil,
                isActive: isActive,
                label: { EmptyView() }
            )
        )
    }
}
