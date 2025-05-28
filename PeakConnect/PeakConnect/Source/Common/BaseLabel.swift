//
//  BaseLabel.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit

class BaseLabel: UILabel {
    
    private var padding = UIEdgeInsets(top: 4.0, left: 8.0, bottom: 4.0, right: 8.0)

    convenience init(padding: UIEdgeInsets) {
           self.init()
           self.padding = padding
       }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
         var contentSize = super.intrinsicContentSize
         contentSize.height += padding.top + padding.bottom
         contentSize.width += padding.left + padding.right

         return contentSize
     }
}
