//
//  ViewController.swift
//  UILabel 12
//
//  Created by Aleksey Kosov on 30.11.2022.
//

import UIKit

class ViewController: UIViewController {
    static var exampleLabel = UILabel()
    private var colorPicker = UIPickerView()
    private var linesPicker = UIPickerView()
    private var fontPicker = UIPickerView()
    private var fontSizeSlider = UISlider()
    
    
    private let linesArray = [0,1,2,3,4,5,6]
    private let colorDictionary: [String:UIColor] = ["black": .black,"red": .red, "blue": .blue, "grey": .gray, "green": .green]
    private let fontTypes = ["Georgia", "GeezaPro", "Galvji", "Futura-Medium", "Farah"]
//    private let fontTypes: [UIFont] = [.]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.82, green: 0.85, blue: 0.89, alpha: 1.00)

        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton)), animated: true)
        //Font Picker
        fontPicker.frame = CGRect(x: 35, y: 500, width: 150, height: 100)
        fontPicker.delegate = self
        fontPicker.dataSource = self
        view.addSubview(fontPicker)
        
        fontSizeSlider.frame = CGRect(x: 35, y: 350, width: 300, height: 50)
        fontSizeSlider.minimumValue = 10
        fontSizeSlider.maximumValue = 60
        fontSizeSlider.minimumValueImage = UIImage(systemName: "minus")
        fontSizeSlider.maximumValueImage = UIImage(systemName: "plus")
        fontSizeSlider.addTarget(self, action: #selector(updateFont), for: .valueChanged)
        view.addSubview(fontSizeSlider)
        //Color Picker
        colorPicker.frame = CGRect(x: 35, y: 400, width: 150, height: 100)
        view.addSubview(colorPicker)
        colorPicker.delegate = self
        colorPicker.dataSource = self
        //Lines Picker
        linesPicker.frame = CGRect(x: 210, y: 400, width: 150, height: 100)
        view.addSubview(linesPicker)
        linesPicker.delegate = self
        linesPicker.dataSource = self
        
        //Label
        ViewController.exampleLabel.text = "Example"
        ViewController.exampleLabel.numberOfLines = 0
        ViewController.exampleLabel.lineBreakMode = .byWordWrapping
        ViewController.exampleLabel.textAlignment = .center
        ViewController.exampleLabel.sizeToFit()
        ViewController.exampleLabel.adjustsFontSizeToFitWidth = true
        ViewController.exampleLabel.frame = CGRect(x: 50, y: 100, width: 300, height: 250)
        view.addSubview(ViewController.exampleLabel)
    }
    @objc func addButton() {
        let ac = UIAlertController(title: "Enter data", message: "", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
            let textField = ac.textFields![0]
            ViewController.exampleLabel.text = textField.text
            ac.addAction(alert)
        }))
        present(ac, animated: true)
    }
    @objc func updateFont(sender: UISlider) {
        ViewController.exampleLabel.font = .systemFont(ofSize: CGFloat(sender.value))
    }
    
    
}
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == colorPicker {
            return Array(colorDictionary.keys)[row]
        } else if pickerView == linesPicker {
            if row == 0 {
                return "No limit"
            }
            return String(linesArray[row])
        } else if pickerView == fontPicker {
            return fontTypes[row]
            
        }
       return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == colorPicker {
            ViewController.exampleLabel.textColor = Array(colorDictionary.values)[row]
        } else  if pickerView == linesPicker {
            ViewController.exampleLabel.numberOfLines = linesArray[row]
        } else if pickerView == fontPicker {
            ViewController.exampleLabel.font = UIFont(name: fontTypes[row], size: ViewController.exampleLabel.font.pointSize)
        }
    }
}


extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == colorPicker {
            return Array(colorDictionary).count
        } else if pickerView == linesPicker {
            return linesArray.count
        } else if pickerView == fontPicker {
            return fontTypes.count
        } else {
            return 1
        }
    }
    
}
