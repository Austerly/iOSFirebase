//
//  Person.swift
//  iOSFirebase
//
//  Created by Austin Hesterly on 9/13/16.
//  Copyright © 2016 Austin Hesterly. All rights reserved.
//

import Foundation

class Person {
    
    let firstName: String
    
    init(name:String) {
        self.firstName = name
    }
    
    init?(dictionary: [String : String]) {
        guard let nameFromDict = dictionary["nombre"] else {return nil}
        self.firstName = nameFromDict
    }
    
    var personInDictionaryForm: [String : String] {
        return ["nombre" : self.firstName]
    }
    
    var personInJSONForm: NSData? {
        return try? NSJSONSerialization.dataWithJSONObject(self.personInDictionaryForm, options: .PrettyPrinted)
    }
    
}