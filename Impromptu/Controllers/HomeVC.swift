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
    let favoriteButton = ActionButton(type: .favorite)
    let shuffleButton = ActionButton(type: .next)
    let buttonStack = UIStackView()
    var timer = Timer()
    var counter = 0
    var topQuestionLabelConstraint = NSLayoutConstraint()
    var countdownLabel = CountdownLabel()
    var isTimerRunning = false
    var circularIndicator = CircularIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonStack()
        configureButtons()
        configureCircularIndicator()
        configure()
    }
    
    func configureCountdownLabel() {
    
    }
    
    func configureCircularIndicator() {
        print(view.frame.size.height / 2 - 150, "<<")
        circularIndicator.configure(x: view.frame.size.width / 2, y: view.frame.size.height / 2 - 150)
    }
    
    func configureButtonStack() {
        buttonStack.addArrangedSubview(favoriteButton)
        buttonStack.addArrangedSubview(playButton)
        buttonStack.addArrangedSubview(shuffleButton)
        buttonStack.distribution = .equalCentering
        buttonStack.axis = .horizontal
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureButtons() {
        playButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
    }
    
    func configure() {
        view.backgroundColor = MyColor.blue
        navigationController?.isNavigationBarHidden = true
        questionLabel = QuestionLabel(text: Question.questions[0])

        view.layer.addSublayer(circularIndicator)
        view.addSubview(countdownLabel)
        view.addSubview(questionLabel)
        view.addSubview(timerPicker)
        view.addSubview(buttonStack)
        
        topQuestionLabelConstraint =  questionLabel.topAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.topAnchor, constant: 200)
        
        NSLayoutConstraint.activate([
            countdownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            countdownLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            topQuestionLabelConstraint,
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            timerPicker.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -10),
            timerPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerPicker.widthAnchor.constraint(equalToConstant: 150),
            timerPicker.heightAnchor.constraint(equalToConstant: 150),
            
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonStack.widthAnchor.constraint(equalToConstant: 250),
            buttonStack.heightAnchor.constraint(equalToConstant: 100)
            
        ])
        
    }
    
    @objc func btnTapped() {
        let minute = timerPicker.selectedRow(inComponent: 0)
        let second = timerPicker.selectedRow(inComponent: 1)
        counter = minute * 60 + second

        topQuestionLabelConstraint.constant = 400
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.questionLabel.font = UIFont.boldSystemFont(ofSize: 24)
            self.questionLabel.textAlignment = .center
            self.timerPicker.alpha = 0
            self.circularIndicator.isHidden = false
            self.countdownLabel.setTimer(time: self.counter)
            if !self.isTimerRunning {
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startCountdown), userInfo: nil, repeats: true)
                self.isTimerRunning = true
            }
        }
        
        
        
    
    }
    
    @objc func startCountdown() {
        print(counter)
        
        if counter <= 0 {
            timer.invalidate()
            isTimerRunning = false
        } else {
            counter -= 1
            self.countdownLabel.setTimer(time: counter)
        }
        
        
    }
    
    


}
