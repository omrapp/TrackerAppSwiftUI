//
//  PostViewModel.swift
//  AppDemoSwiftUI
//
//  Created by Omar Ayed on 18/05/2025.
//

import SwiftUI
import TrackerSDK

struct Post: Codable, Identifiable {
    
    let id: Int
    let userId: Int
    let title: String
    let body: String
}


class PostViewModel: BaseViewModel, ObservableObject {
    
    @Published var posts = [Post]()
    

    @MainActor
    func loadPosts() async {
        
        TimerTrackerSDK.shared.start(tag: "fetch_posts_list")
        
        do {
            posts = try await NetworkManager.shared.fetchData(from: Endpoint.posts)
        } catch let error as APIError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }
        
        TimerTrackerSDK.shared.stop(tag: "fetch_posts_list")
    }
}
