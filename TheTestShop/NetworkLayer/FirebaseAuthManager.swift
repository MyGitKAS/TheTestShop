//
//  FirebaseAuthManager.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 31.03.24.
//

import Foundation
import Firebase
import FirebaseAuth

final class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    
    private init() {}
    
    func signUpWithEmail(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
    
    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch let signOutError {
            completion(false, signOutError)
        }
    }
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
