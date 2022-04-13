//
//  Gradation.swift
//  Easy Count
//
//  Created by 前田航汰 on 2021/08/08.
//

import Foundation
import UIKit

class Gradation {
    func downGradient() -> CAGradientLayer {
        let topColor = UIColor(red: 0.2, green: 0.7, blue: 0.7, alpha: 1)
        let bottomColor = UIColor(red: 0.70, green: 1.0, blue: 1.0, alpha: 1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        return gradientLayer
    }

    func upGradient() -> CAGradientLayer {
        let topColor = UIColor(red: 1.0, green: 0.60, blue: 0.30, alpha: 1)
        let bottomColor = UIColor(red: 1.0, green: 1.0, blue: 0.80, alpha: 1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        return gradientLayer
    }
}
