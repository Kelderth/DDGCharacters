//
//  DDGPersistence.swift
//  DDG Characters
//
//  Created by MCS on 12/19/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import UIKit
import CoreData

class DDGPersistence {
    
    func writeData(characterName: String, characterDetail: String, pictureURL: String, favorited: Bool) {

        // Declaring Context
        let contextManaged = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Declaring an Entity
        let characterEntity = NSEntityDescription.entity(forEntityName: "CharacterSource", in: contextManaged)
        
        // Creating a new Record
        let character = NSManagedObject(entity: characterEntity!, insertInto: contextManaged)
        
        character.setValue(characterName, forKey: "characterName")
        character.setValue(characterDetail, forKey: "characterDetail")
        character.setValue(pictureURL, forKey: "pictureURL")
        
        do {
            try contextManaged.save()
        } catch let error as NSError {
            print("The registed couldn't be saved, Reason: \(error)")
        }
    }
    
    func readData() -> [CharacterSource] {
        
        // Array that will hold the fetched data
        var dataFetched: [CharacterSource] = [CharacterSource]()
        
        // The context is created through a connection to the AppDelegate.
        let contextManaged = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
        // The data is fetched from the CoreData
        let fetchedRequest = NSFetchRequest<CharacterSource>(entityName: "CharacterSource")
        
        do {
            dataFetched = try contextManaged?.fetch(fetchedRequest) ?? []
        } catch let error as NSError {
            print("The data could not be fetched due to some errors, Reason: \(error)")
        }
        
        return dataFetched
    }
    
}
