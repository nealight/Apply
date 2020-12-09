//
//  Company.swift
//  Apply
//
//  Created by Yi Xu on 11/8/20.
//  Copyright © 2020 Yi Xu. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Company: Object {
    @objc dynamic private var name: String = ""
    @objc dynamic private var note: String = ""
    @objc dynamic private var image: String = "" // Stores the URL to the image file
    
    convenience init(name: String, note: String, image: String) {
        self.init()
        self.name = name
        self.note = note
        self.image = image
        
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getNote() -> String {
        return note
    }

    public func getImage() -> String {
        return image
    }
    
    // Cite: lecture code
    public var desc: String {
        let desc = "\(name)~\(note)~\(image)\n"
        return desc
    }
    
    public var archivedDescription: String {
        let desc = "\(name)|\(note)|\(image)\n"
        return desc
    }
    
    
    
}
