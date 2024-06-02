//
//  MyCollectionViewCell.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/26/24.
//

import UIKit

final class MyCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "MyCollectionViewCell"
    
    // MARK: UI
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    // MARK: Initializer
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.mainImageView)
        setupAutoLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행 ⭐️
        self.mainImageView.image = nil
    }
    
    func setupAutoLayout() {
        NSLayoutConstraint.activate([
            self.mainImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.mainImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.mainImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.mainImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        ])
    }
    
}


