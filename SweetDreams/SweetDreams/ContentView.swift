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
    static let badDream = Color("BadDream")
    static let neutralDream = Color("NeutralDream")
    static let goodDream = Color("GoodDream")
    static let titleColor = Color("TitleColor")
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var goToNewEntry: Bool = false
    @State private var goToAllEntries: Bool = false
    
   
    var body: some View {
        NavigationStack{
            ZStack(alignment: .top) {
                LinearGradient(gradient: Gradient(colors: [CustomColor.Navy, CustomColor.SkyPurple]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Divider()
                        .overlay(.white)
                        .padding(40)
                    Button(action: {
                        goToNewEntry = true
                    }){
                        Text("Record a Dream")
                            .font(.title)
                            .foregroundColor(.white)
                    }.navigationDestination(isPresented: $goToNewEntry) {
                        NewEntryView(goToNewEntry: $goToNewEntry, goToAllEntries: $goToAllEntries)
                    }
                    .padding()
                    .padding([.leading,.trailing], 20)
                    .background(CustomColor.buttonPurple)
                    .clipShape(Capsule())
                    
                    Spacer()
                        .frame(maxHeight: 35)
                    
                    Button(action: {
                        goToAllEntries = true
                    }){
                        Text("View Dream Logs")
                            .font(.title)
                            .foregroundColor(.white)
                    }.navigationDestination(isPresented: $goToAllEntries) {
                        AllEntriesView(goToNewEntry: self.$goToNewEntry,goToAllEntries: self.$goToAllEntries)
                    }
                    .padding()
                    .padding([.leading,.trailing], 15)
                    .background(CustomColor.buttonPeriwinkle)
                    .clipShape(Capsule())
                    
                }
                .padding(30)
                .padding(.bottom, 80)
                .background(
                        Image("StarsBg")
                    )
                Spacer()
                VStack{
                    Image("MoonLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width:300, height: 300)
                }
                .padding(50)

                Spacer()
                
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
