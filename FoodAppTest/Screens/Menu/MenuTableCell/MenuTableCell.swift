//
//  MenuTableCell.swift
//  FoodAppTest
//
//  Created by Никита Мошенцев on 16.10.2022.
//

import UIKit
import Kingfisher

class MenuTableCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with model: Beer) {
        avatarImage.kf.setImage(with: URL(string: model.imageUrl), placeholder: UIImage(systemName: "person.fill"))
        nameLabel.text = model.name
        descriptionLabel.text = model.description
    }
}
