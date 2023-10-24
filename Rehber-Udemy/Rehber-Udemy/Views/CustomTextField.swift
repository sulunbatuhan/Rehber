//
//  CustomTextField.swift
//  Rehber-Udemy
//
//  Created by batuhan on 6.08.2023.
//

import Foundation
import UIKit

final class CustomTextField : UITextField {
    override var intrinsicContentSize: CGSize{
        return .init(width: 0, height: 50)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        borderStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
