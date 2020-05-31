//
//  HomeVC.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/14/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

enum TestError: Error {
    case joss
}

protocol HomeVCDelegate: class {
    func colorGetter(color: UIColor)
}

class HomeVC: UIViewController {
    
    let btn = UIButton()
    var questionLabel: QuestionLabel!
    let timerPicker = TimerPickerView()
    let playButton = PlayButton()
    var favoriteButton = ActionButton(type: .favorite)
    let shuffleButton = ActionButton(type: .next)
    let listButton = ActionButton(type: .list)
    let buttonStack = UIStackView()
    var timer = Timer()
    var counter = 0 {
        didSet {
            print("haaah")
        }
    }
    var topQuestionLabelConstraint = NSLayoutConstraint()
    var countdownLabel = CountdownLabel()
    var isTimerRunning = false
    var circularIndicator = CircularIndicator(color: UIColor.myRed2)
    var mainColor = UIColor.myRed
    var elapsedTime = 0
    var isPaused = false
    var startCounter = 0
    var questionIndex: Int! {
        didSet {
            print("-=-=-=-=")
        }
    }
    weak var delegate: HomeVCDelegate!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        configureFavoriteButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionIndex = Int.random(in: 0..<Question.questions.count)
        print("----")
        configureButtonStack()
        configureButtons()
        configureFavoriteButton()
        configure()
    }
    
    func configureCountdownLabel() {
    
    }
    
    func configureFavoriteButton() {
        if PersistenceManager.getFavorites().contains(questionIndex) {
            favoriteButton.setLovedButton(type: .favorited)
        } else {
            favoriteButton.setLovedButton(type: .favorite)
        }
    }
    
    func configureCircularIndicator(withDuration duration: TimeInterval = 0, color: UIColor) {
        circularIndicator = CircularIndicator(color: color)
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
        listButton.addTarget(self, action: #selector(listButtonTapped), for: .touchUpInside)
        playButton.setIcon(type: .play, withColor: mainColor)
        playButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        shuffleButton.addTarget(self, action: #selector(shuffleButtonTapped), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    func configure() {
        
        view.backgroundColor = mainColor
        navigationController?.isNavigationBarHidden = true
        questionLabel = QuestionLabel(text: Question.questions[questionIndex])
        
        view.addSubview(listButton)
        view.addSubview(countdownLabel)
        view.addSubview(questionLabel)
        view.addSubview(timerPicker)
        view.addSubview(buttonStack)
        
        topQuestionLabelConstraint =  questionLabel.topAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.topAnchor, constant: 200)
        
        NSLayoutConstraint.activate([
            listButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            listButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
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
    
    @objc func favoriteButtonTapped() {
        var action: PersistenceActionType
        var message: String
        var buttonType: ButtonAction
        
        if PersistenceManager.getFavorites().contains(questionIndex) {
            action = .remove
            message = "Successfully removed from favorites"
            buttonType = .favorite
        } else {
            action = .add
            message = "Successfully added to favorites"
            buttonType = .favorited
        }
        PersistenceManager.update(favoriteIndex: questionIndex, type: action) { _ in
            self.favoriteButton.setLovedButton(type: buttonType)
            let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        
    }
    
    @objc func listButtonTapped() {
        let targetVC = FavoritesTableVC(color: mainColor)
//        delegate = targetVC
//        delegate.colorGetter(color: mainColor)
        let navController   = UINavigationController(rootViewController: targetVC)
//        self.present(navController, animated: true)
        navigationController?.pushViewController(targetVC, animated: true)
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
            configureCircularIndicator(withDuration: duration, color: self.mainColor)
//            circularIndicator.set(withColor: self.mainColor.cgColor)
            UIView.animate(withDuration: duration) {
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
            setToIdle()
        } else {
            counter -= 1
            self.countdownLabel.setTimer(time: counter)
            
        }
    }
    
    func setToIdle() {
        isPaused = false
        let duration = TimeInterval(0.3)
        topQuestionLabelConstraint.constant = 200
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
            self.playButton.setIcon(type: .play, withColor: self.mainColor)
            self.questionLabel.font = UIFont.boldSystemFont(ofSize: 36)
            self.questionLabel.textAlignment = .left
            self.timerPicker.alpha = 1
            self.countdownLabel.resetTimer(withDuration: duration)
            self.view.layer.sublayers?.forEach {
                if $0.name == "ci" { $0.removeFromSuperlayer() }
            }
            self.shuffleButton.alpha = 1
        }
    }
    
    @objc func shuffleButtonTapped() {
        questionIndex = Int.random(in: 0..<Question.questions.count)
        configureFavoriteButton()
        let question = Question.questions[questionIndex]
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



