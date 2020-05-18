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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTimer(time: Int) {
        let minute = floor(Double(time) / 60)
        let second = time % 60
        let minToDisplay = minute < 10 ? "0\(Int(minute))" : "\(Int(minute))"
        let secToDisplay = second < 10 ? "0\(second)" : "\(second)"
        text = "\(minToDisplay) : \(secToDisplay)"
    }
    
}

