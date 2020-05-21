//
//  UIColor+Extension.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/19/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

extension UIColor {
    static let myBlue = UIColor(red: 112/255, green: 195/255, blue: 242/255, alpha: 1)
    static let myBlue2 = UIColor(red: 43/255, green: 175/255, blue: 242/255, alpha: 1)
    static let myGreen = UIColor(red: 69/255, green: 220/255, blue: 147/255, alpha: 1)
    static let myGreen2 = UIColor(red: 56/255, green: 180/255, blue: 120/255, alpha: 1)
    static let myRed = UIColor(red: 246/255, green: 99/255, blue: 99/255, alpha: 1)
    static let myRed2 = UIColor(red: 203/255, green: 81/255, blue: 81/255, alpha: 1)
    
    static func getNextColor(currentColor: UIColor) -> [UIColor] {
        let arrColor: [[UIColor]] = [[.myRed, .myRed2], [.myGreen, .myGreen2], [.myBlue, .myBlue2]]
        var index = 0
        for i in 0..<arrColor.count {
            if arrColor[i][0] == currentColor {
                index = i
            }
        }
        if index == arrColor.count - 1 {
            index = 0
        } else {
            index += 1
        }
     
        return arrColor[index]
    }
    
}
