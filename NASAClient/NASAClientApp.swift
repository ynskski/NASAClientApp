//
//  NASAClientApp.swift
//  NASAClient
//
//  Created by Yunosuke Sakai on 2021/07/12.
//

import SwiftUI
import XCTestDynamicOverlay

@main
struct NASAClientApp: App {
    var body: some Scene {
        WindowGroup {
            if !_XCTIsTesting {
                ContentView()
            }
        }
    }
}
