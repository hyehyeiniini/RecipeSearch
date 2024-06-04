//
//  NetworkManager.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/25/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    // 여러화면에서 통신을 한다면, 일반적으로 싱글톤으로 만듦
    static let shared = NetworkManager()
    
    // 여러객체를 추가적으로 생성하지 못하도록 설정
    private init() {}
    
    func getRecipes(recipeName: String?, completion: @escaping ([Recipes]?) -> Void) {
        print(#function)
        var urlString = "\(RecipesAPI.requestUrl)/COOKRCP01/json/\(RecipesAPI.startIdx)/\(RecipesAPI.endIdx)"
        if let recipeName = recipeName {
            urlString += "/RCP_NM=\(recipeName)"
        }

        print(urlString)
        AF.request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default, // 요청 본문을 json 형식으로 변환
                   headers: ["Content-Type":"application/json", "Accept":"application/json"],
                   interceptor: nil,
                   requestModifier: nil).validate(statusCode: 200..<600).response { [weak self] response in
            
            var jsonFlag = ""
            
            switch response.result {
            case .success(let data): // 응답에 성공하면
                guard let data = data else { return } // data 변수에 응답 데이터 저장
                
                do {
                    guard let prettyJson = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return }
                    jsonFlag = prettyJson as String
                    let parsedData = try JSONDecoder().decode(apiData.self, from: data) // 응답 데이터를 ProfileData(json -> quicktype.io로 변환한 구조체)로 디코드
                    let decodedData = self?.recipesDataManufacturing(parsedData: parsedData)
                    completion(decodedData)
                } catch {
                    print("파싱 에러 : \(error)")
                    print(jsonFlag)
                    completion(nil)
                }
            case .failure(let error): // 응답에 실패하면
                print("응답 에러 : \(error)")
                completion(nil)
            }
            
        }
    }
    
    func recipesDataManufacturing(parsedData: apiData) -> [Recipes] {
        var recipesArray: [Recipes] = []
        guard let results = parsedData.cookRecipes.info else { return recipesArray }
        for result in results{
            
            let recipeID = Int(result["RCP_SEQ"]!)! // 일련번호
            let recipeName = result["RCP_NM"]! // 메뉴명
            print(recipeName)
            
            let recipeWay = result["RCP_WAY2"]! // 조리방법
            let recipeType = result["RCP_PAT2"]! // 요리종류
            let ingredient = result["RCP_PARTS_DTLS"]! // 재료
            let recipeCal = result["INFO_ENG"]! // 열량
            let infoCar = result["INFO_CAR"]! // 탄수화물
            let infoPro = result["INFO_PRO"]! // 단백질
            let infoFat = result["INFO_FAT"]! // 지방
            let infoNa = result["INFO_NA"]! // 나트륨
            let imageUrl = result["ATT_FILE_NO_MAIN"]! // 이미지경로
            
            var manualArray: [Manual] = []
            for num in 1...20 {
                let manualNum = String(format: "%02d", num)
                let manualStr = result["MANUAL\(manualNum)"]!
                if manualStr == "" { break }
                let manualUrl = result["MANUAL_IMG\(manualNum)"]!
                let manual = Manual(manualNum: String(num), manualStr: manualStr, manualUrl: manualUrl)
                manualArray.append(manual)
            }
            
            let recipes = Recipes(recipeID: recipeID, recipeName: recipeName, recipeWay: recipeWay, recipeType: recipeType, ingredient: ingredient, recipeCal: recipeCal, infoCar: infoCar, infoPro: infoPro, infoFat: infoFat, infoNa: infoNa, imageUrl: imageUrl, manualArray: manualArray)
            
            recipesArray.append(recipes)
        }
        return recipesArray
    }
}

