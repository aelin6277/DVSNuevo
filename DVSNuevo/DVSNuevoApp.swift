//
//  DVSNuevoApp.swift
//  DVSNuevo
//
//  Created by Elin.Andersson on 2024-06-27.
//import SwiftUI
//import FirebaseCore
//import FirebaseFirestore
//import FirebaseMessaging // Om du behöver Firebase Messaging


import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseMessaging

@main
struct DVSNuevoApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
              .environment(\.managedObjectContext, persistenceController.container.viewContext)
                      }
      }
    }
  }

/*class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
   // Messaging.messaging().delegate = self
    return true
  }
}

*/
/*class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}*/
/*@main
struct DVSNuevoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

*/
/*import SwiftUI

@main
struct DVSNuevoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

*/
