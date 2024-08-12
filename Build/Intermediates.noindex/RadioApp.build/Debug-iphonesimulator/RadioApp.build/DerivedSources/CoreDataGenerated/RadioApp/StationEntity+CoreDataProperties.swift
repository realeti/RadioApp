//
//  StationEntity+CoreDataProperties.swift
//  
//
//  Created by Иван Семенов on 12.08.2024.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension StationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StationEntity> {
        return NSFetchRequest<StationEntity>(entityName: "StationEntity")
    }

    @NSManaged public var genre: String?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?

}

extension StationEntity : Identifiable {

}
