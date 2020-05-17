//
//  TimerPickerView.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/17/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class TimerPickerView: UIPickerView {
    
    var data: [Int] = {
        var arr = [Int]()
        for num in 0...59 {
            arr.append(num)
        }
        
        return arr
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor =÷ .red
        configure()
    }
    
    func configure() {
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    

}

extension TimerPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(data[row])
//    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let label = UILabel()
        label.text = data[row] < 10 ? "0" + String(data[row]) : String(data[row])
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviews.forEach {
            let x = $0.frame.minX
            var y = $0.frame.minY
            
            let width = $0.frame.width
            let height = CGFloat(5)
            if y < self.frame.height / 2 {
                y -= height
            }
            if ($0.frame.height <= 1.0) {
                $0.frame = CGRect(x: x, y: y, width: width, height: height)
                $0.backgroundColor = .white
            }
            
        }

    }

}
