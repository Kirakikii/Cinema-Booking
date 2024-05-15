//
//  cinema_bookingApp.swift
//  cinema_booking
//
//  Created by 吴泓昕 on 5/8/24.
//

import SwiftUI
import SwiftData

@main
struct cinema_bookingApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject var globalViewModel = GlobalViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globalViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
