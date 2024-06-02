//
//  EmptyCollectionViewCell.swift
//  RecipeSearch
//
//  Created by Chris lee on 6/2/24.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "EmptyCollectionViewCell"
    
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.05)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "info.circle.fill")?.withTintColor(.pointColor, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "레시피를 추가해 보세요."
        label.textColor = .darkGray
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "추가한 레시피들이 화면에 나타납니다."
        label.textColor = .lightGray
        label.font = UIFont(name: "HelveticaNeue-light", size: 13)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(emptyView)
        
        emptyView.addSubview(infoImageView)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        setupAutoLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            infoImageView.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 55),
            infoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoImageView.heightAnchor.constraint(equalToConstant: 30),
            infoImageView.widthAnchor.constraint(equalToConstant: 30),
 
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: infoImageView.bottomAnchor, constant: 8),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20),
            messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20),
            
        ])
    }
}
