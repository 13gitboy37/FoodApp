//
//  ViewController.swift
//  FoodAppTest
//
//  Created by Никита Мошенцев on 13.10.2022.
//

import UIKit

final class MenuViewController: UIViewController {
    
    //MARK: Outlet`s
    
    @IBOutlet weak var cityButton: UIButton!
    
    @IBOutlet weak var menuTableView: UITableView!
    
    //MARK: Private properties
    
    private var headerHeight: CGFloat = 40.0
    
    private let categoryArray = ["Пицца", "Комбо", "Десерты", "Напитки"]
    
    var output: MenuViewOutput?
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupPullDownMenu()
        registerCells()
        output = MenuPresenter(menuView: self)
        output?.fetchMenu()
    }
    
    //MARK: Private Methods
    
    private func configure() {
        menuTableView.dataSource = self
        menuTableView.delegate = self
    }
    
    private func registerCells() {
        menuTableView.register(UINib(nibName: "BannerTableCell", bundle: nil), forCellReuseIdentifier: "bannerCell")
        menuTableView.register(UINib(nibName: "MenuTableCell", bundle: nil), forCellReuseIdentifier: "tableCell")
    }
    
    private func setupPullDownMenu() {
        
        let menuClosure = { (action: UIAction) in
            
        }
        
        cityButton.menu = UIMenu(children: [
            UIAction(title: "Москва", state: .on, handler:
                        menuClosure),
            UIAction(title: "Санкт-Петербург", handler: menuClosure)
        ])
        cityButton.showsMenuAsPrimaryAction = true
        cityButton.changesSelectionAsPrimaryAction = true
    }
}

//MARK: TableView DataSource

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        output?.numberOfSection() ?? 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            return configureHeaderView()
        }        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0
        } else {
            return headerHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.numberOfRowInSection(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        output?.cellForRowAt(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}

//MARK: TableView Delegata

extension MenuViewController: UITableViewDelegate {
    
}

//MARK: CollectionView Data Source and DelegateFlowLayout

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureHeaderView() -> UIView {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let headerView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight),
                                          collectionViewLayout: layout)
        headerView.isPagingEnabled = true
        headerView.isUserInteractionEnabled = true
        
        headerView.dataSource = self
        headerView.delegate = self
        headerView.register(UINib(nibName: "CategoryViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        headerView.showsHorizontalScrollIndicator = false
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output?.numberItemsInSection(collectionView, numberOfItemsInSection: section) ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        output?.cellForItemAt(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95, height: 32)
    }
}

extension MenuViewController: MenuViewInput {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.menuTableView.reloadData()
        }
    }
    
    func scrollToSection(row: Int) {
        menuTableView.scrollToRow(at: IndexPath(row: row, section: 1), at: .top, animated: true)
    }
}
