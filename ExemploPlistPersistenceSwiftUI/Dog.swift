//
//  Car.swift
//  ExemploPlistPersistenceSwiftUI
//
//  Created by Renato Yoshinari on 28/07/22.
//

import Foundation

struct Dog: Codable, Identifiable {
    var id = UUID()
    var name: String = ""
    var breed: String = ""
}
