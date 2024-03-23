//
//  UserInfoView.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 23.03.24.
//

import UIKit

class UserInfoView: UIView {
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
        setupConstraints() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(email: String, address: String, phone: String) {
        emailLabel.text = email
        addressLabel.text = address
        phoneLabel.text = phone
    }
}


// MARK: - Private methods
extension UserInfoView {
    
    func setupConfiguration() {
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(phoneLabel)
        addSubview(stackView)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
