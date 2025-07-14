//
//  UserView.swift
//  AppDemoSwiftUI
//
//  Created by Omar Ayed on 12/05/2025.
//

import SwiftUI


struct UserListView: View {
    
    @StateObject var vm = UserViewModel()
    @State private var didFetchUsers = false

    var body: some View {
        
        NavigationStack {
            List {
                ForEach(vm.users) { user in
                    
                    NavigationLink(destination: PostListView(userId: user.id)) {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.title2)
                            Text(user.email)
                        }
                    }
                    
                   
                }
            }.navigationTitle("Users")
                //.navigationDestination(for: String.self, destination: UserSelectView.init)
                .task(id: didFetchUsers) {
                    
                    if !didFetchUsers {
                        await vm.loadUsers()
                        
                        if let error =  vm.errorMessage {
                            print(error)
                        }
                        didFetchUsers = true
                    }
                    
                }
            
        }
        
        
    }
    
    
}


struct UserSelectView: View {
    let name: String

    var body: some View {
        Text("Selected User: \(name)")
            .font(.largeTitle)
    }
}




#Preview {
    UserListView()
}
