//
//  ViewRegistration.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 28.03.24.
//

import UIKit

class RegistrationView: AuthBaseView {
    
    private let firstNameTextField = CustomTextField(placeholder: "Name")
    private let lastNameTextField = CustomTextField(placeholder: "Last name")
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    private let confirmPasswordTextField = CustomTextField(placeholder: "Confirm password", isSecure: true)
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.fillButton()
        button.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        return button
    }()
        
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.errorLabel()
        label.numberOfLines = 2
        return label
    }()
    
    private var textFields: [UITextField] {
        return [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, confirmPasswordTextField]
    }
    
    var onClose: (() -> Void)?
    var onRegistration: ((UserAuthData) -> Void)?
    
    override func setupConfiguration() {
        super.setupConfiguration()
        addArrangedSubviews(textFields + [errorLabel, registerButton])
        textFields.forEach { $0.delegate = self }
        addSubview(closeButton)
        setupConstraints()
    }
}

// MARK: - Private methods
private extension RegistrationView {
    
    @objc func registrationButtonTapped() {
        textFields.forEach {$0.resignFirstResponder()}
        if validateFields() {
            if let email = emailTextField.text, let password = passwordTextField.text {
                let userAuthData = UserAuthData(email: email, password: password)
                onRegistration?(userAuthData)
            }
        } else {
            showErrorLabel()
        }
    }

    func validateFields() -> Bool {
        guard let name = firstNameTextField.text, !name.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            errorLabel.text = "Please fill in all fields."
            return false
        }
        
        guard email.isValid(validType: .email) else {
            errorLabel.text = "Invalid email address."
            return false
        }
        
        guard password.isValid(validType: .password) else {
            errorLabel.text = "Password must contain at least one letter and one digit at least 8 characters long"
            return false
        }
        
        guard password == confirmPassword else {
            errorLabel.text = "Passwords do not match."
            return false
        }
                
        return true
    }
    
    func showErrorLabel() {
        errorLabel.isHidden = errorLabel.text?.isEmpty ?? true
    }
    
    @objc func closeButtonTapped() {
        onClose?()
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: ConstantsRegistrationView.closeButtonPadding),
             closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -ConstantsRegistrationView.closeButtonPadding)
         ])
    }
}

// MARK: - UITextFieldDelegate
extension RegistrationView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
    }
}

// MARK: - Constants
fileprivate struct ConstantsRegistrationView {
    static let closeButtonPadding: CGFloat = 10
}
