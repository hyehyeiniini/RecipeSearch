//
//  RecipeTableViewCell.swift
//  RecipeSearch
//
//  Created by Chris lee on 6/2/24.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldFont
        label.textColor = .darkColor
        return label
    }()
    
    let recipeWayLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyFont
        label.textColor = .black
        return label
    }()
    
    let recipeCalLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyFont
        label.textColor = .black
        return label
    }()
    
    private lazy var subStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [recipeWayLabel, recipeCalLabel])
        st.axis = .vertical
        st.spacing = 8
        st.alignment = .fill
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        // st.backgroundColor = .yellow
        return st
    }()
    
    private lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [recipeNameLabel, subStackView])
        st.axis = .vertical
        st.spacing = 10
        st.alignment = .fill
        st.distribution = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        // st.backgroundColor = .lightGray
        return st
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [mainImageView, stackView].forEach {
            self.contentView.addSubview($0)
        }
        self.backgroundColor = .backgroundColor
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            mainImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 100),
            mainImageView.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.leadingAnchor.constraint(equalTo: self.mainImageView.trailingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
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
