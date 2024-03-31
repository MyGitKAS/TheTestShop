//
//  AuthViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

class AuthViewController: UIViewController {
    
    private let coordinator: AuthCoordinator
    private let authView = AuthView()
    private let registrationView = RegistrationView()
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setupInitialView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonActions()
    }
}

// MARK: - Private methods
extension AuthViewController {
    
    func registerButtonTapped(userAuthData: UserAuthData) {
        FirebaseAuthManager.shared.signUpWithEmail(email: userAuthData.email, password: userAuthData.password) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let authResult):
                    print("Успешная регистрация: \(authResult.user.uid)")
                    self.coordinator.showRootTabBar()
                case .failure(let error):
                    self.showErrorAlert(withMessage: "Ошибка регистрации: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func LoginButtonTapped() {
        //  логин
        coordinator.showRootTabBar()
    }
    
    func setupInitialView() {
        view.addSubview(authView)
        authView.frame = view.bounds
    }
    
    func showRegistration() {
        authView.removeFromSuperview()
        view.addSubview(registrationView)
        registrationView.frame = view.bounds
    }
    
    func showAuth() {
        registrationView.removeFromSuperview()
        view.addSubview(authView)
        authView.frame = view.bounds
    }
    
    // MARK: - Setup button actions
    private func setupButtonActions() {
        
        authView.showRegistration = { [weak self] in
            guard let self = self else { return }
            self.showRegistration()
        }
        
        authView.onLogin = { [weak self] in
            guard let self = self else { return }
            self.LoginButtonTapped()
        }
        
        registrationView.onRegistration = { [weak self] userAuthData in
            guard let self = self else { return }
            self.registerButtonTapped(userAuthData: userAuthData)
        }
        
        registrationView.onClose = { [weak self] in
            guard let self = self else { return }
            self.showAuth()
        }
    }
}
