//
//  EmptyState.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/31/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class EmptyState: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func configure() {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        addSubview(messageLabel)
        
        backgroundColor = .systemBackground
        
        imageView.image = UIImage(named: "love")
        
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
