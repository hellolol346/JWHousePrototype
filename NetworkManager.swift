//
//  NetworkManager.swift
//  JWHousePrototype
//
//  Created by Swathika Ganesh on 4/16/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

struct Menu: Identifiable, Hashable {
    let id = UUID()
    var date: Date
    var menuItems: [String]
}

class NetworkManager: ObservableObject {
    @Published var menu: [Menu] = []
    @Published var userID: String = ""
    var ref: DatabaseReference!
    static let shared = NetworkManager()
    func connectWithFirebase() {
        Auth.auth().signInAnonymously() { user,error in
            self.userID = user?.user.uid ?? ""
        }
    }
    func retrieveFromDatabase(completion: @escaping (Result < [[String: Any]], Error > )->Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Cannot find user")
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Not Authorized"])))
            return
        }
        Firestore.firestore().collection("1234").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let menuItems = snapshot!.documents.map({$0.data()})
                completion(.success(menuItems))
            }
        }
    }
    
    func retrieveBusinessHoursFromDatabase(completion: @escaping (Result < [[String: Any]], Error > )->Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Cannot find user")
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Not Authorized"])))
            return
        }
        Firestore.firestore().collection("Business").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let businessHours = snapshot!.documents.map({$0.data()})
                completion(.success(businessHours))
            }
        }
    }
    
}
extension Date {
    func getDay() -> String {
        let day = Calendar.current.dateComponents([.weekday], from: self).weekday
        switch(day) {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            break
        }
    return ""
    }
    
    func getMonth() -> String {
        let month = Calendar.current.dateComponents([.month], from: self).month
        switch(month) {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "Jun"
        case 7:
            return "Jul"
        case 8:
            return "Aug"
        case 9:
            return "Sep"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            break
        }
    return ""
    }
}
