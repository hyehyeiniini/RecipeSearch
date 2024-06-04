//
//  RecipesViewController.swift
//  RecipeSearch
//
//  Created by Chris lee on 5/27/24.
//

import UIKit
import Kingfisher

final class RecipesViewController: UIViewController {
    
    let coreDataManager = CoreDataManager.shared
    
    var tableView: UITableView!
    
    var myPicksArray: [Recipes] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if tableView.isEditing {
            toggleEditButton()
        }
    }
    
    func setupUI() {
        view.backgroundColor = .backgroundColor
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target: nil, action: nil)
        
        let rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    // MARK: - TableView Data Setup
    func setupData() {
        myPicksArray = coreDataManager.coreDataToCustomData()
        // dump(myPicksArray)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        self.tableView = UITableView()
        view.addSubview(tableView)
        
        self.tableView.backgroundColor = .backgroundColor
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
        
        // 델리게이트 설정
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
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
    
    // MARK: - 편집 기능 구현
    @objc func editButtonTapped() {
        toggleEditButton()
    }
    
    func toggleEditButton() {
        let shouldBeEdited = !tableView.isEditing
        tableView.setEditing(shouldBeEdited, animated: true)
        if navigationItem.rightBarButtonItem?.title == "Done" {
            navigationItem.rightBarButtonItem?.title = "Edit"
        } else {
            navigationItem.rightBarButtonItem?.title = "Done"
        }
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
        
        let recipe = myPicksArray[indexPath.row]
        cell.mainImageView.kf.setImage(with: URL(string: recipe.imageUrl))
        cell.recipeNameLabel.text = recipe.recipeName
        cell.recipeCalLabel.text = "열량: \(recipe.recipeCal)"
        cell.recipeWayLabel.text = "조리 방법: \(recipe.recipeWay)"
        
        cell.selectionStyle = .none
        return cell
    }
}

extension RecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.recipes = myPicksArray[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // 삭제 기능 구현
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let recipeName = myPicksArray[indexPath.row].recipeName
        self.myPicksArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        coreDataManager.deleteRecipeData(data: recipeName) {
            // self.tableView.reloadData()
        }
    }
    
    // 이동 기능 구현
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }

    
}
