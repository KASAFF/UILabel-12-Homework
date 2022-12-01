//
//  ViewController.swift
//  UITextField and NC 13 homework
//
//  Created by Aleksey Kosov on 01.12.2022.
//

import UIKit

class LoginController: UIViewController {
    private let registerImage = UIImageView()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let ageTextField = UITextField()
    private let loginButton = UIButton()
    
    var loginData: Users?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Notification center for keyboard
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notif in
            self.view.frame.origin.y = -100
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { Notification in
            self.view.frame.origin.y = 0.0
        }
        //UIImageView
        registerImage.image = UIImage(systemName: "person.fill.badge.plus")
        registerImage.frame = CGRect(x: 120, y: 100, width: 150, height: 140)
        view.addSubview(registerImage)
        
        //EmailText Field
        emailTextField.frame = CGRect(x: 100, y: 300, width: 200, height: 35)
        emailTextField.placeholder = "Enter email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.delegate = self
        view.addSubview(emailTextField)
        //PasswordTextField
        passwordTextField.frame = CGRect(x: 100, y: 400, width: 200, height: 35)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.delegate = self
        view.addSubview(passwordTextField)
        //AgeTextField
        ageTextField.frame = CGRect(x: 100, y: 500, width: 200, height: 35)
        ageTextField.keyboardType = .numberPad
        ageTextField.addDoneCancelToolbar()
        ageTextField.placeholder = "Age"
        ageTextField.borderStyle = .roundedRect
        ageTextField.delegate = self
        view.addSubview(ageTextField)
        //Button
        loginButton.frame = CGRect(x: 140, y: 680, width: 120, height: 50)
        loginButton.setTitle("Register", for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 5
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        //loginData = Users(email: emailTextField.text!, password: passwordTextField.text!, age: Int(ageTextField.text!)!)
    }
    @objc func loginPressed() {
        checkTextFields()
        
        print(loginData)
        if let loginDataSafe = loginData {
            print(loginDataSafe)
            if checkInDatebase(data: loginDataSafe) {
                let vc = ViewController()
                vc.tabBarItem = UITabBarItem(title: "Font", image: UIImage(systemName: "text.justify"), tag: 0)
                let secondVC = SecondViewController()
                secondVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear.circle"), tag: 1)
                let firstNavController = UINavigationController(rootViewController: vc)
                let secondNavController = UINavigationController(rootViewController: secondVC)
                let tabBar = UITabBarController()
                tabBar.setViewControllers([firstNavController, secondNavController], animated: true)
                tabBar.tabBar.isTranslucent = false
                tabBar.tabBar.barTintColor = .white
                tabBar.modalPresentationStyle = .fullScreen
                present(tabBar, animated: true)
            } else {
                let alert = UIAlertController(title: "Your are not registered", message: "Are you wish to register?", preferredStyle: .alert)
                let yes = UIAlertAction(title: "Yes", style: .default) { action in
                    Users.allUsers.append(loginDataSafe)
                    print(Users.allUsers)
                }
               let no = UIAlertAction(title: "No", style: .cancel)
                alert.addAction(yes)
                alert.addAction(no)
                present(alert, animated: true)
            }
        }
    }
    func checkTextFields()  {
        guard let safeEmail = emailTextField.text else { emailTextField.shake(); return }
        if safeEmail.isEmpty {
            emailTextField.shake()
        }
        guard let safePassword = passwordTextField.text else { passwordTextField.shake(); return }
        if safePassword.isEmpty {
            passwordTextField.shake()
        }
        guard let safeAge: Int = Int(ageTextField.text!) else { ageTextField.shake(); return }
        loginData = Users(email: safeEmail, password: safePassword, age: safeAge)
    }
    func checkInDatebase(data: Users) -> Bool {
        for (i,database) in Users.allUsers.enumerated() {
            if data == database {
                print(i)
                return true
            }
        }
        return false
    }
    
}
//MARK: - go to Next TF after return
extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.isEditing {
            passwordTextField.becomeFirstResponder()
        } else if passwordTextField.isEditing {
            ageTextField.becomeFirstResponder()
        }
        return true
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField == emailTextField {
//            guard let text = textField.text else { return }
//
//
//        } else if textField == passwordTextField {
//            guard let text = textField.text else { return }
//
//        } else {
//            guard let age = Int(textField.text!) else { return }
//
//        }
//    }
}
//MARK: - Shake Animation
extension UITextField {
    func shake() {
        let plhder = placeholder!
        attributedPlaceholder = NSAttributedString(
            string: "Empty data",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
        )
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.attributedPlaceholder = NSAttributedString(
                string: plhder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        }
    }
}
