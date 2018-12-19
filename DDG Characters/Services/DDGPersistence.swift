//
//  DDGPersistence.swift
//  DDG Characters
//
//  Created by MCS on 12/19/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

//import Foundation
import UIKit
import CoreData

class DDGPersistence {
    
    func writeData(characterName: String, characterDetail: String, pictureURL: String, favorited: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // persistenceContainer encapsulate the CoreData in the Application.
        let contextManaged = appDelegate.persistentContainer.viewContext
        
        // A description of an entity in CoreData.
        let character = NSEntityDescription.insertNewObject(forEntityName: "CharacterSource", into: contextManaged)
        
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
        var charactersLoaded: [CharacterSource] = [CharacterSource]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        
        let contextManaged = appDelegate.persistentContainer.viewContext
        
        // The data is extracted from the CoreData
        let fetchedRequest = NSFetchRequest<NSManagedObject> (entityName: "CharacterSource")
        
        do {
            charactersLoaded = try contextManaged.fetch(fetchedRequest) as! [CharacterSource]
        } catch let error as NSError {
            print("The data could not be fetched due to some errors, Reason: \(error)")
        }
        
        return charactersLoaded
    }
    
}
