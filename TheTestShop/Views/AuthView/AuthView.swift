//
//  AuthView.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 28.03.24.
//

import UIKit

final class AuthView: AuthBaseView {
    
   private let emailTextField = CustomTextField(placeholder: "Email")
   private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    
   private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.fillButton()
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let registerationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create account", for: .normal)
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
    var onLogin: ((UserAuthData) -> Void)?
    
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
            if let email = emailTextField.text, let password = passwordTextField.text {
                let userAuthData = UserAuthData(email: email, password: password)
                onLogin?(userAuthData)
            }
        } else {
            showErrorLabel()
        }
    }

    @objc func registerButtonTapped() {
        showRegistration?()
    }
    
    func validateFields() -> Bool {
        guard let email = emailTextField.text, email.isValid(validType: .email) else {
            errorLabel.text = ValidationError.invalidEmail.rawValue
            errorLabel.isHidden = false
            return false
        }
        
        guard let password = passwordTextField.text, password.isValid(validType: .password) else {
            errorLabel.text = ValidationError.invalidPassword.rawValue
            errorLabel.isHidden = false
            return false
        }
        
        errorLabel.isHidden = true
        return true
    }
    
    func showErrorLabel() {
        errorLabel.isHidden = errorLabel.text?.isEmpty ?? true
    }
}

// MARK: - UITextFieldDelegate
extension AuthView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
    }
}
