//
//  BannerTableCell.swift
//  FoodAppTest
//
//  Created by Никита Мошенцев on 17.10.2022.
//

import UIKit

class BannerTableCell: UITableViewCell {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    private let bannerImageArray = [UIImage(named: "banner1"), UIImage(named: "banner2")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        bannerCollectionView.register(
            UINib(nibName: "BannerCollectionCell", bundle: nil),
            forCellWithReuseIdentifier: "bannerCell")
    }
}

extension BannerTableCell: UICollectionViewDelegate {
    
}

extension BannerTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bannerImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bannerCell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath)
        
        guard let cell = bannerCell as? BannerCollectionCell else { return UICollectionViewCell() }
        
        let currentBanner = bannerImageArray[indexPath.item]
        
        cell.configure(image: currentBanner)
        
        return cell
    }
}
