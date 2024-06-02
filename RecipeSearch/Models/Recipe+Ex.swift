//
//  Recipe+Extension.swift
//  RecipeSearch
//
//  Created by Chris lee on 6/1/24.
//

import Foundation

extension Recipes {
  class HelperClass: NSObject, NSCoding {
    
    var recipes: Recipes?
    
    init(recipes: Recipes) {
      self.recipes = recipes
      super.init()
    }
    
    class func path() -> String {
      let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
      let path = documentsPath?.stringByAppendingString("/Person")
      return path!
    }
    
    required init?(coder aDecoder: NSCoder) {
      guard let firstName = aDecoder.decodeObjectForKey("firstName") as? String else { person = nil; super.init(); return nil }
      guard let laseName = aDecoder.decodeObjectForKey("lastName") as? String else { person = nil; super.init(); return nil }
      
      person = Person(firstName: firstName, lastName: laseName)
      
      super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
      aCoder.encodeObject(person!.firstName, forKey: "firstName")
      aCoder.encodeObject(person!.lastName, forKey: "lastName")
    }
  }
}
