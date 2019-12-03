//
//  ViewController.swift
//  MirnaiaNV_2.2
//
//  Created by Наталья Мирная on 15/11/2019.
//  Copyright © 2019 Наталья Мирная. All rights reserved.
//

import UIKit

protocol ColorSettingsProtocol {
    var colorSettings: UIColor { get }
}

protocol SettingsViewControllerDelegate {
    func applyColorSettings(_ color: UIColor)
}

class SettingsViewController: UIViewController, UITextFieldDelegate, ColorSettingsProtocol {
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
    
    var mainVCBackgroundColor: UIColor!
    
    var colorSettings: UIColor {
        UIColor(
            red: CGFloat(redValueSlider.value),
            green: CGFloat(greenValueSlider.value),
            blue: CGFloat(blueValueSlider.value),
            alpha: CGFloat(1.0)
        )
    }
    
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorOfView.layer.cornerRadius = 20

        setInitialColor()
        setInitialText()
        changeViewColor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func sliderChange(_ sender: UISlider) {
        let roundSliderValue = String((100 * sender.value).rounded() / 100)
        switch sender {
        case redValueSlider:
            redValue.text = roundSliderValue
            redValueText.text = roundSliderValue
        case greenValueSlider:
            greenValue.text = roundSliderValue
            greenValueText.text = roundSliderValue
        case blueValueSlider:
            blueValue.text = roundSliderValue
            blueValueText.text = roundSliderValue
        default:
            break
        }
        
        changeViewColor()
    }
    
    @IBAction func donePressed() {
        delegate.applyColorSettings(colorSettings)
        dismiss(animated: true)
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

    private func setInitialColor() {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        mainVCBackgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redValueSlider.value = roundCGFloat(red)
        greenValueSlider.value = roundCGFloat(green)
        blueValueSlider.value = roundCGFloat(blue)
    }
    
    private func roundCGFloat(_ value: CGFloat) -> Float {
         Float((100 * value).rounded() / 100)
    }
    
    private func setInitialText () {
        redValue.text = String(redValueSlider.value)
        greenValue.text = String(greenValueSlider.value)
        blueValue.text = String(blueValueSlider.value)
        
        redValueText.text = String(redValueSlider.value)
        greenValueText.text = String(greenValueSlider.value)
        blueValueText.text = String(blueValueSlider.value)
    }
    
    private func changeViewColor () {
        colorOfView.backgroundColor = colorSettings
    }
}

// https://medium.com/swift2go/swift-add-keyboard-done-button-using-uitoolbar-c2bea50a12c7
extension UITextField{
    // устанавливаем данный переключатель на сториборде для каждого текстового поля
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
