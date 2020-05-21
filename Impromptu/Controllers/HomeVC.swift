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
    var circularIndicator = CircularIndicator(color: UIColor.myRed2)
    var mainColor = UIColor.myRed
    var elapsedTime = 0
    var isPaused = false
    var startCounter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonStack()
        configureButtons()
        configure()
    }
    
    func configureCountdownLabel() {
    
    }
    
    func configureCircularIndicator(withDuration duration: TimeInterval = 0) {
        circularIndicator.configure(x: view.frame.size.width / 2, y: view.frame.size.height / 2 - 150, withDuration: duration)
        view.layer.addSublayer(circularIndicator)
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
        playButton.setIcon(type: .play, withColor: mainColor)
        playButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        shuffleButton.addTarget(self, action: #selector(shuffleButtonTapped), for: .touchUpInside)
    }
    
    func configure() {
        view.backgroundColor = mainColor
        navigationController?.isNavigationBarHidden = true
        questionLabel = QuestionLabel(text: Question.questions[0])
        
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
            questionLabel.heightAnchor.constraint(equalToConstant: 250),
            
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
        isTimerRunning = !isTimerRunning
        let duration = TimeInterval(0.3)
        if isTimerRunning {
            playButton.setIcon(type: .pause, withColor: mainColor)
            if isPaused {
                counter = startCounter - Int(elapsedTime)
            } else {
                let minute = timerPicker.selectedRow(inComponent: 0)
                let second = timerPicker.selectedRow(inComponent: 1)
                startCounter = minute * 60 + second
                counter = startCounter
            }
            topQuestionLabelConstraint.constant = 400
            configureCircularIndicator(withDuration: duration)
            UIView.animate(withDuration: duration) {
                print("00-")
                self.view.layoutIfNeeded()
                self.view.bringSubviewToFront(self.countdownLabel)
                self.questionLabel.font = UIFont.boldSystemFont(ofSize: 24)
                self.questionLabel.textAlignment = .center
                self.timerPicker.alpha = 0
                self.shuffleButton.alpha = 0
                self.countdownLabel.setTimer(time: self.counter, withDuration: duration)
            }
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startCountdown), userInfo: nil, repeats: true)
        } else {
            playButton.setIcon(type: .play, withColor: mainColor)
            UIView.animate(withDuration: 0.3) {
                self.shuffleButton.alpha = 1
            }
            timer.invalidate()
            elapsedTime = startCounter - counter
            isPaused = true
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
    
    @objc func shuffleButtonTapped() {
        let qNum = Int.random(in: 0..<Question.questions.count)
        let question = Question.questions[qNum]
        let arrNewColor = UIColor.getNextColor(currentColor: self.view.backgroundColor!)
        mainColor = arrNewColor[0]
        questionLabel.setText(text: question)
        topQuestionLabelConstraint.constant = 200
        let duration = TimeInterval(0.3)
        if isPaused {
            isPaused = false
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                self.view.backgroundColor = arrNewColor[0]
                self.playButton.setIcon(type: .play, withColor: self.mainColor)
                self.questionLabel.font = UIFont.boldSystemFont(ofSize: 36)
                self.questionLabel.textAlignment = .left
                self.timerPicker.alpha = 1
                self.countdownLabel.resetTimer(withDuration: duration)
                self.view.layer.sublayers?.forEach {
                    if $0.name == "ci" { $0.removeFromSuperlayer() }
                }
            }
        } else {
            UIView.animate(withDuration: duration) {
                self.view.backgroundColor = self.mainColor
                self.playButton.setIcon(type: .play, withColor: self.mainColor)
            }
        }
        
    }
    


}
