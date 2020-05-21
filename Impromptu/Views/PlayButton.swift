//
//  PlayButton.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/17/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

enum MainButtonType {
    case play, pause
}

class PlayButton: UIButton {
    

    init() {
        super.init(frame: .zero)
        setTitle(nil, for: .normal)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        imageView?.contentMode = .scaleAspectFit
        
    }
    
    override var bounds : CGRect {
      didSet {
        layer.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        print(bounds)
        layer.cornerRadius = bounds.height / 2
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
      }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setIcon(type: MainButtonType, withColor color: UIColor) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 60, weight: .bold, scale: .large)
        switch type {
        case .play:
            setImage(UIImage(systemName: "play", withConfiguration: largeConfig)?.withTintColor(color, renderingMode: .alwaysOriginal), for: .normal)
        case .pause:
            setImage(UIImage(systemName: "pause", withConfiguration: largeConfig)?.withTintColor(color, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
}
