//
//  TitleView.swift
//  DreamJournal
//
//  Created by CUBS Customer on 11/28/22.
//

import SwiftUI
import CoreData

struct CustomColor {
    static let Navy = Color("Navy")
    static let SkyPurple = Color("SkyPurple")
    static let LavenderBox = Color("LavenderBox")
    static let buttonPurple = Color("ButtonPurple")
    static let buttonPeriwinkle = Color("ButtonPeriwinkle")
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var goToNewEntry: Bool = false
    @State private var goToAllEntries: Bool = false
   
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColor.Navy, CustomColor.SkyPurple]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Divider()
                    Spacer()
                    Button(action: {
                        goToNewEntry = true
                    }){
                        Text("Record a Dream")
                            .foregroundColor(.white)
                    }.navigationDestination(isPresented: $goToNewEntry) {
                        NewEntryView()
                    }
                    .padding()
                    .background(CustomColor.buttonPurple)
                    .clipShape(Capsule())
                    
                    Button(action: {
                        goToAllEntries = true
                    }){
                        Text("View Dream Logs")
                            .foregroundColor(.white)
                    }.navigationDestination(isPresented: $goToAllEntries) {
                        AllEntriesView()
                    }
                    .padding()
                    .background(CustomColor.buttonPeriwinkle)
                    .clipShape(Capsule())
                    
                }
                Spacer()
                Image("MoonLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300, height: 300)
                
            }
        }
        
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationStack{
//            TitleView()
            let persistedContainer = CoreDataManager.shared.persistentContainer
            ContentView().environment(\.managedObjectContext, persistedContainer.viewContext)
//        }
        
    }
}
