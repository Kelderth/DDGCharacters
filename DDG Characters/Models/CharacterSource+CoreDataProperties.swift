//
//  CharacterSource+CoreDataProperties.swift
//  DDG Characters
//
//  Created by MCS on 12/19/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//
//

import Foundation
import CoreData


extension CharacterSource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterSource> {
        return NSFetchRequest<CharacterSource>(entityName: "CharacterSource")
    }

    @NSManaged public var characterDetail: String?
    @NSManaged public var characterName: String?
    @NSManaged public var favorited: Bool
    @NSManaged public var pictureData: NSData?
    @NSManaged public var pictureURL: String?

}
