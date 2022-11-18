//
//  FilterByRatingView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 11/17/22.
//

import SwiftUI

struct FilterByRatingView: View {
    @State var chosenRating: Int = 0
    var onColor = Color(.systemGreen)
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
                    chosenRating = (chosenRating == num + 1) ? 0 : (num + 1)
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundColor(num < chosenRating ? onColor : offColor)
                }

            }
        }
    }
}

struct FilterByRatingView_Previews: PreviewProvider {
    static var previews: some View {
        FilterByRatingView()
    }
}
