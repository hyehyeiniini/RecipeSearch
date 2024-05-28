import Foundation

struct Recipes {
    let recipeID: Int // 일련번호
    let recipeName: String // 메뉴명
    let recipeWay: String // 조리방법
    let recipeType: String // 요리종류
    let ingredient: String // 재료
    let recipeCal: String // 열량
    let infoCar: String // 탄수화물
    let infoPro: String // 단백질
    let infoFat: String // 지방
    let infoNa: String // 나트륨
    let imageUrl: String // 이미지경로
    let manualArray: [Manual] // 조리법
}

struct Manual {
    let manualNum: String
    let manualStr: String
    let manualUrl: String
}


// MARK: - 네트워크로부터 받아오는 데이터
struct apiData: Codable {
    let cookRecipes: cookRecipes

    enum CodingKeys: String, CodingKey {
        case cookRecipes = "COOKRCP01"
    }
}

// MARK: - cookRecipes
struct cookRecipes: Codable {
    let totalCount: String
    let info: [[String: String]]?
    let result: Result

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case info = "row"
        case result = "RESULT"
    }
}

// MARK: - Result
struct Result: Codable {
    let msg, code: String

    enum CodingKeys: String, CodingKey {
        case msg = "MSG"
        case code = "CODE"
    }
}
