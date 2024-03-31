//
//  AuthBaseView.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 28.03.24.
//

import UIKit

class AuthBaseView: UIView {
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
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
    
    func setupConfiguration() {
        addSubview(stackView)
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { stackView.addArrangedSubview($0) }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ConstantsAuthBaseView.padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ConstantsAuthBaseView.padding)
        ])
    }
}

// MARK: - Constants
fileprivate struct ConstantsAuthBaseView {
    static let padding: CGFloat = 30
}
