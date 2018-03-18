//
//  Extension_UIView.swift
//  CustomKeyboard
//
//  Created by Ha Nguyen on 3/18/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchorWithConstraints(topAnchor: NSLayoutYAxisAnchor? = nil,
                               topConstant: CGFloat = 0,
                               leftAnchor: NSLayoutXAxisAnchor? = nil,
                               leftConstant: CGFloat = 0,
                               bottomAnchor: NSLayoutYAxisAnchor? = nil,
                               bottomConstant: CGFloat = 0,
                               rightAnchor: NSLayoutXAxisAnchor? = nil,
                               rightConstant: CGFloat = 0,
                               centerXAnchor: NSLayoutXAxisAnchor? = nil,
                               centerXConstant: CGFloat = 0,
                               centerYAnchor: NSLayoutYAxisAnchor? = nil,
                               centerYConstant: CGFloat = 0,
                               widthConstant: CGFloat? = nil,
                               heightConstant: CGFloat? = nil) {
        
        var constraints = [NSLayoutConstraint]()
        
        if let topAnchor = topAnchor {
            let topConstraint = self.topAnchor.constraint(equalTo: topAnchor, constant: topConstant)
            constraints.append(topConstraint)
        }
        
        if let leftAnchor = leftAnchor {
            let leftConstraint = self.leftAnchor.constraint(equalTo: leftAnchor, constant: leftConstant)
            constraints.append(leftConstraint)
        }
        
        if let bottomAnchor = bottomAnchor {
            let bottomConstraint = self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomConstant)
            constraints.append(bottomConstraint)
        }
        
        if let rightAnchor = rightAnchor {
            let rightConstraint = self.rightAnchor.constraint(equalTo: rightAnchor, constant: -rightConstant)
            constraints.append(rightConstraint)
        }
        
        if let centerXAnchor = centerXAnchor {
            let centerXConstraint = self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerXConstant)
            constraints.append(centerXConstraint)
        }
        
        if let centerYAnchor = centerYAnchor {
            let centerYConstraint = self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerYConstant)
            constraints.append(centerYConstraint)
        }
        
        if let widthConstant = widthConstant {
            let widthConstraint = self.widthAnchor.constraint(equalToConstant: widthConstant)
            constraints.append(widthConstraint)
        }
        
        if let heightConstant = heightConstant {
            let heightConstraint = self.heightAnchor.constraint(equalToConstant: heightConstant)
            constraints.append(heightConstraint)
        }
        
        if constraints.count > 0 {
            self.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(constraints)
        }
    }
    
}
