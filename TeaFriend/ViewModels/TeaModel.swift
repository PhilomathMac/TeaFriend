//
//  TeaModel.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/25/22.
//

import Foundation

class TeaModel: ObservableObject {
    @Published var allTeas: [Tea] = [Tea]()
    
    init() {
        parseJSON()
    }
    
    func parseJSON() {
    
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
                let teaType: TeaType
                
                switch tea.teaType {
                case "Black", "black":
                    teaType = TeaType.Black
                case "Green", "green":
                    teaType =  TeaType.Green
                case "Fruit", "fruit":
                    teaType =  TeaType.Fruit
                case "Herbal", "herbal":
                    teaType =  TeaType.Herbal
                case "Roobios", "roobios":
                    teaType =  TeaType.Roobios
                case "White", "white":
                    teaType =  TeaType.White
                default:
                    teaType =  TeaType.Other
                }
                
                let newTea = Tea(
                name: tea.name,
                description: tea.description,
                brand: tea.brand,
                type: teaType,
                format: tea.isLooseLeaf ? .looseLeaf : .teaBag,
                notes: "",
                rating: tea.stars
                )
                newTeas.append(newTea)
            }
            allTeas = newTeas
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
    } catch {
        print("Error creating data: \(error)")
    }
}
    
    func addTea(name: String, description: String, brand: String, type: TeaType, format: TeaFormat, notes: String, rating: Int) {
        let newTea = Tea(name: name, description: description, brand: brand, type: type, format: format, notes: notes, rating: rating)
        allTeas.append(newTea)
    }
    
    func editTea(teaToEdit: Tea, name: String, description: String, brand: String, type: TeaType, format: TeaFormat, notes: String, rating: Int) {
        if let index = allTeas.firstIndex(where: { tea in
            tea == teaToEdit
        }) {
            var tea = allTeas[index]
            tea.name = name
            tea.description = description
            tea.brand = brand
            tea.type = type
            tea.format = format
            tea.notes = notes
            tea.rating = rating
            allTeas[index] = tea
        }
        
    }
}
