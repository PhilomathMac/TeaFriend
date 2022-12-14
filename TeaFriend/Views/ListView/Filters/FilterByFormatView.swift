//
//  FilterByFormatView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/17/22.
//

import SwiftUI

struct FilterByFormatView: View {
    @Binding var filteredFormat: TeaFormat?
    
    var body: some View {
        HStack {
            Text("Tea Format:")
                .bold()
                .padding(.vertical)
            Spacer()
            HStack(spacing: 30) {
                // TeaBag Button
                Button {
                    filteredFormat = (filteredFormat == .teaBag) ? nil : .teaBag
                } label: {
                    Image(systemName: "bag.fill")
                        .foregroundColor(filteredFormat == .teaBag ? Color(.systemBlue) : Color(.systemGray))
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                }
                
                // LooseLeaf Button
                Button {
                    filteredFormat = (filteredFormat == .looseLeaf) ? nil : .looseLeaf
                } label: {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(filteredFormat == .looseLeaf ? Color(.systemBlue) : Color(.systemGray))
                        .padding(10)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                }

            }
        }
    }
}

struct FilterByFormatView_Previews: PreviewProvider {
    
    @State static var filteredFormat = TeaFormat.looseLeaf as TeaFormat?
    
    static var previews: some View {
        FilterByFormatView(filteredFormat: $filteredFormat)
    }
}
