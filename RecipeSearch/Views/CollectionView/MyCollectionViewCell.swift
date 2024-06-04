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
    
    private let gradientView: UIView = {
        let view = UIView() // <- 이렇게 하면 안보임
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe"
        label.font = .boldFont
        label.textColor = .white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Initializer
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(mainImageView)
        self.contentView.addSubview(gradientView)
        self.gradientView.addSubview(recipeNameLabel)
        setupAutoLayout()
        // setupGradient()
        // setupShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행 ⭐️
        self.mainImageView.image = nil
        
        // 그라데이션 뷰 짤림
        guard let sublayers = gradientView.layer.sublayers else {return}
        for item in sublayers {
            if item.name == "gradientLayer" {
                item.removeFromSuperlayer()
            }
        }
    }
    
    func setupAutoLayout() {
        NSLayoutConstraint.activate([
            mainImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            mainImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            mainImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            
            gradientView.leftAnchor.constraint(equalTo: mainImageView.leftAnchor),
            gradientView.rightAnchor.constraint(equalTo: mainImageView.rightAnchor),
            gradientView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            gradientView.topAnchor.constraint(equalTo: mainImageView.topAnchor),
            
            recipeNameLabel.leftAnchor.constraint(equalTo: gradientView.leftAnchor, constant: 10),
            recipeNameLabel.rightAnchor.constraint(equalTo: gradientView.rightAnchor, constant: -10),
            recipeNameLabel.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -10),
        ])
    }
    
    func setupGradient() {
        // 그라데이션 코드
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "gradientLayer" // 삭제하기 위한 식별자
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.55, y: 0.55)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.locations = [0.0, 1.0]
        // view.layer.addSublayer(gradientLayer)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
    }
}


