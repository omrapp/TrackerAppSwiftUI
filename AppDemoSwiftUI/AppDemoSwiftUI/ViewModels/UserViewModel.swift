//
//  Users.swift
//  AppDemoSwiftUI
//
//  Created by Omar Ayed on 12/05/2025.
//

import SwiftUI
import TrackerSDK

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}



class UserViewModel: BaseViewModel, ObservableObject {
    
    @Published var users = [User]()
    
    
    @MainActor
    func loadUsers() async {
        
        TimerTrackerSDK.shared.start(tag: "fetch_users_list")
        
        do {
            users = try await NetworkManager.shared.fetchData(from: Endpoint.users)
        } catch let error as APIError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }
        
        TimerTrackerSDK.shared.stop(tag: "fetch_users_list")
    }
    
    
    //    @MainActor
    //    func fetchData() async throws {
    //
    //        do {
    //            let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    //            let (data, response) = try await URLSession.shared.data(from: url)
    //
    //            self.users = try JSONDecoder().decode([User].self, from: data)
    //
    //        } catch {
    //
    //            throw error
    //        }
    //
    //
    //    }
    
}
