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
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // 이미지 URL을 전달받는 속성
    var imageUrl: String? {
        didSet {
            loadImage()
        }
    }
    
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
    
    // MARK: - URL ===> 이미지를 셋팅하는 메서드
    private func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async {
        
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
                self.mainImageView.contentMode = .scaleAspectFill
                self.mainImageView.layer.cornerRadius = 8
                self.mainImageView.clipsToBounds = true
            }
        }
    }
}


