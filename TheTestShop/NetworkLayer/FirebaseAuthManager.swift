//
//  FirebaseAuthManager.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 31.03.24.
//
import Foundation
import Firebase
import FirebaseAuth

class FirebaseAuthManager {
    
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
        if let signOutError = try? Auth.auth().signOut() {
            completion(false, signOutError as? Error)
        } else {
            completion(true, nil)
        }
    }
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
