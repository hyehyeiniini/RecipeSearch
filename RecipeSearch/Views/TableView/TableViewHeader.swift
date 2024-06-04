//
//  TableViewHeader.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/27/24.
//

import UIKit

final class TableViewHeader: UIView {

    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gradientView: UIView = {
        let view = UIView() // <- 이렇게 하면 안보임
//        view.layer.cornerRadius = 8
//        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe"
        label.font = .subtitleFont
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        self.addSubview(mainImageView)
        self.addSubview(gradientView)
        self.gradientView.addSubview(recipeNameLabel)
        
        setupAutoLayout()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAutoLayout() {
        NSLayoutConstraint.activate([
            self.mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            gradientView.leftAnchor.constraint(equalTo: mainImageView.leftAnchor),
            gradientView.rightAnchor.constraint(equalTo: mainImageView.rightAnchor),
            gradientView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            gradientView.topAnchor.constraint(equalTo: mainImageView.topAnchor),
            
            recipeNameLabel.leftAnchor.constraint(equalTo: gradientView.leftAnchor, constant: 25),
            // recipeNameLabel.rightAnchor.constraint(equalTo: gradientView.rightAnchor, constant: -25),
            recipeNameLabel.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -25),
        ])
    }
    
    func setupGradient() {
        // 그라데이션 코드
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.locations = [0.0, 1.0]
        // view.layer.addSublayer(gradientLayer)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
