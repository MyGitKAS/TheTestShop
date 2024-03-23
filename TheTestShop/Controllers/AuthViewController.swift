//
//  AuthViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

class AuthViewController: UIViewController {
  
    private let coordinator: AuthCoordinator
    private let firstNameTextField = CustomTextField(placeholder: "Name")
    private let lastNameTextField = CustomTextField(placeholder: "Last name")
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    private let confirmPasswordTextField = CustomTextField(placeholder: "Confirm password", isSecure: true)
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Registration", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.font = UIFont.systemFont(ofSize: TextSize.extraLarge.getSize())
        label.textColor = Constants.mainColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupConstraints()
    }
}


// MARK: - Private methods
private extension AuthViewController {
    
    func setupConfiguration() {
        let _ = [titleLabel, firstNameTextField, lastNameTextField, emailTextField, passwordTextField, confirmPasswordTextField, errorLabel, registerButton].forEach {stackView.addArrangedSubview($0)}
        view.addSubview(stackView)
    }
    
    @objc func registerButtonTapped() {
        coordinator.showRootTabBar()
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    // MARK: - Setup constraints
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ConstantsAuthViewController.sidePadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ConstantsAuthViewController.sidePadding)
        ])
    }
}

// MARK: - Constants
fileprivate struct ConstantsAuthViewController {
    static let sidePadding: CGFloat = 30
}
