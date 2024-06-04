//
//  ForYouViewController.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/25/24.
//

import UIKit
import Kingfisher

final class ForYouViewController: UIViewController {
    
    let networkManager = NetworkManager.shared
    let coreDataManager = CoreDataManager.shared
    
    var myPicksArray: [Recipes] = []
    var recipesArray: [Recipes] = []
    
    lazy var resultsController = SearchResultViewController()
    lazy var searchController = UISearchController(searchResultsController: self.resultsController)
    
    private lazy var collectionView: UICollectionView = {
        // UI 관련 설정
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        view.backgroundColor = .backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = true
        
        // 델리게이트 설정
        view.delegate = self
        view.dataSource = self
        
        // 셀 등록
        view.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.cellIdentifier)
        view.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: EmptyCollectionViewCell.cellIdentifier)
        view.register(MyCollectionReusableView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: MyCollectionReusableView.headerIdentifier)
        view.register(DividerFooterView.self, forSupplementaryViewOfKind: "Footer", withReuseIdentifier: DividerFooterView.footerIdentifier)
        
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // 서치바 설정
        setupSearchBar()
        // 컬렉션뷰 설정
        setupData2()
        setupCollectionView()
        configureCompositionalLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData1()
    }
    
    // MARK: - UISetup
    func setupUI() {
        view.backgroundColor = .backgroundColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    // MARK: - SearchBar Setup
    // 서치바 셋팅
    func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.placeholder = "Search Recipes..."
        
        // 🍎 2) 서치(결과)컨트롤러의 사용 (복잡한 구현 가능)
        //     ==> 글자마다 검색 기능 + 새로운 화면을 보여주는 것도 가능
        searchController.searchResultsUpdater = self

        searchController.searchBar.autocapitalizationType = .none
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.spellCheckingType = .no
        
        resultsController.rootViewController = self
    }
    
    // MARK: - ColletionView Data Setup
    func setupData1() {
        myPicksArray = coreDataManager.coreDataToCustomData()
        DispatchQueue.main.async {
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func setupData2() {
        networkManager.getRecipes(recipeName: nil){ Result in
            if let Result = Result {
                self.recipesArray = Result
                DispatchQueue.main.async {
                    self.collectionView.reloadSections(IndexSet(integer: 1))
                }
            }
        }
    }
    
    func setupCollectionView() {
        self.view.addSubview(self.collectionView)
        collectionView.setUp(to: view)
    }
}

//MARK: -  🍎 검색하는 동안 (새로운 화면을 보여주는) 복잡한 내용 구현 가능
extension ForYouViewController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        // print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        let vc = searchController.searchResultsController as! SearchResultViewController
        // 컬렉션뷰에 찾으려는 단어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}

// MARK: - CollectionView
extension ForYouViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 각 섹션의 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return myPicksArray.count > 0 ? myPicksArray.count : 1 // 임시값
        case 1 :
            return recipesArray.count
        default:
            return 0
        }
    }
    
    // 섹션 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // 섹션의 아이템 셀 전달
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // print(#function)
        switch indexPath.section {
        case 0 :
            // Empty View
            if myPicksArray.count == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.cellIdentifier, for: indexPath) as? EmptyCollectionViewCell else {fatalError("Unable deque cell...")}
                return cell
            }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.cellIdentifier, for: indexPath) as? MyCollectionViewCell else {fatalError("Unable deque cell...")}
            
            let imageUrl = myPicksArray[indexPath.row].imageUrl
            cell.mainImageView.kf.setImage(with: URL(string: imageUrl))
            cell.recipeNameLabel.text = myPicksArray[indexPath.row].recipeName
            cell.setupGradient()
            cell.setupShadow()
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.cellIdentifier, for: indexPath) as? MyCollectionViewCell else {fatalError("Unable deque cell...")}
            let imageUrl = recipesArray[indexPath.row].imageUrl
            cell.mainImageView.kf.setImage(with: URL(string: imageUrl))
            cell.recipeNameLabel.text = recipesArray[indexPath.row].recipeName
            cell.setupGradient()
            cell.setupShadow()
            return cell
        }
    }
    
    // 섹션의 헤더 뷰 전달
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "Header" {
            switch indexPath.section {
            case 0 :
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyCollectionReusableView.headerIdentifier, for: indexPath) as! MyCollectionReusableView
                header.prepare(text: "My Picks")
                return header
            default :
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyCollectionReusableView.headerIdentifier, for: indexPath) as! MyCollectionReusableView
                header.prepare(text: "Recently Registered")
                return header
            }
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DividerFooterView.footerIdentifier, for: indexPath) as! DividerFooterView
            return footer
        }
    }
    
    // 상세 페이지로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        switch indexPath.section {
        case 0:
            if myPicksArray.count == 0 { return }
            detailVC.recipes = myPicksArray[indexPath.row]
        default:
            detailVC.recipes = recipesArray[indexPath.row]
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


extension ForYouViewController {
    func configureCompositionalLayout(){
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                // Empty View
                if self.myPicksArray.count == 0 {
                    return AppLayouts.shared.recentlyRegisteredCarouselView()
                }
                return AppLayouts.shared.myPicksCarouselView()
            default:
                return AppLayouts.shared.recentlyRegisteredCarouselView()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}
