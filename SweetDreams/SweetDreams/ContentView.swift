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
   
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColor.Navy, CustomColor.SkyPurple]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Divider()
                    Spacer()
//                    NavigationLink(destination: NewEntryView(), isActive: $goToNewEntry)
//                    {
//                        Button(action: {
//                            goToNewEntry = true
//                        }){
//                            Text("Record a Dream")
//                        }
//                    }
                    Button(action: {
                        goToNewEntry = true
                    }){
                        Text("Record a Dream")
                    }.navigationDestination(isPresented: $goToNewEntry) {
                        NewEntryView()
                    }
                    
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
