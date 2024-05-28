//
//  Constants.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/25/24.
//

import UIKit

// 컬렉션뷰 구성을 위한 설정
public struct CVCell {
    static let spacingWitdh: CGFloat = 3
    static let cellColumns: CGFloat = 3
    private init() {}
}

// 네트워크 url
public enum RecipesAPI {
    static let requestUrl = "http://openapi.foodsafetykorea.go.kr/api/cc2a29a01cf74b5db292"
    static let startIdx = 1
    static let endIdx = 10
    
}

