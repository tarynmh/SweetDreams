//
//  AllEntriesView.swift
//  SweetDreams
//
//  Created by CUBS Customer on 12/1/22.
//

import SwiftUI
import CoreData

struct AllEntriesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Entry.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) private var allEntries: FetchedResults<Entry>
    
    // bool to go back home
    @State private var goToHome: Bool = false

    // bools for popping past views off the nav stack and going back home
    @Binding var goToNewEntry: Bool
    @Binding var goToAllEntries: Bool
    
    @State var filterBy: String = "All Dreams"
    @State var selectedDreamIndex = 0
    
    // list for filtering
    var dreamTypes = ["All Dreams","Good Dreams", "Neutral Dreams", "Nightmares"]
        
    
    //function for deleting an entry (NOTE: only works when using a list, not a forEach at the moment)
    func deleteEntry(at offsets: IndexSet) {
        offsets.forEach { index in
            let entry = allEntries[index]
            viewContext.delete(entry)
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // function to display a certain icon on the dream entry cards depending on the type of dream you had
    private func getDreamIcon(_ value: String) -> String {
            let category = Category(rawValue: value)
            
            switch category {
                case .nightmare:
                return "arrowtriangle.down.fill"
            case .neutral:
                return "minus"
                case .good:
                    return "arrowtriangle.up.fill"
                default:
                return "minus"
            }
        }
    
    // function to display a certain color of the icon for the dream entry cards depending on the type of dream you had
    private func getDreamColor(_ value: String) -> Color {
            let category = Category(rawValue: value)
            
            switch category {
                case .nightmare:
                return CustomColor.badDream
            case .neutral:
                return .white
                case .good:
                return CustomColor.goodDream
                default:
                return .gray
            }
        }
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColor.Navy, CustomColor.SkyPurple]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack() {
                    VStack {
                        HStack(){
                            Spacer()
                            Picker("Filter Dreams", selection: $filterBy, content: {
                                ForEach(dreamTypes, id: \.self, content: { dream in
                                    Text(dream)
                                        
                                })
                            })
                            .background(CustomColor.LavenderBox)
                            .cornerRadius(10)
                            .tint(.white)
                        }
                    }
                    .padding(.bottom, 10)
                    Text("Past Dreams")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Divider()
                    Spacer()
                    ScrollView{
                        if(filterBy == "All Dreams") {
                            ForEach(allEntries) { entry in
                                HStack {
                                    DreamEntryView(card: Card(title: entry.title!, topic: entry.topic!, emotion: entry.emotion!, isFave: entry.isFave, date:entry.date!), dreamIcon: getDreamIcon(entry.emotion!), dreamColor: getDreamColor(entry.emotion!))
                                        
                                }
                            }
                            .onDelete(perform: deleteEntry)
                        }
                        else {
                            ForEach(allEntries.filter{entry -> Bool in return entry.emotion == String(filterBy.dropLast(1))}) { entry in
                                HStack {
                                    DreamEntryView(card: Card(title: entry.title!, topic: entry.topic!, emotion: entry.emotion!, isFave: entry.isFave, date:entry.date!), dreamIcon: getDreamIcon(entry.emotion!), dreamColor: getDreamColor(entry.emotion!))
                                        
                                }
                            }
                            .onDelete(perform: deleteEntry)
                        }
                    }
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
                .padding()
                .background(
                        Image("StarsBg")
                    )
                
            }
        }
}
//
//struct AllEntriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            AllEntriesView()
//        }
//
//    }
//}
