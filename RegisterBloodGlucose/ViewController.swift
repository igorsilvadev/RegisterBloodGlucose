//
//  ViewController.swift
//  RegisterBloodGlucose
//
//  Created by Igor Samoel da Silva on 08/10/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    lazy var inputGlucoseLevel: UITextField = {
        let input = UITextField(frame: view.frame)
        input.keyboardType = .numberPad
        input.placeholder = "Enter your blood glucose level"
        input.delegate = self
        return input
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(frame: view.frame)
        button.configuration = .plain()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(saveBloodGlucoseLevel(_:)), for: .touchUpInside)
        return button
    }()
    
    
    
    lazy var bloodGlucoseLevel: UITextView = {
        let outputText = UITextView()
        outputText.contentInsetAdjustmentBehavior = .automatic
        outputText.textAlignment = NSTextAlignment.center
        outputText.font = .systemFont(ofSize: 50)
        outputText.text = ""
        outputText.textColor = .black
        return outputText
    }()
    
    
    
    override func viewDidLoad() {
        view.addSubview(inputGlucoseLevel)
        view.addSubview(saveButton)
        view.addSubview(bloodGlucoseLevel)
        setupConstraints()
        super.viewDidLoad()
    }
    
    
    
    
    @objc func saveBloodGlucoseLevel(_ sender: UIButton!){
        if let result = self.inputGlucoseLevel.text {
            bloodGlucoseLevel.text = result
        }
    }
    
    
    private func setupConstraints(){
        self.inputGlucoseLevel.translatesAutoresizingMaskIntoConstraints = false
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.bloodGlucoseLevel.translatesAutoresizingMaskIntoConstraints = false
        
        let contraints = [
            //Input Glucose Level
            self.inputGlucoseLevel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.inputGlucoseLevel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            //Save Button
            self.saveButton.centerXAnchor.constraint(equalTo: self.inputGlucoseLevel.centerXAnchor),
            self.saveButton.centerYAnchor.constraint(equalTo: self.inputGlucoseLevel.centerYAnchor, constant: 50),
            
            //Blood Glucose Result View
            self.bloodGlucoseLevel.centerXAnchor.constraint(equalTo: self.inputGlucoseLevel.centerXAnchor),
            self.bloodGlucoseLevel.centerYAnchor.constraint(equalTo: self.inputGlucoseLevel.centerYAnchor, constant: -150),
            self.bloodGlucoseLevel.widthAnchor.constraint(equalTo: self.inputGlucoseLevel.widthAnchor, constant: 50),
            self.bloodGlucoseLevel.heightAnchor.constraint(equalTo: self.inputGlucoseLevel.heightAnchor, constant: 50)
            
        ]
        NSLayoutConstraint.activate(contraints)
    }
}

