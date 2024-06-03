//
//  IngredientCellTableViewCell.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/27/24.
//

import UIKit

final class IngredientCellTableViewCell: UITableViewCell {

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .detailFont
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
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
