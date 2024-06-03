//
//  RecipesViewController.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/27/24.
//

import UIKit

class RecipesViewController: UIViewController {

    var coreDataManager = CoreDataManager.shared
    
    var tableView: UITableView!
    
    var myPicksArray: [Recipes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .backgroundColor
    }
    
    // MARK: - ColletionView Data Setup
    func setupData1() {
        myPicksArray = coreDataManager.coreDataToCustomData()
//        DispatchQueue.main.async {
//            self.collectionView.reloadSections(IndexSet(integer: 0))
//        }
    }
    
    func setupTableView() {
        self.tableView = UITableView()
        view.addSubview(tableView)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
        
        // 델리게이트 설정
        self.tableView.dataSource = self
        // self.tableView.delegate = self
        
        // 셀 등록
        self.tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "RecipeTableViewCell")

        // 테이블 뷰 오토레이아웃
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }

}


extension RecipesViewController: UITableViewDataSource {
    // 섹션 별 cell 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPicksArray.count
    }
    
    // 각 섹션-셀 별 cell 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
        
        // cell.descriptionLabel.text = recipes?.ingredient
        cell.selectionStyle = .none
        
        return cell
    }
}
