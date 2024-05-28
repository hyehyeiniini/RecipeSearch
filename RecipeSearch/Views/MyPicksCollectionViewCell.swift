//
//  MyPicksCollectionViewCell.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/25/24.
//

import UIKit

class MyPicksCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    // 이미지 URL을 전달받는 속성
    var imageUrl: String? {
        didSet {
            // loadImage()
            DispatchQueue.main.async {
                self.imageView?.image = UIImage(systemName: "circle.fill")
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 셀이 재사용되기 전에 호출되는 메서드
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 일반적으로 이미지가 바뀌는 것처럼 보이는 현상을 없애기 위해서 실행 ⭐️
        self.imageView.image = nil
    }
    
    // URL ===> 이미지를 셋팅하는 메서드
    private func loadImage() {
        guard let urlString = self.imageUrl, let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            // 오래걸리는 작업이 일어나고 있는 동안에 url이 바뀔 가능성 제거 ⭐️⭐️⭐️
            guard urlString == url.absoluteString else { return }
            
            DispatchQueue.main.async {
                print(data)
                self.imageView.image = UIImage(data: data)
            }
        }
    }
}
