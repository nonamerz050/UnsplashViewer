//
//  UnsplashViewerApp.swift
//  UnsplashViewer
//
//  Created by MacBook Pro on 4/11/21.
//

import SwiftUI

@main
struct UnsplashViewerApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    let viewModel = MainViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            
            case .background:
                print("")
            case .inactive:
                print("")
            case .active:
                viewModel.loadData()
            @unknown default:
                print("")
            }
        }
    }
}
