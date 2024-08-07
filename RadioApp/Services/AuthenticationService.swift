//
//  AuthenticationService.swift
//  RadioApp
//
//  Created by Мария Нестерова on 03.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let name: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.name = user.displayName
    }
}

final class AuthenticationManager {
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    private var credential: AuthCredential?
    static let shared = AuthenticationManager()
    
    private init() {
        UserDefaults.standard.removeObject(forKey: "credentials")
    }

    func getAuthenticatedUser() async throws -> AuthDataResultModel {
        guard var user = auth.currentUser else {
            throw URLError(.badServerResponse)
        }
//        user.displayName = getUsername()
        return AuthDataResultModel(user: user)
    }

    func createUser(name: String, email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResults = try await auth.createUser(withEmail: email, password: password)
        saveUsername(name: name)
        return AuthDataResultModel(user: authDataResults.user)
    }

    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await auth.signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signInWithGoogleAccount() async -> Bool {
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = await windowScene.windows.first, let rootViewController = await window.rootViewController else {
            print("There is no root viewController")
            return false
        }
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                throw URLError(.badServerResponse)
            }
            let accessToken = user.accessToken
            let credentials = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let result = try await auth.signIn(with: credentials)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) successfully signed in with email: \(firebaseUser.email ?? "Unknown")")
            return true
        }
        catch {
            print(error.localizedDescription)
            return false
        }
    }

    func signOut() throws {
        try auth.signOut()
    }

    func resetPassword(with email: String) async throws {
        try await auth.sendPasswordReset(withEmail: email)
    }
    
//    func updatePassword(newPassword: String) async throws -> Bool {
//        let user = auth.currentUser
//        guard let credential else { return false }
//        user?.reauthenticate(with: credential) { _, error  in
//          if let error {
//              print(error.localizedDescription)
//          }
//        }
//        
//        do {
//            try await user?.updatePassword(to: newPassword)
//            return true
//        }
//        catch {
//            return false
//        }
//    }
//    
    func updateEmail(newEmail: String) async throws {
        try await auth.currentUser?.sendEmailVerification(beforeUpdatingEmail: newEmail)
    }
    
    private func saveUsername(name: String) {
        guard let userUID = auth.currentUser?.uid else { return }
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            userUID : name
        ]) { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("Document \(ref!.documentID) added")
            }
        }
    }
    
//    private func getUsername() -> String? {
//        guard let userUID = auth.currentUser?.uid else { return nil }
//        var userName: String? = nil
//        db.collection("users").getDocuments { querySnapshot, error in
//            if let error {
//                print(error.localizedDescription)
//            } else {
//                if let documents = querySnapshot?.documents {
//                    for doc in documents {
//                        print(doc.data().keys)
//                        if doc.data().keys.first == userUID {
//                            userName = doc.data()[userUID] as? String
//                            print(userName)
//                        }
//                    }
//                }
//            }
//        }
//        return userName
//    }
}
