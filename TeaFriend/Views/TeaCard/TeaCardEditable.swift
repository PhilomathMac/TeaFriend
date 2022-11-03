//
//  TeaCardEditable.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import SwiftUI

struct TeaCardEditable: View {
    
    var tea: Tea?
    @EnvironmentObject var model: ViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext

    
    @State private var teaFormat: TeaFormat
    @State private var teaType: TeaType
    @State private var teaNotes: String
    @State private var teaDescription: String
    @State private var teaName: String
    @State private var errorDisplayed = false
    @State private var teaRating: Int
    
    var accentColor: Color {
        switch TeaType(rawValue: (tea?.type) ?? "Other") ?? .Other {
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
    
    init(_ tea: Tea) {
        self.tea = tea
        _teaFormat = State(initialValue: TeaFormat(rawValue: tea.format!) ?? .looseLeaf)
        _teaType = State(initialValue: TeaType(rawValue: tea.type!) ?? .Other)
        _teaNotes = State(initialValue: tea.notes ?? "")
        _teaDescription = State(initialValue: tea.teaDescription ?? "")
        _teaName = State(initialValue: tea.name ?? "Error")
        _teaRating = State(initialValue: Int(tea.rating))
    }
    
    init() {
        self.tea = nil
        _teaFormat = State(initialValue: .looseLeaf)
        _teaType = State(initialValue: .Black)
        _teaNotes = State(initialValue: "")
        _teaDescription = State(initialValue: "")
        _teaName = State(initialValue: "")
        _teaRating = State(initialValue: 0)
    }
    
    var body: some View {
        VStack {
            // Tea Details
            VStack {
                
                Image(systemName: "cup.and.saucer.fill")
                    .resizable()
                    .frame(width: 100, height: 90)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .foregroundColor(tea != nil ? accentColor : .black)
                
                TextField("Name", text: $teaName, prompt: Text("Tea Name"))
                    .font(.title)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                TextField("Description", text: $teaDescription, prompt: Text("Description"), axis: .vertical)
                    .lineLimit(1...5)
                    .italic()
                    .padding(.bottom, 20)
                
                Divider()
                    .padding(.vertical, 10)
                HStack {
                    Text("Rating:")
                        .bold()
                    Spacer()
                    RatingButtons(teaRating: $teaRating)
                }
                
                // Tea Type
                HStack {
                    Text("Tea Type:")
                        .bold()
                    Spacer()
                    Picker("", selection: $teaType) {
                        Text("Black").tag(TeaType.Black)
                        Text("Green").tag(TeaType.Green)
                        Text("Roobios").tag(TeaType.Roobios)
                        Text("Fruit/Herbal").tag(TeaType.Herbal)
                        Text("Roobios").tag(TeaType.Roobios)
                        Text("Other").tag(TeaType.Other)
                    }
                }
                
                
                
                // Tea Format
                HStack {
                    Text("Tea Format:")
                        .bold()
                    Spacer()
                    Picker("", selection: $teaFormat) {
                        Image(systemName: "bag.fill").tag(TeaFormat.teaBag)
                        Image(systemName: "leaf.fill").tag(TeaFormat.looseLeaf)
                    }
                }
                
                Divider()
                    .padding(.vertical, 10)
                
            }
            .padding()
            
            // Tea Notes
            VStack(alignment: .leading) {
                Text("Notes:")
                    .bold()
                TextEditor(text: $teaNotes)
                    .padding(EdgeInsets(top: 7, leading: 7, bottom: 0, trailing: 0))
                    .border(Color.gray.opacity(0.25), width: 2)
            }
            .padding([.horizontal, .bottom])
            
            
            // Button
            HStack {
                Spacer()
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
                            tea!.notes = teaNotes
                            
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
                            newTea.notes = teaNotes
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
                    Text("Save")
                        .padding()
                        .padding(.horizontal, 20)
                        .bold()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
                // Cancel button
                Button {
                    // Return to non-editable version without saving
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                }
                Spacer()
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
