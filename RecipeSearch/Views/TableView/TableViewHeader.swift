//
//  TableViewHeader.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/27/24.
//

import UIKit

class TableViewHeader: UIView {

    private var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = .boldFont
        label.textColor = .white
        label.backgroundColor = .black.withAlphaComponent(0.5)
        return label
    }()
    
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        self.addSubview(mainImageView)
        self.addSubview(recipeNameLabel)
        NSLayoutConstraint.activate([
            self.mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - URL ===> 이미지를 셋팅하는 메서드
    private func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async {
        
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
    }
    
}
