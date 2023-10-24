//
//  MainCell.swift
//  Rehber-Udemy
//
//  Created by batuhan on 7.08.2023.
//

import Foundation
import UIKit

final class MainCell : UITableViewCell {
    static let identifier = "mainCell"
    
    var contact : Contact! {
        didSet{
            userName.text = "\(contact.name!) \(contact.surname ?? "") "
            number.text = contact.number
            userImage.image = UIImage(data: contact.userPhoto ?? Data())
        }
    }
    
    private let userImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "none")
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userName:UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18,weight: .medium)
        label.textColor = .black
        return label
    }()
    
    
    private let number : UILabel = {
       let number = UILabel()
        number.font = UIFont.systemFont(ofSize: 14,weight: .light)
        number.textColor = .black
        return number
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(userImage,userName,number)
    }
    
    override func layoutSubviews() {
        userImage.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom:0 , paddingLeft: 30, paddingRight: 0, width: 50, height: 50)
        userName.anchor(top: userImage.topAnchor, bottom: nil, leading: userImage.trailingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: 0, height: 20)
        number.anchor(top: userName.bottomAnchor, bottom: nil, leading: userImage.trailingAnchor, trailing: trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 20, paddingRight: -10, width: 0, height: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

