//
//  UnitViewModel.swift
//  Rental
//
//  Created by Kenneth Chatham on 9/7/22.
//

import Foundation

class UnitViewModel: ObservableObject {
    
    @Published var unitList = [rentUnit]()
    
    func getAllUnits() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonWebToken") else {
            return
        }
        
        WebService().getAllUnits(token: token) { (result) in
            switch result {
            case .success(let unit):
                DispatchQueue.main.async {
                    //                    self.unitList = unit.map(UnitListViewModel.init)
                    self.unitList = unit
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // FIXME: Function to create a unit
    func createUnit(passedUnit: rentUnit) {
        
    }
    
    func updateUnit(selectedUnit: rentUnit) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonWebToken") else {
            return
        }
        
        WebService().patchUnit(token: token, unit: selectedUnit) { (result) in
            switch result {
            case .success(let selectedUnit):
                print(selectedUnit.name)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    struct UnitListViewModel {
        let unit: rentUnit
        let id = UUID()
        var name: String {
            return (unit.name)
        }
        
        var description: String {
            return unit.description
        }
    }
}


