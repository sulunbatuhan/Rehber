//
//  HeaderView.swift
//  Rehber-Udemy
//
//  Created by batuhan on 6.08.2023.
//

import Foundation
import UIKit
protocol UserImageDelegate{
    func buttonTapped()
}

class HeaderView : UIView {
    var delegate : UserImageDelegate?
    
     let userIcon : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setImage(UIImage(named: "none")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 60
        button.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        return button
    }()
    
    @objc func addImage(){
        delegate?.buttonTapped()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        backgroundColor = .white
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 20, height: 30)
        addSubviews(userIcon)
        userIcon.anchor(top: topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 20, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: 120, height: 120)
        userIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
