//
//  MainViewController.swift
//  MirnaiaNV_2.2
//
//  Created by Наталья Мирная on 03/12/2019.
//  Copyright © 2019 Наталья Мирная. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SettingsViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController
        settingsVC.mainVCBackgroundColor = view.backgroundColor
        settingsVC.delegate = self
        
    }
    
    func applyColorSettings(_ color: UIColor) {
        view.backgroundColor = color
    }
}
