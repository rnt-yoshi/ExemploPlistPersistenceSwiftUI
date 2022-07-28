//
//  StorageHandler.swift
//  ExemploPlistPersistenceSwiftUI
//
//  Created by Renato Yoshinari on 28/07/22.
//

import Foundation

class StorageHandler {
    
    static private var plistURL: URL {
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return URL(fileURLWithPath: "")}
        
        return documents.appendingPathComponent("garagem.plist")
    }
    
    static func write(item: Dog) {
        if !FileManager.default.fileExists(atPath: plistURL.path) {
            FileManager.default.createFile(atPath: plistURL.path, contents: prepareData([item]), attributes: nil)
            
            print(plistURL.path)
        } else {
            var currentItems = StorageHandler.load()
            currentItems.append(item)
            try? prepareData(currentItems).write(to: plistURL)
        }
    }
    
    static func load() -> [Dog] {
        let decoder = PropertyListDecoder()
        
        guard let data = try? Data.init(contentsOf: plistURL), let preferences = try? decoder.decode([Dog].self, from: data) else { return [] }
        
        return preferences
    }
    
    static func deleteAll() {
        if FileManager.default.fileExists(atPath: plistURL.path) {
            
            try? FileManager.default.removeItem(at: plistURL)
        }
    }
    
    static func prepareData(_ value: [Dog]) -> Data {
        let encoder = PropertyListEncoder()
        
        guard let data = try? encoder.encode(value) else { return Data()}
        
        return data
    }
}
