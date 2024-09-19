//
//  HabityApp.swift
//  Habity
//
//  Created by jalal on 6/26/24.
//

import SwiftUI
import SwiftData

@main
struct HabityApp: App {
    var body: some Scene {
        WindowGroup {
            Home()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: Habit2.self)
    }
}
