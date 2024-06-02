//
//  EmptyCollectionView.swift
//  RecipeSearch
//
//  Created by Chris lee on 6/2/24.
//

import UIKit

class EmptyCollectionView: UICollectionReusableView {
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "message"
        label.textColor = .lightGray
        label.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emptyView)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: self.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            messageLabel.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: -20),
            messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20),
            messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
