//
//  mixtapeApp.swift
//  mixtape
//
//  Created by Olin Johnson on 2/17/24.
//

import SwiftUI
import SwiftData

@main
struct mixtapeApp: App {
    var body: some Scene {
        WindowGroup {
            NavbarView()
        }
        .modelContainer(for: Entry.self)
    }
}
