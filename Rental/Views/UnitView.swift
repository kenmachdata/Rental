//
//  UnitView.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/7/22.
//

import SwiftUI

struct UnitView: View {
    
    @ObservedObject var unitVm: UnitViewModel
    @ObservedObject var customerVm: CustomerViewModel
    @ObservedObject var loginVm: LoginViewModel
    
    var body: some View {
        VStack {
            
            if loginVm.isAuthenticated && !unitVm.unitList.isEmpty {
                
                HStack {
                    Text("ID:")
                        .fontWeight(.bold)
                        .padding(.leading, 10.0)
                        .padding(.vertical, 0)
                        .font(.headline)
                    Spacer()
                    Text("Name:")
                        .fontWeight(.bold)
                        .padding(.vertical, 0)
                        .padding(.trailing, 30)
                        .font(.headline)
//                    Spacer()
//                    Text("Description:")
//                        .fontWeight(.bold)
//                        .padding(.trailing, 30.0)
//                        .padding(.vertical, 0)
//                        .font(.headline)
                }

                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(unitVm.unitList) { unit in
                            
                            NavigationLink(
                                destination: UnitDetailView(unitVM: unitVm, unit: unit ),
                                label: {
                                    
                                    // MARK: Row item
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("\(unit.id)")
                                            Spacer()
                                            Text("\(unit.name)")
//                                            Spacer()
//                                            Text(unit.description)
                                        }
                                        .foregroundColor(K.Colors.buttonBlue)
                                        .font(K.Fonts.link)
                                        .padding(.horizontal)
                                        .padding(.vertical, 2)
                                    }
                                }
                            )
                        }
                    }
                }
//                List(unitVm.unitList, id: \.id) { unit in
//                    HStack {
//                        Text("\(unit.name)")
//                        Spacer()
//                        Text("\(unit.description)")
//                    }
//                }.listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Units")
    }
}

struct UnitView_Previews: PreviewProvider {
    static var previews: some View {
        UnitView(unitVm: UnitViewModel(), customerVm: CustomerViewModel(), loginVm: LoginViewModel())
    }
}
