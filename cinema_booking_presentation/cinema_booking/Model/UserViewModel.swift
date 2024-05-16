//
//  UserViewModel.swift
//  cinema_booking
//
//  Created by Jianuo Liu on 16/5/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
private let firestoreDB = Firestore.firestore()


class UserViewModel: ObservableObject {
    @Published var isLogin = false
    @Published var user = ""
    
    
    init() {
    }
    
    
    func login(user:String, pwd: String) async -> Bool {
        //
        let querySnapshot : Query = firestoreDB.collection("User")
        let filters = querySnapshot.whereFilter(Filter.andFilter([Filter.whereField("user", isEqualTo: user),Filter.whereField("password", isEqualTo: pwd)]))
        do {
            let documents = try await filters.getDocuments().documents
            if documents.count > 0 {
                return true
            }
        } catch  {
            print(error.localizedDescription)
        }
        return false
    }
    
    
    func register(user:String, pwd: String) async -> Bool {
        
        //for searching this history/record
        let querySnapshot : Query = firestoreDB.collection("User")
        let filters = querySnapshot.whereFilter(Filter.andFilter([Filter.whereField("user", isEqualTo: user)]))
        do {
            let documents = try await filters.getDocuments().documents
            if documents.count > 0 {
                return false
            }
            try await firestoreDB.collection("User").addDocument(data: ["userID":UUID().uuidString, "user":user,"password": pwd])
            return true
            
        } catch  {
            print(error.localizedDescription)
        }
        return false
    }
    
    //
    func addTickets(ticket:Ticket) -> Bool {
        //
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        var dict = [String: Any]()
        dict["filmName"] = ticket.filmName
        dict["cinema"] = ticket.cinema
        dict["date"] = formatter.string(from:ticket.date)
        dict["time"] = ticket.time
        dict["seat"] = ticket.seat
        dict["image"] = ticket.image
        dict["user"] = self.user
        dict["id"] = UUID().uuidString
        firestoreDB.collection("Booking").addDocument(data: dict)
    
        return true
    }
    
    //
    func getAllTickets() async -> [Ticket] {
   
        var list = [Ticket]()
        if user.count == 0 {
            return list
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        do {
            let querySnapshot : Query = firestoreDB.collection("Booking")
            let filters = querySnapshot.whereFilter(Filter.whereField("user", isEqualTo: user))
            let documents = try await filters.getDocuments().documents
            documents.forEach { document in
                
                let item = document.data()
                let id = item["id"]  as? String ?? ""
                let filmName = item["filmName"]  as? String ?? ""
                let cinema = item["cinema"]  as? String ?? ""
                
                let time = item["time"]  as? String ?? ""
                let seat = item["seat"]  as? String ?? ""
                let image = item["image"]  as? String ?? ""
                let dateString = item["date"]  as? String ?? ""
               let date =  formatter.date(from: dateString) ?? Date()
                
                list.append(Ticket(id: id, filmName: filmName, cinema: cinema, date: date, time: time, seat: seat, image: image,documentID:document.documentID))
            }
        } catch  {
            print(error.localizedDescription)
        }
        return list
    }
    
    //
    func removeTickets(ticket:Ticket) -> Bool {
        firestoreDB.collection("Booking").document(ticket.documentID).delete()
        return true
    }
}
