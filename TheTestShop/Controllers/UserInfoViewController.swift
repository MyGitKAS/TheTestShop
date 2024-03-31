//
//  UserInfoViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 23.03.24.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    private let avatarView = AvatarView()
    private let userInfoView = UserInfoView()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 100
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupConstraints()
        getUser()
    }
}


// MARK: - Private methods
extension UserInfoViewController {
    
    func getUser() {
        ShopApiManager.shared.performRequest(for: .getUser(userId: 1)) { [weak self] (result: Result<User?, Error>) in
            guard let self = self else { return }
            switch result {
                case .success(let user):
                    if let user = user {
                        DispatchQueue.main.async{
                            self.avatarView.configureWith(name: "\(user.name.firstname) \(user.name.lastname)")
                            self.userInfoView.configureWithUser(user)
                        }
                    }
            case .failure(let error):
                self.showErrorAlert(withMessage: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    func setupConfiguration() {
        view.backgroundColor = .white
        stackView.addArrangedSubview(avatarView)
        stackView.addArrangedSubview(userInfoView)
        stackView.addArrangedSubview(logoutButton)
        view.addSubview(stackView)
    }
    
    @objc private func logoutButtonTapped() {
        //TODO: - Logout logic
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
}
