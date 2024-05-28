//
//  MyCollectionReusableView.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/26/24.
//

import UIKit

class MyCollectionReusableView: UICollectionReusableView {
    
    static let headerIdentifier = "MyCollectionReusableView"
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.font = UIFont.subtitleFont
        label.textColor = .black
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
      }()
      
      override init(frame: CGRect) {
        super.init(frame: frame)

        NSLayoutConstraint.activate([
          self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
          self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
      }
      
      required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
      
      override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: nil)
      }
      
      func prepare(text: String?) {
        self.label.text = text
      }
}
