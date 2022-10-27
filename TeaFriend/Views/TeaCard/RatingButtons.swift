//
//  RatingButtons.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/26/22.
//

import SwiftUI

struct RatingButtons: View {
    @Binding var teaRating: Int
    var onColor = Color(.systemYellow)
    var offColor = Color(.systemGray)
    
    var body: some View {
        HStack {
            ForEach(0 ..< 5, id: \.self) { num in
                Button {
                    teaRating = num + 1
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundColor(num < teaRating ? onColor : offColor)
                }

            }
        }
    }
}

struct RatingButtons_Previews: PreviewProvider {
    static var previews: some View {
        RatingButtons(teaRating: .constant(4))
    }
}


