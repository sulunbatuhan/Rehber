//
//  FavoriteCell.swift
//  Rehber
//
//  Created by batuhan on 15.10.2023.
//

import UIKit

final class FavoriteCell: UICollectionViewCell {
    
    static let identifier = "favoriteCell"
    
    var contact : Contact! {
        didSet{
            personPhotos.image = UIImage(data: contact.userPhoto ?? Data())
        }
    }
    
    let personPhotos : UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "none")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 40
        img.clipsToBounds = true
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(personPhotos)
        personPhotos.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
