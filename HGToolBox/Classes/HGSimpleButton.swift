//
//  HGSimpleButton.swift
//  Pods
//
//  Created by Alexander Ortiz on 16/08/17.
//
//

import UIKit

@IBDesignable
class HGSimpleButton: UIButton {

    @IBInspectable
    var cornerRadius:CGFloat = 0.0{
        didSet{
            if self.cornerRadius < 0{
                self.cornerRadius = 0
            }
            self.layer.cornerRadius = self.cornerRadius
        }
    }
   
    @IBInspectable
    var borderWidth:CGFloat = 0.0{
        didSet{
            if self.borderWidth < 0{
                self.borderWidth = 0
            }
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable
    var borderColor:UIColor = .clear{
        didSet{
            self.layer.borderColor = self.borderColor.cgColor
        }
    }

}
