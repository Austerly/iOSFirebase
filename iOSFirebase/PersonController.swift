//
//  PersonController.swift
//  iOSFirebase
//
//  Created by Austin Hesterly on 9/13/16.
//  Copyright © 2016 Austin Hesterly. All rights reserved.
//

import Foundation

class PersonController {
    
    static let baseURL = NSURL(string: "https://iostest-d038b.firebaseio.com/")!
    
    /// This returns the baseURL with a JSON extension (e.g.https://myurl.com/.json)
    static let getterEndpoint = baseURL.URLByAppendingPathExtension("json")
    
    /// This will return an array of people from the network
    static func getPeople(completion: (people: [Person]) -> Void) {
        
        NetworkController.performRequestForURL(getterEndpoint, httpMethod: .Get) { (data, error) in
            guard let data = data else { completion(people: []); return }
            guard let peopleDictionary = try? NSJSONSerialization.JSONObjectWithData(data, options: [.AllowFragments]) as? [String: [String : String]] else { completion(people: []); return }
            
            print("peopleDictionary: ", peopleDictionary)
            
            guard let unwrappedPeopleDictionary = peopleDictionary else { completion(people: []); return }
            let people = unwrappedPeopleDictionary.flatMap({ Person(dictionary: $0.1) })
            completion(people: people)
        }
    }
    
    /// This will add a person to our array of people in the network
    static func addPerson(name: String, completion: ((success: Bool) -> Void)?) {
        let person = Person(name: name)
        
        /// This returns the baseURL with a JSON extension (e.g. https://myURL.com/Jimmy/.json)
        let url = baseURL.URLByAppendingPathComponent("\(NSDate())").URLByAppendingPathExtension("json")
        
        NetworkController.performRequestForURL(url, httpMethod: .Put, body: person.personInJSONForm) { (data, error) in
            
            if let _ = error {
                completion?(success: false)
            } else {
                completion?(success: true)
            }
        }
    }
    
}