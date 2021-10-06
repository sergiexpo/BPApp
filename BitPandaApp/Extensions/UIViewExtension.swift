//
//  UIViewExtension.swift
//  BitPandaApp
//
//  Created by Sergi Exposito on 1/10/21.
//

import UIKit

extension UIView{
    
    func showShadow(color: CGColor = UIColor.darkGray.cgColor,
                    offset: CGSize = CGSize.zero,
                    opacity: Float = 1,
                    background: UIColor = UIColor.init(named: "white_2") ?? UIColor.white){
        layer.shadowColor = color
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        backgroundColor = background
    }
    
}

