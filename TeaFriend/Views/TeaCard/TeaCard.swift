//
//  TeaCard.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/20/22.
//

import SwiftUI

struct TeaCard: View {
    
    let tea: Tea
    var accentColor: Color {
        switch tea.type {
        case .Black:
            return Color.black
        case .Green:
            return Color.green
        case .Fruit:
            return Color.yellow
        case .Herbal:
            return Color.yellow
        case .Roobios:
            return Color.brown
        case .White:
            return Color.gray
        case .Other:
            return Color.red
        }
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                // Tea Details
                VStack(alignment: .leading) {
                    
                    
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "cup.and.saucer.fill")
                                .resizable()
                                .frame(width: 100, height: 90)
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .foregroundColor(accentColor)
                            Text(tea.name)
                                .font(.title)
                                .padding(.vertical, 10)
                            Text(tea.description)
                                .italic()
                                .padding(.bottom, 10)
                        }
                        Spacer()
                        
                        
                        
                    }
                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    HStack {
                        Text("Rating:")
                            .bold()
                        Spacer()
                        RatingView(teaRating: tea.rating)
                    }
                    .padding(.vertical)
                    
                    // Tea Type
                    HStack {
                        Text("Tea Type:")
                            .bold()
                        Spacer()
                        Text(tea.typeString)
                    }
                    .padding(.vertical)
                    
                    // Tea Format
                    HStack {
                        Text("Tea Format:")
                            .bold()
                        Spacer()
                        if tea.format == .looseLeaf {
                            Image(systemName: "leaf.fill")
                                .resizable()
                                .foregroundColor(accentColor)
                                .frame(width: 30, height: 30)
                        } else {
                            Image(systemName: "bag.fill")
                                .resizable()
                                .foregroundColor(accentColor)
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding(.vertical)
                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .bold()
                            .padding(.vertical, 2)
                        Text(tea.notes)
                    }
                    
                }
                .padding()
                Spacer()
                Button {
                    
                } label: {
                    Text("Edit")
                        .padding()
                        .bold()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
        }
        
        
    }
}

struct TeaCard_Previews: PreviewProvider {
    static var previews: some View {
        TeaCard(tea: Tea(name: "Orange Spice", description: "Sweet and spicy with cinnamon, orange peel, and cloves", brand: "David's", typeString: "Green", format: .looseLeaf, notes: "Like this one a lot", rating: 4))
    }
}
