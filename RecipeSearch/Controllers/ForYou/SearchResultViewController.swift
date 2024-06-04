//
//  SearchResultViewController.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/25/24.
//

import UIKit

final class SearchResultViewController: UIViewController {
    
    var delegate: SearchResultViewControllerDelegate?
    
    // 네트워크 매니저 (싱글톤)
    let networkManager = NetworkManager.shared
    
    var stackView: UIStackView!
    var recipeWayButtons: [UIButton] = []
    
    // 컬렉션뷰
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = true
        view.delegate = self
        view.dataSource = self
        
        view.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.cellIdentifier)
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    // (서치바에서) 검색을 위한 단어를 담는 변수 (전화면에서 전달받음)
    var searchTerm: String? {
        didSet {
            setupData(searchTerm: searchTerm)
        }
    }

    var recipesArray: [Recipes] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButtons()
        setupCollectionView()
    }

    func setupUI() {
        view.backgroundColor = .backgroundColor
        delegate?.hideNavigationBar()
    }
    
    func setupButtons() {
        let buttonTitles = ["밥", "반찬", "국&찌개", "후식", "기타"]
        buttonTitles.forEach {
            let button = UIButton()
            button.setTitle($0, for: .normal)
            button.setTitle($0, for: .selected)

            button.setTitleColor(.orange, for: .normal)
            button.setTitleColor(.pointColor, for: .selected)
            
            button.titleLabel?.font = .systemFont(ofSize: 13)
            button.backgroundColor = .white
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.orange.cgColor
            button.clipsToBounds = true
            button.layer.cornerRadius = 14
            button.isSelected = false
            button.addTarget(self, action: #selector(recipeWayButtonsSelected), for: .touchUpInside)
            recipeWayButtons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: recipeWayButtons)
        view.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        
        // 컬렉션뷰의 레이아웃을 담당하는 객체
        let flowLayout = UICollectionViewFlowLayout()
        
        collectionView.dataSource = self
        collectionView.backgroundColor = .backgroundColor
       
        // 컬렉션뷰의 스크롤 방향 설정
        flowLayout.scrollDirection = .vertical
        
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWitdh * (CVCell.cellColumns - 1)) / CVCell.cellColumns
        
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth)
        // 아이템 사이 간격 설정
        flowLayout.minimumInteritemSpacing = CVCell.spacingWitdh
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = CVCell.spacingWitdh
        
        // 컬렉션뷰의 속성에 할당
        collectionView.collectionViewLayout = flowLayout
        
        // 컬렉션뷰 레이아웃 설정
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
    }
    
    func setupData(searchTerm: String?) {
        print("서치바에 입력되는 단어", searchTerm ?? "")
        let param = "\(searchTerm ?? "")"
        networkManager.getRecipes(param: param){ Result in
            if let Result = Result {
                self.recipesArray = Result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func clearData() {
        recipesArray = []
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func initButton() {
        for button in recipeWayButtons {
            button.isSelected = false
            button.layer.borderColor = UIColor.orange.cgColor
        }
    }
    
    @objc func recipeWayButtonsSelected(_ sender: UIButton) {
        // 선택한 버튼이면 초기화
        if sender.isSelected {
            sender.isSelected.toggle()
            sender.layer.borderColor = UIColor.orange.cgColor
            clearData()
            return
        }
        else {
            delegate?.recipeWaySearch(recipeWay: sender.titleLabel?.text)
            for button in recipeWayButtons {
                button.isSelected = false
                button.layer.borderColor = UIColor.orange.cgColor
            }
            sender.isSelected = true
            sender.layer.borderColor = UIColor.pointColor.cgColor
        }

    }
    
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.cellIdentifier, for: indexPath) as! MyCollectionViewCell
        let imageUrl = recipesArray[indexPath.item].imageUrl
        cell.mainImageView.kf.setImage(with: URL(string: imageUrl))
        cell.setupGradient()
        cell.recipeNameLabel.text = ""
        return cell
    }
    
    // 상세 페이지로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let detailVC = DetailViewController()
        detailVC.recipes = recipesArray[indexPath.row]
        delegate?.pushViewController(detailVC, animated: true)
    }
}

protocol SearchResultViewControllerDelegate {
    func recipeWaySearch(recipeWay: String?)
    
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    
    func hideNavigationBar() 
}
