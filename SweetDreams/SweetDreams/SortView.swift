//
//  SortView.swift
//  SweetDreams
//
//  Created by CUBS Customer on 12/4/22.
//

import SwiftUI

struct SortView: View {
//    NOTE: ********* this view is unused at the moment, but may be turned into a  different view in the future. ********
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var goToNewEntry: Bool
    @Binding var goToAllEntries: Bool
    
    @State private var goToGood: Bool = false
    @State private var goToNeutral: Bool = false
    @State private var goToBad: Bool = false
    
   
    var body: some View {
        NavigationStack{
            ZStack(alignment: .top) {
                LinearGradient(gradient: Gradient(colors: [CustomColor.Navy, CustomColor.SkyPurple]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Text("View Which Dream Type?")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Divider()
                        .overlay(.white)
                        .padding(25)
//                    Button(action: {
//                        goToGood = true
//                    }){
//                        Text("View Good Dreams")
//                            .font(.title)
//                            .foregroundColor(.white)
//                    }.navigationDestination(isPresented: $goToGood) {
////                        AllEntriesView(goToNewEntry: $goToNewEntry, goToAllEntries: $goToAllEntries, filterBy: "Good Dream")
//                        print("to be implemented")
//                    }
//                    .padding()
//                    .padding([.leading,.trailing], 20)
//                    .background(CustomColor.goodDream)
//                    .clipShape(Capsule())
                    
                    Spacer()
                        .frame(maxHeight: 42)
                    
//                    Button(action: {
//                        goToNeutral = true
//                    }){
//                        Text("View Neutral Dreams")
//                            .font(.title)
//                            .foregroundColor(.white)
//                    }.navigationDestination(isPresented: $goToNeutral) {
////                        AllEntriesView(goToNewEntry: self.$goToNewEntry,goToAllEntries: self.$goToAllEntries, filterBy: "Neutral Dream")
//                        print("to be implemented")
//                    }
//                    .padding()
//                    .padding([.leading,.trailing], 15)
//                    .background(CustomColor.neutralDream)
//                    .clipShape(Capsule())
                    
                    Spacer()
                        .frame(maxHeight: 42)
                    
//                    Button(action: {
//                        goToBad = true
//                    }){
//                        Text("View Nightmares")
//                            .font(.title)
//                            .foregroundColor(.white)
//                    }.navigationDestination(isPresented: $goToBad) {
////                        AllEntriesView(goToNewEntry: self.$goToNewEntry,goToAllEntries: self.$goToAllEntries, filterBy: "Nightmare")
//                        print("to be implemented")
//                    }
//                    .padding()
//                    .padding([.leading,.trailing], 42)
//                    .background(CustomColor.badDream)
//                    .clipShape(Capsule())
                    
                }
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button("Home") {
                            goToNewEntry = false
                            goToAllEntries = false
                        }
                    }
                }
                .padding(30)
                .padding(.bottom, 80)
                .background(
                        Image("StarsBg")
                    )
                Spacer()
                
            }
        }
        
    }
}

//struct SortView_Previews: PreviewProvider {
//    static var previews: some View {
//        SortView()
//    }
//}
