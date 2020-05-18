//
//  ActionButton.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/18/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    init(type: ButtonAction) {
        super.init(frame: .zero)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        switch type {
        case .favorite:
            setImage(UIImage(systemName: "heart", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        case .next:
            setImage(UIImage(systemName: "shuffle", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
//        backgroundColor = .red
        imageView?.contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
