//
//  UnitDetailView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/7/22.
//

import SwiftUI

struct UnitDetailView: View {
    
    @ObservedObject var unitVM: UnitViewModel
    @State var unit: rentUnit
    
    
    @State private var name = ""
    @State private var description = ""
    @State private var notes = ""
    
    @FocusState private var nameInFocus: Bool
    @FocusState private var descriptionInFocus: Bool
    @FocusState private var notesInFocus: Bool
    
    let nameLimit = 32

    var body: some View {
        
        VStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        Text("Id: \(unit.id)")
                        Spacer()
                    }
                    .font(K.Fonts.sectionTitle)
                } header: {
                    Text("Unit Id")
                        .font(K.Fonts.sectionHeader)
                    }
                
                Section {
                    
                    Text("Name: \(unit.name)")
                        .font(K.Fonts.sectionItem)
                    
                    TextField(unit.name, text: $name)
                        .focused( $nameInFocus )
                        .padding()
                        .textContentType(.none)
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .foregroundColor(validateText() ? .green : .red)
                        .font(.headline)
                    
                    //                    .modifier(customViewModifier(focused: $isEditing,
                    //                                                 roundedCornes: 6,
                    //                                                 startColor: K.Colors.gradientStartBlue,
                    //                                                 endColor: K.Colors.gradientEndBlue,
                    //                                                 textColor: .black,
                    //                                                 horizontalPad: 10,
                    //                                                 verticalPad: 3))
                    
                } header: {
                    Text("Edit Name:")
                        .font(K.Fonts.sectionHeader)
                    }
                
                Section {
                    
                    Text("Description: \(unit.description)")
                        .font(K.Fonts.sectionItem)
                    
//                    TextField("Address", text: $address, axis: .vertical)
//                                .lineLimit(2)
//
//                                .textFieldStyle(.roundedBorder)
//                                .padding()
                    
                    
                    if #available(iOS 16.0, *) {
                        TextField(unit.description, text: $description, axis: .vertical)
                            .lineLimit(3)
                            .focused( $descriptionInFocus )
                            .padding()
                            .background(Color.gray.opacity(0.3).cornerRadius(10))
                            .foregroundColor(validateText() ? .green : .red)
                            .font(.headline)
                    } else {
                        // Fallback on earlier versions
                    }
                    
                } header: {
                    Text("Edit Description:")
                        .font(K.Fonts.sectionHeader)
                    }
                
                Section {
                    Text("Notes: \(unit.notes)")
                        .font(K.Fonts.sectionItem)
                    
                    if #available(iOS 16.0, *) {
                        TextField(unit.notes, text: $notes, axis: .vertical)
                            .lineLimit(3)
                            .focused( $notesInFocus )
                            .padding()
                            .background(Color.gray.opacity(0.3).cornerRadius(10))
                            .foregroundColor(validateText() ? .green : .red)
                            .font(.headline)
                    } else {
                        // Fallback on earlier versions
                    }
                } header: {
                    Text("Edit Notes:")
                        .font(K.Fonts.sectionHeader)
                    }
        }


            Button(action: {
                
                if validateText() {
                    if nameInFocus {
                        unit.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
                        name = ""
                    } else if descriptionInFocus {
                        unit.description = description.trimmingCharacters(in: .whitespacesAndNewlines)
                        description = ""
                    } else if notesInFocus {
                        unit.notes = notes.trimmingCharacters(in: .whitespacesAndNewlines)
                        notes = ""
                    }
                    
                    unit.rates[0].intervalId = 1
                    unit.rates[0].price = 1000
                    
                    
                    self.unitVM.objectWillChange.send()
                    self.unitVM.updateUnit(selectedUnit: unit)
                }
                
            }, label: {
                Text("Save".uppercased())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(validateText() ? Color.blue : Color.gray)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(K.Fonts.buttonText.bold())
            })
            .disabled(!validateText())
        }
        .padding()
        .navigationTitle("Details")
    }
    
    func validateText() -> Bool {

        if nameInFocus {
           
            // name has length lets check it
            if name.count >= 1 && name.count <= 10 {
               
                // check begining and end for spaces and newlines
                guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    return false
                }
                // name checks good spaces and newlines trimmed begining and end
                return true
            }
        } else if descriptionInFocus {
            
                // description has length lets check it
                if description.count >= 5 && description.count <= 256 {
                    
                    // check begining and end for spaces and newlines
                    guard !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                        return false
                    }
                    
                    // description checks good spaces and newlines trimmed begining and end
                    return true
            }
        } else if notesInFocus {
            // notes has length lets check it
            if notes.count >= 5 && notes.count <= 256 {
                
                // check begining and end for spaces and newlines
                guard !notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    return false
                }
                
                // notes checks good spaces and newlines trimmed begining and end
                return true
            }
        }
            return false
    }
    
    func limitText(_ upper: Int) {
        if unit.name.count > upper {
            unit.name = String(unit.name.prefix(upper))
        }
    }
    
    func nameChanged(to value: String) {
//        if value.count > 12 {
//            unit.name = String(value.prefix(12))
//        }
        print("Name changed to \(unit.name)")
    }
}

//struct UnitDetailView_Previews: PreviewProvider {
//    
//
//    static var previews: some View {
//        var ru = rentUnit(description: "Description", id: 1, name: "Test", notes: "Notes", rates: [Rate](), rentals: [String]())
//
//        UnitDetailView(unitVM: UnitViewModel(), unit: ru)
//    }
//}

