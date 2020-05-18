//
//  CircularIndicator.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/18/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class CircularIndicator: CAShapeLayer {
    
    override init() {
        super.init()
        
        lineWidth = 10
        fillColor = MyColor.blue2.cgColor
        strokeColor = UIColor.white.cgColor
        isHidden = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(x: CGFloat, y: CGFloat) {
        let arcCenter = CGPoint(x: x, y: y)
        let circularPath = UIBezierPath(arcCenter: arcCenter, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        path = circularPath.cgPath
    }
}
