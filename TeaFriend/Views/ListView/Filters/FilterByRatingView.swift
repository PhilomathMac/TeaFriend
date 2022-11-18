//
//  FilterByRatingView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/17/22.
//

import SwiftUI

struct FilterByRatingView: View {
    @Binding var filteredRating: Int
    var onColor = Color(.systemYellow)
    var offColor = Color(.systemGray)
    
    var body: some View {
        HStack {
            Text("Minimum Rating:")
                .font(.callout)
                .bold()
                .padding(.vertical, 5)
            Spacer()
            ForEach(0 ..< 5, id: \.self) { num in
                Button {
                    filteredRating = (filteredRating == num + 1) ? 0 : (num + 1)
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundColor(num < filteredRating ? onColor : offColor)
                }

            }
        }
    }
}

struct FilterByRatingView_Previews: PreviewProvider {
    @State static var filteredRating = 3
    static var previews: some View {
        FilterByRatingView(filteredRating: $filteredRating)
    }
}
