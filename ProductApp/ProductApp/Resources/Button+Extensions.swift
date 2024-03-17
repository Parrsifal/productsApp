//
//  Button+Extensions.swift
//  ProductApp
//
//  Created by Dmitrii Sorochin on 16.03.2024.
//

import Foundation
import UIKit

extension UIButton {
    static func roundButton(size: CGSize, image: UIImage) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .Constants.appBackgoundColor
        button.layer.cornerRadius = min(size.width, size.height) / 2
        
        button.setImage(image, for: .normal)
        button.tintColor = .black
    
        
        button.imageView?.contentMode = .scaleAspectFit
        
        button.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        button.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        button.layer.masksToBounds = false
        
        return button
    }
}
