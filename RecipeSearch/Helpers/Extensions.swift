//
//  Extensions.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/27/24.
//

import UIKit

extension UIColor {
    static let backgroundColor = UIColor(red: 0.99, green: 0.98, blue: 0.96, alpha: 1.00)
    static let pointColor = UIColor(red: 0.26, green: 0.67, blue: 0.04, alpha: 1.00)
}

extension UIFont {
    static let subtitleFont = UIFont.systemFont(ofSize: 25, weight: .bold)
    static let boldFont = UIFont.boldSystemFont(ofSize: 18)
    static let bodyFont = UIFont.systemFont(ofSize: 16)
    static let detailFont = UIFont.systemFont(ofSize: 15)
}

extension UIView {
    func setUp(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
}

extension UIImageView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from urlStr: String) {
        let url = URL(string: urlStr)
        guard let url = url else {
            print("Couldn't create url object")
            return
        }
                      
        getData(from: url) {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            // sync? async(원래코드)
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
}

