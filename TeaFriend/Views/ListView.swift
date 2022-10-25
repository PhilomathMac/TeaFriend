//
//  ListView.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import SwiftUI

struct ListView: View {
    var model = TeaModel()
    let dummyData = [
        Tea(name: "Orange Spice", description: "Sweet and spicy with cinnamon, orange peel, and cloves", brand: "David's", typeString: "Green", format: .looseLeaf, notes: "Like this one a lot", rating: 4),
        Tea(name: "Brown Sugar Bourbon", description: "Malty, sweet, and creamy with hints of vanilla", brand: "David's", typeString: "Black", format: .looseLeaf, notes: "Good with milk and sugar", rating: 4),
        Tea(name: "Pumpkin Chai", description: "Cinnamon and clove with sweet pumpkin and caramel", brand: "David's", typeString: "Black", format: .looseLeaf, notes: "Don't really taste the pumpkin", rating: 3),
        Tea(name: "Bohemian Raspberry", description: "Baked raspberry pastry with a hint of anise", brand: "David's", typeString: "Roobios", format: .looseLeaf, notes: "", rating: 0),
        Tea(name: "Peanut Butter Cup", description: "Decadent blend of almonds and chocolate", brand: "David's", typeString: "Fruit", format: .teaBag, notes: "Smells like peanut butter but waste of taste without sweetener", rating: 3)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                List(model.allTeas) { tea in
                    NavigationLink {
                        TeaCard(tea: tea)
                    } label: {
                        Text(tea.name)
                    }

                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
