//
//  RatingView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/20/22.
//

import SwiftUI

struct RatingView: View {
    var teaRating: Int
    var onColor = Color(.systemYellow)
    var offColor = Color(.systemGray)
    
    var body: some View {
        HStack {
            ForEach(0 ..< 5, id: \.self) { num in
                Image(systemName: "star.fill")
                    .foregroundColor(num < teaRating ? onColor : offColor)
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(teaRating: 4)
    }
}
