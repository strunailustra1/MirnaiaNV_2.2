//
//  ViewController.swift
//  MirnaiaNV_2.2
//
//  Created by Наталья Мирная on 15/11/2019.
//  Copyright © 2019 Наталья Мирная. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redValue: UILabel!
    @IBOutlet var greenValue: UILabel!
    @IBOutlet var blueValue: UILabel!
    
    @IBOutlet var redValueSlider: UISlider!
    @IBOutlet var greenValueSlider: UISlider!
    @IBOutlet var blueValueSlider: UISlider!
    
    @IBOutlet var redValueText: UITextField!
    @IBOutlet var greenValueText: UITextField!
    @IBOutlet var blueValueText: UITextField!
    
    @IBOutlet var colorOfView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorOfView.layer.cornerRadius = 20
        
        redLabel.text = "Red:"
        greenLabel.text = "Green:"
        blueLabel.text = "Blue:"
        
        redValueSlider.value = 0.25
        redValueSlider.minimumValue = 0.0
        redValueSlider.maximumValue = 1.0

        greenValueSlider.value = 0.5
        greenValueSlider.minimumValue = 0.0
        greenValueSlider.maximumValue = 1.0

        blueValueSlider.value = 0.75
        blueValueSlider.minimumValue = 0.0
        blueValueSlider.maximumValue = 1.0

        redValueSlider.tintColor = .red
        greenValueSlider.tintColor = .green
        blueValueSlider.tintColor = .blue
        
        redValue.text = String(redValueSlider.value)
        greenValue.text = String(greenValueSlider.value)
        blueValue.text = String(blueValueSlider.value)
        
        redValueText.text = String(redValueSlider.value)
        greenValueText.text = String(greenValueSlider.value)
        blueValueText.text = String(blueValueSlider.value)
        
        redValueText.delegate = self
        greenValueText.delegate = self
        blueValueText.delegate = self
        
        changeViewColor()
    }

    @IBAction func redSliderChange() {
        let roundRedValue = String((100 * redValueSlider.value).rounded() / 100)
        redValue.text = roundRedValue
        redValueText.text = roundRedValue
        changeViewColor()
    }
    
    @IBAction func greenSliderChange() {
        let roundGreenValue = String((100 * greenValueSlider.value).rounded() / 100)
        greenValue.text = roundGreenValue
        greenValueText.text = roundGreenValue
        changeViewColor()
    }
    
    @IBAction func blueSliderChange() {
        let roundBlueValue =  String((100 * blueValueSlider.value).rounded() / 100)
        blueValue.text = roundBlueValue
        blueValueText.text = roundBlueValue
        changeViewColor()
    }
    
    private func changeViewColor () {
        let color = UIColor.init(
            red: CGFloat(redValueSlider.value),
            green: CGFloat(greenValueSlider.value),
            blue: CGFloat(blueValueSlider.value),
            alpha: CGFloat(1.0)
        )
        colorOfView.backgroundColor = color
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = [".", "0", "1", "2", "3", "4", "5", "6", "7",
                                 "8", "9", ""]
        return allowedCharacters.contains(string)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard var textValue = textField.text, !textValue.isEmpty else {
            return false
        }
        
        guard var textValueFloat = Float(textValue) else {
            return false
        }
        
        textValueFloat = (100 * textValueFloat).rounded() / 100
        
        textValueFloat = textValueFloat > 1.0 ? 1.0 : textValueFloat
        textValueFloat = textValueFloat < 0.0 ? 0.0 : textValueFloat
        
        textValue = String(textValueFloat)
        
        switch textField {
        case redValueText:
            redValueSlider.value = textValueFloat
            redValue.text = textValue
            redValueText.text = textValue
        case greenValueText:
            greenValueSlider.value = textValueFloat
            greenValue.text = textValue
            greenValueText.text = textValue
        case blueValueText:
            blueValueSlider.value = textValueFloat
            blueValue.text = textValue
            blueValueText.text = textValue
        default:
            break
        }
        
        changeViewColor()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}

extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
