//
//  MLItem.swift
//  Pods
//
//  Created by Juan Pablo Hernandez on 15/04/2021.
//

import Foundation

class MLItem: Codable {
    var title: String = ""
    var subtitle: String = ""
    var price: Double = 0
    var desc: String = ""
    private var image: Data?
    
    func setImage(_ image: UIImage?) {
        if let image = image { self.image = UIImagePNGRepresentation(image) } else { self.image = nil }
    }
    
    func getImage() -> UIImage? {
        if let image = self.image { return UIImage(data: image) } else { return nil }
    }
}
