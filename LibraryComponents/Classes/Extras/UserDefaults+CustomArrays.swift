//
//  UserDefaults+CustomArrays.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 16/04/2021.
//

import Foundation

extension UserDefaults {
    
    func setMLItemsArray(_ array: [MLItem], forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array){
            self.set(encoded, forKey: key)
        } else {
            NSLog("Error trying to encode MLItem array")
        }
    }
    
    func mLItemsArray(forKey key: String) -> [MLItem]? {
        if let savedData = self.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([MLItem].self, from: savedData) {
                return decoded
            }
        }
        NSLog("Error trying to decode MLItem array")
        return nil
    }
}
