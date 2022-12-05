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
    
    @State private var goToHome: Bool = false

    @Binding var goToNewEntry: Bool
    @Binding var goToAllEntries: Bool
    
    var filterBy: String
        
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
//        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColor.Navy, CustomColor.SkyPurple]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Text("Past Dreams")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Divider()
                    Spacer()
                    ScrollView{
                        ForEach(allEntries.filter{entry -> Bool in return entry.emotion == filterBy}) { entry in
                            HStack {
                                DreamEntryView(card: Card(title: entry.title!, topic: entry.topic!, emotion: entry.emotion!, isFave: entry.isFave, date:entry.date!), dreamIcon: getDreamIcon(entry.emotion!), dreamColor: getDreamColor(entry.emotion!))
                                    
                            }
                        }
                        .onDelete(perform: deleteEntry)
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
        
//    }
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
