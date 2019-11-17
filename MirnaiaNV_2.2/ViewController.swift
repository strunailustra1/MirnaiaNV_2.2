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
        
        print(blueValueSlider.value)
        
    }
    
    private func changeViewColor () {
        let color = UIColor.init(red: CGFloat(redValueSlider.value), green: CGFloat(greenValueSlider.value), blue: CGFloat(blueValueSlider.value), alpha: CGFloat(1.0))
        colorOfView.backgroundColor = color
    }
    

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        print(textField.text!)
        
        guard let textValue = textField.text, !textValue.isEmpty else {
            return false
        }
        
        guard let textValueFloat = Float(textValue) else {
            return false
        }
        
        switch textField {
        case redValueText:
            redValueSlider.value = textValueFloat
            redValue.text = textValue
        case greenValueText:
            greenValueSlider.value = textValueFloat
            greenValue.text = textValue
        case blueValueText:
            blueValueSlider.value = textValueFloat
            blueValue.text = textValue
        default:
            break
        }
        
        changeViewColor()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        print(textField.text!)
        
        textField.resignFirstResponder()
        
        return true
    }
}

