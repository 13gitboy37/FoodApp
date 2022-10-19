//
//  MenuViewPresenter.swift
//  FoodAppTest
//
//  Created by Никита Мошенцев on 19.10.2022.
//

import UIKit

protocol MenuViewInput: AnyObject {
    func reloadTableView()
    func scrollToSection(row: Int)
}

protocol MenuViewOutput: AnyObject {
    func fetchMenu()
    func numberOfSection() -> Int
    func numberOfRowInSection(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func numberItemsInSection(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func cellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class MenuPresenter {
    
    weak var menuView: MenuViewInput?
    
    var networkService = NetworkService()
    
    private let categoryArray = ["Пицца", "Комбо", "Десерты", "Напитки"]
    
    var beers = [Beer]() {
        didSet {
            menuView?.reloadTableView()
        }
    }
    
    private let bannerImageArray = [UIImage(named: "banner1"), UIImage(named: "banner2")]
    
    init(menuView: MenuViewInput) {
        self.menuView = menuView
    }
    
}

extension MenuPresenter: MenuViewOutput {
    
    func fetchMenu() {
        networkService.fetchMenu { [weak self] result in
            switch result {
            case .success(let beers):
                self?.beers = beers
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfSection() -> Int {
        return 2
    }
    
    func numberOfRowInSection(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if section == 0 {
            rows = 1
        } else {
            rows = beers.count
        }
        
        return rows
    }
    
    func cellForRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: "bannerCell")
            guard let cell = bannerCell as? BannerTableCell else { return UITableViewCell() }
            return cell
            
        } else {
            
            let menuCell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            guard let cell = menuCell as? MenuTableCell else { return UITableViewCell() }
            let currentBeer = beers[indexPath.row]
            
            cell.configure(with: currentBeer)
            return cell
            
        }
    }
    
    func numberItemsInSection(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentCategory = categoryArray[indexPath.item]
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
        guard let cell = categoryCell as? CategoryViewCell else { return UICollectionViewCell() }
        cell.configure(category: currentCategory)
        cell.delegate = menuView
        return cell
    }
}
