//
//  AstronautStatusGroup.swift
//  Astronaut
//
//  Created by Artur Marchetto on 05/05/2022.
//

import SwiftUI

struct StatusOption: Identifiable, Hashable {
    let id: String
    var title: String
}

struct AstronautStatusGroup: View {
    
    let statuses: [StatusOption]
    @Binding var selectedID: String
    let completion: (String) -> ()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(statuses.indices, id: \.self) { index in
                    AstronautStatusButton(
                        statuses[index],
                        selectedID: selectedID,
                        completion: groupCompletion
                    )
                }
            }
        }
    }
    
    private func groupCompletion(id: String) {
        selectedID = id
        completion(id)
    }
}

fileprivate struct AstronautStatusButton: View {
    
    private let status: StatusOption
    private let selectedID: String
    private let completion: (String) -> ()
    
    var isSelected: Bool { status.id == selectedID }
    
    init(
        _ status: StatusOption,
        selectedID: String,
        completion: @escaping (String) -> ()
    ) {
        self.status = status
        self.selectedID = selectedID
        self.completion = completion
    }
    
    var body: some View {
        Button(action: {
            guard !isSelected else {
                completion("")
                return
            }
            
            completion(status.id)
        }) {
            
            Text(status.title)
                .font(Font.headline.weight(isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .black)
                .padding(.vertical, 8)
                .padding(.horizontal, 18)
                .background(isSelected ? Color.blue.opacity(0.9) : Color.gray.opacity(0.1))
                .cornerRadius(14)
        }
    }
}
