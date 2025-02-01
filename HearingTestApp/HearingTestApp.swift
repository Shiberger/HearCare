//
//  HearingTestAppApp.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

import SwiftUI
import FirebaseCore

@main
struct HearingTestAppApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
