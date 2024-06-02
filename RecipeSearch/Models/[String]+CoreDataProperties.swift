//
//  [String]+CoreDataProperties.swift
//  
//
//  Created by Chris lee on 6/1/24.
//
//

import Foundation
import CoreData


extension [String] {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<[String]> {
        return NSFetchRequest<[String]>(entityName: "RecipeData")
    }

    @NSManaged public var recipeID: Int32
    @NSManaged public var recipeName: String?
    @NSManaged public var recipeWay: String?
    @NSManaged public var recipeType: String?
    @NSManaged public var ingredient: String?
    @NSManaged public var recipeCal: String?
    @NSManaged public var infoCar: String?
    @NSManaged public var infoPro: String?
    @NSManaged public var infoFat: String?
    @NSManaged public var infoNa: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var manualUrl: [String]?
    @NSManaged public var manualStr: [String]?
    @NSManaged public var manualNum: String?

}
