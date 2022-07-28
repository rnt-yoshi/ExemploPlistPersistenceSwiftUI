//
//  ContentViewModel.swift
//  ExemploPlistPersistenceSwiftUI
//
//  Created by Renato Yoshinari on 28/07/22.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var newDog = Dog()
    
    @Published var dogList: [Dog] = []
    
    func createCar() {
        StorageHandler.write(item: newDog)
        
        newDog = Dog()
        
        updateGarage()
    }
    
    func updateGarage() {
        dogList = StorageHandler.load()
    }
    
    func resetGarage() {
        StorageHandler.deleteAll()
        
        dogList = StorageHandler.load()
    }
}
