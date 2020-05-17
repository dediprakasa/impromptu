//
//  QuestionLabel.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/17/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class QuestionLabel: UILabel {

    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        configure()
    }
    
    func configure() {
        textColor = .white
        font = UIFont.boldSystemFont(ofSize: 36)
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
