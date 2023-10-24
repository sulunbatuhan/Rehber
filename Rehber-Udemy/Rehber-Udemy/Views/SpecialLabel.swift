//
//  SpecialLabel.swift
//  Rehber-Udemy
//
//  Created by batuhan on 4.09.2023.
//

import Foundation
import UIKit

final class SpecialLabel : UILabel {
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 0, height: 50)
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 16, dy: 0))
    }
}
