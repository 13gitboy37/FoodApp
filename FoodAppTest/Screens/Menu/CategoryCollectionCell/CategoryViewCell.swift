//
//  CollectionViewCell.swift
//  FoodAppTest
//
//  Created by Никита Мошенцев on 17.10.2022.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryButton: UIButton!
    
    weak var delegate: MenuViewInput?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func tapCategory(_ sender: UIButton) {
        categoryButton.layer.cornerRadius = 20
        
        var row = 0
        
        if sender.titleLabel?.text == "Пицца" {
            
        } else if sender.titleLabel?.text == "Комбо" {
            row = 5
        } else if sender.titleLabel?.text == "Десерты" {
            row = 11
        } else if sender.titleLabel?.text == "Напитки" {
            row = 17
        }
        
        delegate?.scrollToSection(row: row)
        categoryButton.backgroundColor = UIColor(red: 255/255, green: 182/255, blue: 193/255, alpha: 0.5)
    }
    
    func configure(category: String) {
        categoryButton.setTitle(category, for: .normal)
    }
    
}
