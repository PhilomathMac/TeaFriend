//
//  FilterView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/17/22.
//

import SwiftUI

struct FilterView: View {
    @Binding var filteredRating: Int
    @Binding var filteredType: TeaType?
    @Binding var filteredFormat: TeaFormat?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Filter Options")
                    .font(.title)
                Spacer()
                Button {
                    filteredRating = 0
                    filteredType = nil
                    filteredFormat = nil
                } label: {
                    Text("Reset Filters")
                }
            }
            Divider()
            FilterByRatingView(filteredRating: $filteredRating)
            Divider()
            FilterByTypeView(filteredType: $filteredType)
            Divider()
            FilterByFormatView(filteredFormat: $filteredFormat)
        }
        .padding()
    }
}

struct FilterView_Previews: PreviewProvider {
    
    @State static var rating = 2
    @State static var type = TeaType.Black as TeaType?
    @State static var format = TeaFormat.looseLeaf as TeaFormat?
    
    static var previews: some View {
        FilterView(filteredRating: $rating, filteredType: $type, filteredFormat: $format)
    }
}
