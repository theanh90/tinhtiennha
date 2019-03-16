//
//  UIColor+Extension.swift
//  TinhTienNha
//
//  Created by AnhBui on 3/12/19.
//  Copyright © 2019 AnhBui. All rights reserved.
//

import UIKit

class Common {
    public static func makeGradient(forView: UIView, startColor: UIColor, endColor: UIColor) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: forView.frame.size.width, height: forView.frame.size.height)
        
        return gradient
    }
}
