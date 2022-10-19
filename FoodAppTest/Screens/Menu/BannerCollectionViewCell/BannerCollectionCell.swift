//
//  BannerCollectionCell.swift
//  FoodAppTest
//
//  Created by Никита Мошенцев on 16.10.2022.
//

import UIKit

class BannerCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerImage.layer.cornerRadius = 8
        bannerImage.layer.masksToBounds = true
    }
    
    func configure(image: UIImage?) {
        self.bannerImage.image = image
    }
}
