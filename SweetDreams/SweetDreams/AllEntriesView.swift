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
    
    private func getDreamIcon(_ value: String) -> any View {
            let category = Category(rawValue: value)
            
            switch category {
                case .nightmare:
                return Image(systemName: "arrowtriangle.down.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(CustomColor.badDream)
                    .font(.system(size: 18))
            case .neutral:
                return Image(systemName: "plus.forwardslash.minus")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(CustomColor.neutralDream)
                    .font(.system(size: 18))
                case .good:
                    return Image(systemName: "arrowtriangle.up.fill")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(CustomColor.goodDream)
                    .font(.system(size: 18))
                default:
                return Image(systemName: "theatermasks")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
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
                    Divider()
                    Spacer()
                    ScrollView{
                        ForEach(allEntries) { entry in
                            HStack {
                                DreamEntryView(card: Card(title: entry.title!, topic: entry.topic!, emotion: entry.emotion!, isFave: entry.isFave, date:entry.date!), dreamIcon: getDreamIcon(entry.emotion!), dreamColor: getDreamColor(entry.emotion!))
                                    
                            }
                        }
                        .onDelete(perform: deleteEntry)
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

struct AllEntriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AllEntriesView()
        }
        
    }
}
