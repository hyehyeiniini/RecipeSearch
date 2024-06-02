//
//  SearchResultViewController.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/25/24.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    weak var rootViewController: UIViewController?    
    
    // 네트워크 매니저 (싱글톤)
    let networkManager = NetworkManager.shared
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
    }

    func setupUI() {
        view.backgroundColor = .backgroundColor
        rootViewController?.navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
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
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
    }
    
    func setupData(searchTerm: String?) {
        print(#function)
        networkManager.getRecipes(recipeName: searchTerm){ Result in
            if let Result = Result {
                self.recipesArray = Result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}

extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.cellIdentifier, for: indexPath) as! MyCollectionViewCell
        cell.imageUrl = recipesArray[indexPath.item].imageUrl
        
        return cell
    }
    
    // 상세 페이지로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let detailVC = DetailViewController()
        detailVC.recipes = recipesArray[indexPath.row]
        rootViewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
