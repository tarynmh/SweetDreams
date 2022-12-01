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
    
    private func updateEntry(_ entry: Entry) {
            
            entry.isFave = !entry.isFave
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        private func deleteEntry(at offsets: IndexSet) {
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
    
    var body: some View {
//        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColor.Navy, CustomColor.SkyPurple]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Divider()
                    Spacer()
                    ScrollView{
                        ForEach(allEntries) { entry in
                            HStack {
                                DreamEntryView(card: Card(title: entry.title!, topic: entry.topic!, emotion: entry.emotion!, isFave: entry.isFave, date:entry.date!))
                                    
                            }
                        }
                        .onDelete(perform: deleteEntry)
                    }
                }
                
            }
        }
        
//    }
}

struct AllEntriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AllEntriesView()
        }
        
    }
}
