//
//  TeaCard.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/20/22.
//

import SwiftUI

struct TeaCard: View {
    
    let tea: TeaModel
    @State private var isShowingEditTea = false
    
    var body: some View {
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
                            .foregroundColor(tea.accentColor)
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
                    Text(tea.type.rawValue)
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
                            .foregroundColor(tea.accentColor)
                            .frame(width: 30, height: 30)
                    } else {
                        Image(systemName: "bag.fill")
                            .resizable()
                            .foregroundColor(tea.accentColor)
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(.vertical)
                
                Divider()
                    .padding(.vertical, 10)
                
                if !tea.notes.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .bold()
                            .padding(.vertical, 2)
                        Text(tea.notes)
                    }
                }
            }
            .padding()
            
            Button {
                isShowingEditTea = true
            } label: {
                Text("Edit")
                    .padding()
                    .bold()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
        }
        .sheet(isPresented: $isShowingEditTea) {
            TeaCardEditable(tea)
        }
        
        
    }
}

struct TeaCard_Previews: PreviewProvider {
    static var previews: some View {
        TeaCard(tea: TeaModel(name: "Orange Spice", description: "Sweet and spicy with cinnamon, orange peel, and cloves", brand: "David's", type: .Green, format: .looseLeaf, notes: "Like this one a lot", rating: 4))
    }
}
