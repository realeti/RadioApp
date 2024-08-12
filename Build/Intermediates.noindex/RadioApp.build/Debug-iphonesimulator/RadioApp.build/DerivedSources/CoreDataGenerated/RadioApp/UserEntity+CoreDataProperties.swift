//
//  UserEntity+CoreDataProperties.swift
//  
//
//  Created by Иван Семенов on 12.08.2024.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var login: String?

}

extension UserEntity : Identifiable {

}
