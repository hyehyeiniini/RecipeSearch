//
//  NutritionInfoTableViewCell.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/26/24.
//

import UIKit

final class NutritionInfoTableViewCell: UITableViewCell {
    
    var info: [String]? {
        didSet {
            guard let info = info else { return }
            calValLabel.text = String(info[0])
            carValLabel.text = String(info[1])
            proValLabel.text = String(info[2])
            fatValLabel.text = String(info[3])
            naValLabel.text = String(info[4])
        }
    }
    
    let verticalSpacing = CGFloat(5)
    
    private let calLabel: UILabel = {
        let label = UILabel()
        label.text = "열량"
        label.font = .boldFont
        label.textColor = .pointColor
        return label
    }()
    
    private let calValLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .bodyFont
        label.textColor = .black
        return label
    }()
    
    private let carLabel: UILabel = {
        let label = UILabel()
        label.text = "탄수화물"
        label.font = .boldFont
        label.textColor = .pointColor
        return label
    }()
    
    private let carValLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .bodyFont
        label.textColor = .black
        return label
    }()
    
    private let proLabel: UILabel = {
        let label = UILabel()
        label.text = "단백질"
        label.font = .boldFont
        label.textColor = .pointColor
        return label
    }()
    
    private let proValLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .bodyFont
        label.textColor = .black
        return label
    }()
    
    private let fatLabel: UILabel = {
        let label = UILabel()
        label.text = "지방"
        label.font = .boldFont
        label.textColor = .pointColor
        return label
    }()
    
    private let fatValLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .bodyFont
        label.textColor = .black
        return label
    }()
    
    private let naLabel: UILabel = {
        let label = UILabel()
        label.text = "나트륨"
        label.font = .boldFont
        label.textColor = .pointColor
        return label
    }()
    
    private let naValLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .bodyFont
        label.textColor = .black
        return label
    }()
    
    private lazy var calStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [calLabel, calValLabel])
        st.axis = .vertical
        st.spacing = verticalSpacing
        st.alignment = .center
        st.distribution = .fill
        return st
    }()
    
    private lazy var carStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [carLabel, carValLabel])
        st.axis = .vertical
        st.spacing = verticalSpacing
        st.alignment = .center
        st.distribution = .fill
        return st
    }()
    
    private lazy var proStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [proLabel, proValLabel])
        st.axis = .vertical
        st.spacing = verticalSpacing
        st.alignment = .center
        st.distribution = .fill
        return st
    }()
    
    private lazy var fatStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [fatLabel, fatValLabel])
        st.axis = .vertical
        st.spacing = verticalSpacing
        st.alignment = .center
        st.distribution = .fill
        return st
    }()
    
    private lazy var naStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [naLabel, naValLabel])
        st.axis = .vertical
        st.spacing = verticalSpacing
        st.alignment = .center
        st.distribution = .fill
        return st
    }()
    
    private lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [calStackView, carStackView, proStackView, fatStackView, naStackView])
        st.axis = .horizontal
        st.alignment = .fill
        st.distribution = .fillEqually
        return st
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
