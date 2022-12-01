//
//  SecondViewController.swift
//  UILabel 12
//
//  Created by Aleksey Kosov on 30.11.2022.
//

import UIKit

class SecondViewController: UIViewController {
    private var shadowSwitch = UISwitch()
    private var shadowLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 100, y: 120, width: 100, height: 50)
        label.text = "Shadow"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.82, green: 0.85, blue: 0.89, alpha: 1.00)
        shadowSwitch.frame = CGRect(x: 30, y: 130, width: 100, height: 50)
        view.addSubview(shadowSwitch)
        view.addSubview(shadowLabel)
        shadowSwitch.addTarget(self, action: #selector(shadowOn), for: .valueChanged)
    }
    
    @objc func shadowOn(sender: UISwitch) {
        if sender.isOn {
            ViewController.exampleLabel.shadowColor = .black
            ViewController.exampleLabel.shadowOffset = CGSize(width: 2, height: 2)
        } else {
            ViewController.exampleLabel.shadowColor = nil
        }
        
    }
}
