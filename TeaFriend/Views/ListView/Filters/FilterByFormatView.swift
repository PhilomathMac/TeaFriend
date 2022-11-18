//
//  FilterByFormatView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/17/22.
//

import SwiftUI

struct FilterByFormatView: View {
    @State var chosenFormat: TeaFormat?
    
    var body: some View {
        HStack {
            Text("Tea Format:")
                .bold()
                .padding(.vertical)
            Spacer()
            HStack(spacing: 30) {
                // TeaBag Button
                Button {
                    chosenFormat = (chosenFormat == .teaBag) ? nil : .teaBag
                } label: {
                    Image(systemName: "bag.fill")
                        .foregroundColor(chosenFormat == .teaBag ? Color(.systemBlue) : Color(.systemGray))
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                }
                
                // LooseLeaf Button
                Button {
                    chosenFormat = (chosenFormat == .looseLeaf) ? nil : .looseLeaf
                } label: {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(chosenFormat == .looseLeaf ? Color(.systemGreen) : Color(.systemGray))
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                }

            }
        }
    }
}

struct FilterByFormatView_Previews: PreviewProvider {
    static var previews: some View {
        FilterByFormatView()
    }
}
