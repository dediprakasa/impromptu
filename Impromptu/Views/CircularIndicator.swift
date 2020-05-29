//
//  CircularIndicator.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/18/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class CircularIndicator: CAShapeLayer {
    
    init(color: UIColor) {
        super.init()
        name = "ci"
        lineWidth = 10
        switch color {
        case UIColor.myRed:
            fillColor = UIColor.myRed2.cgColor
        case UIColor.myBlue:
            fillColor = UIColor.myBlue2.cgColor
        default:
            fillColor = UIColor.myGreen2.cgColor
        }
        strokeColor = UIColor.white.cgColor
        isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(x: CGFloat, y: CGFloat, withDuration duration: TimeInterval = 0) {
        let arcCenter = CGPoint(x: x, y: y)
        let circularPath = UIBezierPath(arcCenter: arcCenter, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        path = circularPath.cgPath
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = false
        animation.duration = duration
        animation.toValue = true
        
        add(animation, forKey: "opacity")
    }
    
    func set(withColor color: CGColor) {
        fillColor = color
    }
    
    
}
