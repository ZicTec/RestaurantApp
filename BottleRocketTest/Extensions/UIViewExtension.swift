//
//  UIViewExtension.swift
//  BottleRocketTest
//
//  Created by Eze Emenike on 4/14/21.
//

import UIKit

extension UIView {
    
    func boundToSuperView(insetLead: CGFloat, insetTop: CGFloat, insetTrail: CGFloat, insetBottom: CGFloat) {
        guard let superViewLayout = self.superview?.safeAreaLayoutGuide else { return }
        self.topAnchor.constraint(equalTo: superViewLayout.topAnchor, constant: insetTop).isActive = true
        self.leadingAnchor.constraint(equalTo: superViewLayout.leadingAnchor, constant: insetLead).isActive = true
        self.trailingAnchor.constraint(equalTo: superViewLayout.trailingAnchor, constant: -insetTrail).isActive = true
        self.bottomAnchor.constraint(equalTo: superViewLayout.bottomAnchor, constant: -insetBottom).isActive = true
    }
    
}
