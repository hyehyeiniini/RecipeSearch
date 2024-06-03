//
//  ManualTableViewCell.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/27/24.
//

import UIKit
import Kingfisher

class ManualTableViewCell: UITableViewCell {

    var manual: Manual? {
        didSet{
            guard let manual = manual else { return }
            numberImageView.image = UIImage(systemName: "\(manual.manualNum).circle.fill")?.withTintColor(.pointColor, renderingMode: .alwaysOriginal)
            descriptionImageView.kf.setImage(with: URL(string: manual.manualUrl))
        }
    }
    
    var numberImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .detailFont
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var descriptionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [numberImageView, descriptionLabel, descriptionImageView].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            numberImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            numberImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            numberImageView.heightAnchor.constraint(equalToConstant: 20),
            numberImageView.widthAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: numberImageView.trailingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            descriptionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            
            descriptionImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionImageView.heightAnchor.constraint(equalToConstant: 100),
            descriptionImageView.widthAnchor.constraint(equalToConstant: 100),
            descriptionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
