//
//  CountdownLabel.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/18/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class CountdownLabel: UILabel {

    init() {
        super.init(frame: .zero)
        textColor = .white
        font = UIFont.boldSystemFont(ofSize: 40)
        translatesAutoresizingMaskIntoConstraints = false
        alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTimer(time: Int, withDuration duration: TimeInterval = 0) {
        let minute = floor(Double(time) / 60)
        let second = time % 60
        let minToDisplay = minute < 10 ? "0\(Int(minute))" : "\(Int(minute))"
        let secToDisplay = second < 10 ? "0\(second)" : "\(second)"
        self.text = "\(minToDisplay) : \(secToDisplay)"

        UIView.animate(withDuration: duration) {
            self.alpha = 1
        }
    }
    
    func resetTimer(withDuration duration: TimeInterval = 0) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0
        }
    }
    
}

