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
        //view.backgroundColor = #colorLiteral(red: 0.9443568679, green: 0.9443568679, blue: 0.9443568679, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
                    print("success: \(authResult.user.uid)")
                    self.coordinator.showRootTabBar()
                case .failure(let error):
                    self.showErrorAlert(withMessage: "Registration error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func LoginButtonTapped(userAuthData: UserAuthData) {
        FirebaseAuthManager.shared.signInWithEmail(email: userAuthData.email, password: userAuthData.password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.coordinator.showRootTabBar()
            case .failure(let error):
                self.showErrorAlert(withMessage: "Login error: \(error.localizedDescription)")
            }
        }
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
        
        authView.onLogin = { [weak self] userAuthData in
            guard let self = self else { return }
            self.LoginButtonTapped(userAuthData: userAuthData)
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
