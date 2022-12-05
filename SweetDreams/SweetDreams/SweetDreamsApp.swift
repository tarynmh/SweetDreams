//
//  SweetDreamsApp.swift
//  SweetDreams
//
//  Created by CUBS Customer on 12/1/22.
//

import SwiftUI

@main
struct SweetDreamsApp: App {
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
//            NavigationStack{
                ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
//            }
        }
    }
}
