//
//  FavoriteCell.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/29/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

protocol FavoriteCellDelegate: class {
    func deleteFavorite(questionIndex: Int)
}

class FavoriteCell: UITableViewCell {
    
    static let reuseID = "favorites"
    let label = UILabel()
    let container = UIView()
    let deleteButton = ActionButton(type: .delete)
    var questionIndex: Int?
    var delegate: FavoriteCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func configure() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 15
        
        
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        container.addSubview(label)
        container.addSubview(deleteButton)
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            
            deleteButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            deleteButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)
        ])
        
    }
    
    func set(text: String, color: UIColor, questionIndex: Int) {
        label.text = text
        container.backgroundColor = color
        self.questionIndex = questionIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func deleteButtonTapped() {
        delegate?.deleteFavorite(questionIndex: questionIndex!)
    }
    
}
