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
    @State private var rentalContractEdit = true
    
    @State var interval: String = "Monthly"
    let pickerInterval: [String] = [
        "Hourly", "Daily", "Weekly", "BiWeekly", "Monthly", "Yearly"
    ]
    @State var rate: String = "$75.00"
    let pickerRate: [String] = [
        "$25.00", "$50.00", "$75.00", "$100.00", "$125.00",
        "$150.00", "$175.00", "$200.00", "$225.00", "$250.00",
        "$275.00", "$300.00", "$325.00", "$350.00", "$375.00",
        "$400.00", "$425.00", "$450.00", "$475.00", "$500.00",
        "$525.00", "$550.00", "$575.00", "$600.00", "$625.00",
        "$650.00", "$675.00", "$700.00", "$725.00", "$750.00",
        "$775.00", "$800.00", "$825.00", "$850.00", "$875.00",
        "$900.00", "$925.00", "$950.00", "$975.00", "$1000.00"
    ]
    
    var body: some View {
        
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Id: \(unit.id)")
                    }
                    .font(K.Fonts.sectionTitle)
                   
                } header: {
                    Text("Unit Id")
                        .font(K.Fonts.sectionHeader)
                    }
                
                Section {
                    
                    Picker(
                        selection: $interval,
                        label:
                            HStack {
                                Text("Interval:")
                                Text(interval)
                            }
                            .font(.headline)
                            .foregroundColor(rentalContractEdit ? Color(.systemGray) : .white)
                            .padding()
                            .padding(.horizontal)
                            .background(rentalContractEdit ?  Color(.systemGray4) : Color.blue)
                            .cornerRadius(10)
                            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
                        ,
                        content: {
                            ForEach(pickerInterval, id: \.self) { option in
                                    Text(option)
                                        .tag(option)
                            }.onAppear{ interval = unit.rates[0].intervalName}
                    })
                    .pickerStyle(.automatic)
                            .disabled(rentalContractEdit)
                    Picker(
                        selection: $rate,
                        label:
                            HStack {
                                Text("Rate:")
                                Text(rate)
                            }
                            .font(.headline)
                            .foregroundColor(rentalContractEdit ? Color(.systemGray) : .white)
                            .padding()
                            .padding(.horizontal)
                            .background(rentalContractEdit ?  Color(.systemGray4) : Color.blue)
                            .cornerRadius(10)
                            .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10)
                        ,
                        content: {
                            ForEach(pickerRate, id: \.self) { option in
                                    Text(option)
                                        .tag(option)
                            }.onAppear{ rate = "$" + unit.rates[0].price.description + "0"}
                    })
                    .pickerStyle(.automatic)
                    .disabled(rentalContractEdit)
                } header: {
                    HStack {
                        Text("Rental Contract")
                        Spacer()
                        Button(action: {
                            rentalContractEdit.toggle()
                        }, label: {
                            Text("Edit")
                        })
                    }
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
                    Text("Name:")
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
                    Text("Description:")
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
                    Text("Notes:")
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
                    
                    switch interval {
                    case "Hourly":
                        unit.rates[0].intervalId = 0
                        unit.rates[0].intervalName = "Hourly"
                    case "Daily":
                        unit.rates[0].intervalId = 1
                        unit.rates[0].intervalName = "Daily"
                    case "Weekly":
                        unit.rates[0].intervalId = 2
                        unit.rates[0].intervalName = "Weekly"
                    case "Biweekly":
                        unit.rates[0].intervalId = 3
                        unit.rates[0].intervalName = "Biweekly"
                    case "Monthly":
                        unit.rates[0].intervalId = 4
                        unit.rates[0].intervalName = "Monthly"
                    case "Yearly":
                        unit.rates[0].intervalId = 6
                        unit.rates[0].intervalName = "Yearly"
                    default:
                        unit.rates[0].intervalId = 4
                        unit.rates[0].intervalName = "Monthly"
                    }
                    
                    rate = rate.replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range: nil)
                    unit.rates[0].price = (rate as NSString).floatValue
                    rate = "$" + rate
                    rentalContractEdit.toggle()
                    
                    
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

struct UnitDetailView_Previews: PreviewProvider {
    

    static var previews: some View {
        var ru = rentUnit(description: "Description", id: 1, name: "Test", notes: "Notes", rates: [Rate](), rentals: [String]())

        UnitDetailView(unitVM: UnitViewModel(), unit: ru)
    }
}

