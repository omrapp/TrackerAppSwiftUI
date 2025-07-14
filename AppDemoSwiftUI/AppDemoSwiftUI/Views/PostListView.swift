//
//  PostListView.swift
//  AppDemoSwiftUI
//
//  Created by Omar Ayed on 18/05/2025.
//

import SwiftUI


struct PostListView: View {
    
    let userId: Int
    
    @StateObject var vm = PostViewModel()
    @State private var didFetchPosts = false

    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(vm.posts.filter({$0.userId == userId})) { post in
                    
                    NavigationLink(destination: PostSelectedView(post: post)) {
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.headline).padding(.bottom, 10)
                            Text(post.body).lineLimit(2)
                        }.padding(8)
                    }
                }
            }.navigationTitle("Posts")
                .task(id: didFetchPosts) {
                    if !didFetchPosts {
                        await vm.loadPosts()
                        if let error =  vm.errorMessage {
                            print(error)
                        }
                        didFetchPosts = true
                    }
                    
                }
            
        }
        
        
    }
    
    
}


struct PostSelectedView: View {
    
    let post: Post

    var body: some View {
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.title2).padding(.bottom, 20)
                Text(post.body)
                    .font(.body)
                Spacer()
            }.padding(20)
    }
}


#Preview {
    PostListView(userId: 1)
}
