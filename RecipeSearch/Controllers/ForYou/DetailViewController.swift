//
//  DetailViewController.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/26/24.
//

import UIKit

class DetailViewController: UIViewController {

    let coreDataManager = CoreDataManager.shared
    
    var tableView: UITableView!
    
    var recipes: Recipes?
    
    var bookMarked = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setBookmarkFlag()
        setupNavigationBar()
        updateRightBarButton(bookMarked: bookMarked)
        setupTableView()
    }
    
    func setupUI() {
        view.backgroundColor = .backgroundColor
    }
    
    func setBookmarkFlag() {
        guard let recipeName = recipes?.recipeName else { return }
        if coreDataManager.contains(data: recipeName) {
            bookMarked = true
        } else {
            bookMarked = false
        }
    }
    
    func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = recipes?.recipeName
        // navigationItem.rightBarButtonItem = bookMarksButton
        
        self.navigationController?.navigationBar.tintColor = .pointColor        
    }
    
    func updateRightBarButton(bookMarked: Bool) {
        let button = UIButton(frame: CGRectMake(0,0,30,30))
        button.addTarget(self, action: #selector(bookMarksButtonTapped), for: .touchUpInside)

        switch bookMarked {
        case true:
            print("추가된 레시피👍")
            button.setImage(UIImage(systemName: "book.fill"), for: .normal)
        default:
            print("추가되지 않음")
            button.setImage(UIImage(systemName: "book"), for: .normal)
        }
        let rightButton = UIBarButtonItem(customView: button)
        // navigationItem.rightBarButtonItem = rightButton
        navigationItem.setRightBarButton(rightButton, animated: true)
    }
    
    func setupTableView() {
        self.tableView = UITableView()
        view.addSubview(tableView)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
        
        // 델리게이트 설정
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // 헤더 뷰 등록(레시피 사진)
        let tableViewHeader = TableViewHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400))
        tableViewHeader.imageUrl = recipes?.imageUrl
        self.tableView.tableHeaderView = tableViewHeader
        if #available(iOS 15.0, *) {tableView.sectionHeaderTopPadding = 0.0}
        
        // 푸터 뷰 등록
        let tableViewFooter = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        tableViewFooter.backgroundColor = .clear
        self.tableView.tableFooterView = tableViewFooter
        
        
        // 셀 등록
        self.tableView.register(NutritionInfoTableViewCell.self, forCellReuseIdentifier: "NutritionInfoTableViewCell")
        self.tableView.register(IngredientCellTableViewCell.self, forCellReuseIdentifier: "IngredientCellTableViewCell")
        self.tableView.register(ManualTableViewCell.self, forCellReuseIdentifier: "ManualTableViewCell")
        
        // 테이블 뷰 오토레이아웃
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

        ])
        
        // ⭐️ 이미지 navigation bar 위로?
        if #available(iOS 11.0, *)
        {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    

    
    @objc func bookMarksButtonTapped() {
        print(#function)
        if !bookMarked {
            coreDataManager.saveData(recipe: recipes!) {
                print("코어데이터 저장")
            }
        } else {
            coreDataManager.deleteRecipeData(data: recipes!.recipeName) {
                print("코어데이터 지우기")
            }
        }
        bookMarked.toggle()
        updateRightBarButton(bookMarked: bookMarked)
    }
}

extension DetailViewController: UITableViewDataSource {
    // 섹션 갯수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    // 섹션 별 cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [1, 1, recipes?.manualArray.count ?? 0][section]
    }
    
    // 각 섹션-셀 별 cell 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionInfoTableViewCell", for: indexPath) as! NutritionInfoTableViewCell
            
            let recipeCal = recipes?.recipeCal ?? "0"
            let infoCar = recipes?.infoCar ?? "0"
            let infoPro = recipes?.infoPro ?? "0"
            let infoFat = recipes?.infoFat ?? "0"
            let infoNa = recipes?.infoNa ?? "0"
            
            cell.info = [recipeCal, infoCar, infoPro, infoFat, infoNa]
            cell.selectionStyle = .none
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCellTableViewCell", for: indexPath) as! IngredientCellTableViewCell
            
            cell.descriptionLabel.text = recipes?.ingredient
            cell.selectionStyle = .none
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ManualTableViewCell", for: indexPath) as! ManualTableViewCell
            
            cell.manual = recipes?.manualArray[indexPath.row]
            cell.descriptionLabel.text = recipes?.manualArray[indexPath.row].manualStr
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    // MARK: - Section Header
    //header list에서 해당하는 section 번호로 인덱스 접근
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["", "재료", "만드는법"][section]
    }
    
    //header 두께 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

}


extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
