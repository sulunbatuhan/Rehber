//
//  TextFieldCell.swift
//  Rehber-Udemy
//
//  Created by batuhan on 6.08.2023.
//

import Foundation
import UIKit
final class TextFieldCell : UITableViewCell{
   
     let textField : UITextField = {
        let tf = CustomTextField()
        tf.backgroundColor = .white
        tf.textColor = .black
        tf.autocorrectionType = .no
        tf.font = UIFont.systemFont(ofSize: 20,weight: .medium)
        return tf
    }()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textField)
        textField.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 80)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(place:String){
        
    }
    
}

