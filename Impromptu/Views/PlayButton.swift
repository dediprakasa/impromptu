//
//  PlayButton.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/17/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class PlayButton: UIButton {
    

    init() {
        super.init(frame: .zero)
        setTitle(nil, for: .normal)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 80, weight: .bold, scale: .large)
        setImage(UIImage(systemName: "timer", withConfiguration: largeConfig)?.withTintColor(MyColor.blue, renderingMode: .alwaysOriginal), for: .normal)
        imageView?.contentMode = .scaleAspectFill
        
    }
    
    override var bounds : CGRect {
      didSet {
        layer.cornerRadius = bounds.width / 2
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
      }
    }
    
//    override func backgroundImage(for state: UIControl.State) -> UIImage? {
//        if
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
