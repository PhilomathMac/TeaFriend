//
//  TeaCardEditable.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import SwiftUI

struct TeaCardEditable: View {
    
    var tea: Tea?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @State private var teaFormat: TeaFormat
    @State private var teaType: TeaType
    @State private var teaDescription: String
    @State private var teaName: String
    @State private var teaRating: Int
    @State private var errorDisplayed = false
    @State private var accentColor: Color
    
    init(_ tea: Tea) {
        self.tea = tea
        _teaFormat = State(initialValue: TeaFormat(rawValue: tea.format!) ?? .looseLeaf)
        _teaType = State(initialValue: TeaType(rawValue: tea.type!) ?? .Other)
        _teaDescription = State(initialValue: tea.teaDescription ?? "")
        _teaName = State(initialValue: tea.name ?? "Error")
        _teaRating = State(initialValue: Int(tea.rating))
        _accentColor = State(initialValue: tea.accentColor)
    }
    
    init() {
        self.tea = nil
        _teaFormat = State(initialValue: .looseLeaf)
        _teaType = State(initialValue: .Black)
        _teaDescription = State(initialValue: "")
        _teaName = State(initialValue: "")
        _teaRating = State(initialValue: 0)
        _accentColor = State(initialValue: .black)
    }
    
    var body: some View {
        VStack {
            // Buttons
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .padding()
                }
                
                Spacer()
                
                // Done Button
                Button {
                    // validate user input
                    if validateUserInput() {
                        // save changes
                        if tea != nil {
                            // Edit Tea
                            tea!.name = teaName
                            tea!.type = teaType.rawValue
                            tea!.format = teaFormat.rawValue
                            tea!.rating = Int16(teaRating)
                            tea!.teaDescription = teaDescription
                            
                            do {
                                try viewContext.save()
                            } catch {
                                print("Error saving edited tea to core data: \(error)")
                            }
                        } else {
                            // Add Tea
                            let newTea = Tea(context: viewContext)
                            newTea.name = teaName
                            newTea.id = UUID()
                            newTea.type = teaType.rawValue
                            newTea.format = teaFormat.rawValue
                            newTea.rating = Int16(teaRating)
                            newTea.teaDescription = teaDescription
                            newTea.brand = "NO BRAND"
                            
                            do {
                                try viewContext.save()
                            } catch {
                                print("Error saving to core data: \(error)")
                            }
                        }
                        // dismiss view
                        dismiss()
                    } else {
                        errorDisplayed = true
                    }
                    
                } label: {
                    Text("Done")
                        .padding()
                        .bold()
                }
                
            }
            .padding(5)
            
            VStack {
                Image(systemName: "cup.and.saucer.fill")
                    .resizable()
                    .frame(width: 100, height: 90)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .foregroundColor(tea != nil ? accentColor : .black)
                
                Form {
                    // Name
                    Section {
                        VStack(alignment: .leading) {
                            Text("Name:")
                                .bold()
                            TextField("Name", text: $teaName, prompt: Text("Tea Name"))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    // Notes and Description
                    Section {
                        VStack(alignment: .leading) {
                            Text("Description / Notes:")
                                .bold()
                            TextField("Description", text: $teaDescription, prompt: Text("Tastes like..."), axis: .vertical)
                                .lineLimit(1...5)
                                .italic()
                                .padding(.bottom, 20)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    
                    // Rating
                    Section {
                        HStack {
                            Text("Rating:")
                                .bold()
                            Spacer()
                            RatingButtons(teaRating: $teaRating)
                        }
                    }
                    
                    // Tea Type
                    Section {
                        HStack {
                            Text("Tea Type:")
                                .bold()
                            Spacer()
                            Picker("", selection: $teaType) {
                                Text("Black").tag(TeaType.Black)
                                Text("Green").tag(TeaType.Green)
                                Text("Rooibos").tag(TeaType.Rooibos)
                                Text("Herbal").tag(TeaType.Herbal)
                                Text("Fruit").tag(TeaType.Fruit)
                                Text("Pu'erh").tag(TeaType.Puerh)
                                Text("Oolong").tag(TeaType.Oolong)
                                Text("Other").tag(TeaType.Other)
                            }
                            .onChange(of: teaType) { newValue in
                                accentColor = {
                                    switch newValue {
                                    case .Black:
                                        return Color.black
                                    case .Green:
                                        return Color.green
                                    case .Fruit:
                                        return Color.mint
                                    case .Herbal:
                                        return Color.indigo
                                    case .Rooibos:
                                        return Color.pink
                                    case .White:
                                        return Color.gray
                                    case .Oolong:
                                        return Color.orange
                                    case .Puerh:
                                        return Color.brown
                                    case .Other:
                                        return Color.red
                                    }
                                }()
                            }
                        }
                    }
                    
                    // Tea Format
                    Section {
                        HStack {
                            Text("Tea Format:")
                                .bold()
                            Spacer()
                            HStack(spacing: 30) {
                                // TeaBag Button
                                Button {
                                    teaFormat = (teaFormat == .teaBag) ? .looseLeaf : .teaBag
                                } label: {
                                    VStack {
                                        Image(systemName: "bag.fill")
                                            .foregroundColor(teaFormat == .teaBag ? accentColor : Color(.systemGray))
                                            .padding(10)
                                            .background(Color(.systemGray5))
                                            .cornerRadius(10)
                                        Text("Tea")
                                            .font(.caption)
                                            .foregroundColor(teaFormat == .teaBag ? accentColor : Color(.systemGray))
                                        Text("Bag")
                                            .font(.caption)
                                            .foregroundColor(teaFormat == .teaBag ? accentColor : Color(.systemGray))
                                    }
                                }
                                
                                // LooseLeaf Button
                                Button {
                                    teaFormat = (teaFormat == .looseLeaf) ? .teaBag : .looseLeaf
                                } label: {
                                    VStack {
                                        Image(systemName: "leaf.fill")
                                            .foregroundColor(teaFormat == .looseLeaf ? accentColor : Color(.systemGray))
                                            .padding(10)
                                            .background(Color(.systemGray5))
                                            .cornerRadius(10)
                                        
                                        Text("Loose")
                                            .font(.caption)
                                            .foregroundColor(teaFormat == .looseLeaf ? accentColor : Color(.systemGray))
                                        Text("Leaf")
                                            .font(.caption)
                                            .foregroundColor(teaFormat == .looseLeaf ? accentColor : Color(.systemGray))
                                    }
                                }
                                
                                
                            }
                        }
                    }
                }
            }
        }
        .alert("Oops!", isPresented: $errorDisplayed) {
            // default ok action
        } message: {
            Text("Every tea has to at least have a name!")
        }
        
    }
    
    private func validateUserInput() -> Bool {
        guard !teaName.isEmpty else {
            return false
        }
        return true
    }
}


struct TeaCardEditable_Previews: PreviewProvider {
    static var previews: some View {
        TeaCardEditable()
    }
}
