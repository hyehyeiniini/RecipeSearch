//
//  MyRecipesManager.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/29/24.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔티티 이름
    let modelName = "RecipeData"
    
    private init() {}
    
    // 코어데이터에서 데이터 가져오기
    func getRecipeDataFromCoreData() -> [RecipeData]? {
        var recipeData: [RecipeData] = []
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.modelName)
            
            do {
                // 임시저장소에서 요청서를 통해 데이터 가져오기
                if let fetchRecipeData = try context.fetch(request) as? [RecipeData] {
                    recipeData = fetchRecipeData
                    return recipeData
                }
            } catch {
                print("코어데이터 가져오기 실패")
                return nil
            }
        }
        return nil
    }
    
    func coreDataToCustomData() -> [Recipes] {
        var customDataArray: [Recipes] = []
        guard let coreDataArray = getRecipeDataFromCoreData() else {
            return customDataArray
        }
        
        coreDataArray.forEach { coreData in
            
            let recipeID = Int(coreData.recipeID)
            let recipeName = coreData.recipeName!
            let recipeWay = coreData.recipeWay! // 조리방법
            let recipeType = coreData.recipeType!
            let ingredient = coreData.ingredient!
            let recipeCal = coreData.recipeCal!
            let infoCar = coreData.infoCar!
            let infoPro = coreData.infoPro!
            let infoFat = coreData.infoFat!
            let infoNa = coreData.infoNa!
            let imageUrl = coreData.imageUrl!
            
            var manualArray: [Manual] = []
            for index in 0..<(coreData.manualNum?.count ?? 0)  {
                let manualNum = coreData.manualNum![index]
                let manualStr = coreData.manualStr![index]
                let manualUrl = coreData.manualUrl![index]
                let manual = Manual(manualNum: manualNum, manualStr: manualStr, manualUrl: manualUrl)
                
                manualArray.append(manual)
            }
            
            let recipes = Recipes(recipeID: recipeID, recipeName: recipeName, recipeWay: recipeWay, recipeType: recipeType, ingredient: ingredient, recipeCal: recipeCal, infoCar: infoCar, infoPro: infoPro, infoFat: infoFat, infoNa: infoNa, imageUrl: imageUrl, manualArray: manualArray)
            customDataArray.append(recipes)
        }
        
        return customDataArray
    }
    
    func saveData(recipe: Recipes, completion: @escaping () -> Void){
        // 임시저장소 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                // 임시저장소에 올릴 (관리)객체 만들기
                if let recipeData = NSManagedObject(entity: entity, insertInto: context) as? RecipeData {
                    // ⭐️ 실제 데이터 할당
                    recipeData.recipeName = recipe.recipeName
                    recipeData.imageUrl = recipe.imageUrl
                    recipeData.infoCar = recipe.infoCar
                    recipeData.infoFat = recipe.infoFat
                    recipeData.infoNa = recipe.infoNa
                    recipeData.infoPro = recipe.infoPro
                    recipeData.ingredient = recipe.ingredient
                    
                    var manualNum: [String] = []
                    var manualStr: [String] = []
                    var manualUrl: [String] = []
                    recipe.manualArray.forEach { manual in
                        manualNum.append(manual.manualNum)
                        manualStr.append(manual.manualStr)
                        manualUrl.append(manual.manualUrl)
                    }
                    recipeData.manualNum = manualNum
                    recipeData.manualStr = manualStr
                    recipeData.manualUrl = manualUrl
                    recipeData.recipeCal = recipe.recipeCal
                    recipeData.recipeID = Int32(recipe.recipeID)
                    
                    recipeData.recipeType = recipe.recipeType
                    recipeData.recipeWay = recipe.recipeWay
                    
                    // 델리게이트 이용해도 됨
                    // appDelegate?.saveContext()
                    
                    if context.hasChanges {
                        do {
                            try context.save() // ⭐️ 하드디스크에 저장
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                    
                }
            }
        }
        // completion()
    }
    
    func deleteRecipeData(data: String, completion: @escaping () -> Void) {
        if let context = context {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "recipeName = %@", data as CVarArg)
            
            do {
                // 임시저장소에서 요청서를 통해 데이터 가져오기
                if let fetchRecipeData = try context.fetch(request) as? [RecipeData] {
                    if let targetRecipeData = fetchRecipeData.first {
                        context.delete(targetRecipeData)
                        
                        if context.hasChanges {
                            do {
                                try context.save() // ⭐️ 하드디스크에 저장
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("데이터 지우기 실패")
                completion()
            }
        }
    }
    
    func contains(data: String) -> Bool{
        if let context = context {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "recipeName = %@", data)
            
            do {
                // 임시저장소에서 요청서를 통해 데이터 가져오기
                if let fetchRecipeData = try context.fetch(request) as? [RecipeData] {
                    if let targetRecipeData = fetchRecipeData.first {
                        // print(targetRecipeData.recipeName)
                        return true
                    }
                }
            } catch {
                print("데이터가 존재하지 않습니다.")
                return false
            }
        }
        print("저장소 가져오기 실패")
        return false
    }
    
}
