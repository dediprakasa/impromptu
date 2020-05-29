//
//  ActionButton.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/18/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    var type: ButtonAction!
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
    
    init(type: ButtonAction) {
        super.init(frame: .zero)
        self.type = type
        
        setImage(UIImage(systemName: type.rawValue, withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
//        backgroundColor = .red
        imageView?.contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLovedButton(type: ButtonAction) {
        if type == .favorite || type == .favorited {
            setImage(UIImage(systemName: type.rawValue, withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    

}
