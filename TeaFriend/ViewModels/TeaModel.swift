//
//  TeaModel.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/25/22.
//

import Foundation

struct TeaModel {
    var allTeas: [Tea] = [Tea]()
    
    init() {
        parseJSON()
    }
    
    mutating func parseJSON() {
        
        guard let path = Bundle.main.path(forResource: "teas", ofType: ".json") else {
            print("Error getting json path")
            return
        }
        
        let url = URL(filePath: path)
        
        do {
           
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            
            do {
               
                let decodedTeas = try decoder.decode([DecodedTea].self, from: data)
                var newTeas = [Tea]()
                for tea in decodedTeas {
                    let newTea = Tea(
                    name: tea.name,
                    description: tea.description,
                    brand: tea.brand,
                    typeString: tea.teaType,
                    format: tea.isLooseLeaf ? .looseLeaf : .teaBag,
                    notes: "",
                    rating: tea.stars
                   )
                    newTeas.append(newTea)
                }
                allTeas = newTeas
                print(allTeas.count)
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        } catch {
            print("Error creating data: \(error)")
        }
    }
}
