//
//  AuthView.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 28.03.24.
//

import UIKit

class AuthView: AuthBaseView {
    
    let emailTextField = CustomTextField(placeholder: "Email")
    let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.fillButton()
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let registerationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.errorLabel()
        label.numberOfLines = 2
        return label
    }()
    
    private var textFields: [UITextField] {
        return [emailTextField, passwordTextField]
    }
    
    var showRegistration: (() -> Void)?
    var onLogin: (() -> Void)?
    
    override func setupConfiguration() {
        super.setupConfiguration()
        textFields.forEach { $0.delegate = self }
        addArrangedSubviews( textFields + [errorLabel, loginButton, registerationButton])
    }
}

// MARK: - Private methods
private extension AuthView {
    
    @objc func loginButtonTapped() {
        textFields.forEach { $0.resignFirstResponder() }
        if validateFields() {
            onLogin?()
        }
    }

    @objc func registerButtonTapped() {
        showRegistration?()
    }
    
    func validateFields() -> Bool {
        guard let email = emailTextField.text, email.isValid(validType: .email) else {
            errorLabel.text = "Please enter a valid email address."
            errorLabel.isHidden = false
            return false
        }
        
        guard let password = passwordTextField.text, password.isValid(validType: .password) else {
            errorLabel.text = "Please enter your password."
            errorLabel.isHidden = false
            return false
        }
        
        errorLabel.isHidden = true
        return true
    }
}

// MARK: - UITextFieldDelegate
extension AuthView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
    }
}
