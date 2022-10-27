//
//  TeaCardEditable.swift
//  TeaFriend
//
//  Created by McKenzie Macdonald on 10/24/22.
//

import SwiftUI

struct TeaCardEditable: View {
    
    var tea: Tea?
    @EnvironmentObject var model: TeaModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var teaFormat: TeaFormat
    @State private var teaType: TeaType
    @State private var teaNotes: String
    @State private var teaDescription: String
    @State private var teaName: String
    @State private var errorDisplayed = false
    @State private var teaRating: Int
    
    init(_ tea: Tea) {
        self.tea = tea
        _teaFormat = State(initialValue: tea.format)
        _teaType = State(initialValue: tea.type)
        _teaNotes = State(initialValue: tea.notes)
        _teaDescription = State(initialValue: tea.description)
        _teaName = State(initialValue: tea.name)
        _teaRating = State(initialValue: tea.rating)
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
                    .foregroundColor(tea != nil ? tea!.accentColor : .black)
                
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
                        // save tea
                        if tea != nil {
                            // Edit Tea
                            model.editTea(teaToEdit: tea!, name: teaName, description: teaDescription, brand: "", type: teaType, format: teaFormat, notes: teaNotes, rating: teaRating)
                        } else {
                            // Add Tea
                            model.addTea(name: teaName, description: teaDescription, brand: "", type: teaType, format: teaFormat, notes: teaNotes, rating: teaRating)
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
