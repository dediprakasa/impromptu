//
//  HomeVC.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/14/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    let btn = UIButton()
    var questionLabel: QuestionLabel!
    let timerPicker = TimerPickerView()
    let playButton = PlayButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = MyColor.blue
        navigationController?.isNavigationBarHidden = true
        questionLabel = QuestionLabel(text: Question.questions[0])

        view.addSubview(questionLabel)
        view.addSubview(timerPicker)
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            timerPicker.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 200),
            timerPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerPicker.widthAnchor.constraint(equalToConstant: 150),
            timerPicker.heightAnchor.constraint(equalToConstant: 150),
            
            playButton.topAnchor.constraint(equalTo: timerPicker.bottomAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 100)
            
        ])
        
    }
    
    @objc func btnTapped() {
        print("ya")
        let dest = FavoritesTableVC()
        
        navigationController?.pushViewController(dest, animated: true)
    }
    
    


}
