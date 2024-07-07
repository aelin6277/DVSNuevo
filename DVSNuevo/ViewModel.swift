//
//  ViewModel.swift
//  DVSNuevo
//
//  Created by Elin.Andersson on 2024-07-02.
//
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseMessaging 

class ViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    
    // Lägg till användarprofil
    func addUserProfile(first: String, last: String, born: Int, email: String, avatarUrl: String) {
        db.collection("users").addDocument(data: [
            "first": first,
            "last": last,
            "born": born,
            "email": email,
            "avatarUrl": avatarUrl
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully added!")
            }
        }
    }
    
    // Hämta användarprofiler
    func fetchUserProfiles() {
        db.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    // Lägg till D-vitaminintag
    func addVitaminIntake(userId: String, date: String, dose: Int) {
        db.collection("vitaminIntake").addDocument(data: [
            "userId": userId,
            "date": date,
            "dose": dose
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully added!")
            }
        }
    }
    
    // Hämta D-vitaminintag för en användare
    func fetchVitaminIntake(for userId: String) {
        db.collection("vitaminIntake").whereField("userId", isEqualTo: userId).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}

/*
import Foundation
import FirebaseFirestore

class ViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    
    func addData() {
        db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully added!")
            }
        }
    }
    
    func fetchData() {
        db.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
*/
