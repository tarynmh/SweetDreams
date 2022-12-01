//
//  NewEntryView.swift
//  SweetDreams
//
//  Created by CUBS Customer on 12/1/22.
//

import SwiftUI

enum Category: String, Identifiable, CaseIterable {
    var id: Self { return self }
    
    case nightmare = "Nightmare"
    case neutral = "Neutral Dream"
    case good = "Good Dream"
}

extension Category {
    var title: String {
        return rawValue
    }
}

struct NewEntryView: View {
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
//        UISegmentedControl.appearance().layer.backgroundColor = .blue
    }
    
    
    // bool for button to save entry
    @State private var goToEntries: Bool = false
    @State private var title: String = ""
    @State private var topic: String = ""
    @State private var selectedCategory: Category = .neutral
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Entry.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) private var allEntries: FetchedResults<Entry>

       private func saveDream() {

           do {
               let entry = Entry(context: viewContext)
               entry.title = title
               entry.emotion = selectedCategory.rawValue
               entry.date = Date()
               entry.topic = topic
               try viewContext.save()
           } catch {
               print(error.localizedDescription)
           }

       }
    
    private func styleForPriority(_ value: String) -> Color {
            let category = Category(rawValue: value)
            
            switch category {
                case .nightmare:
                    return Color.red
            case .neutral:
                    return Color.blue
                case .good:
                    return Color.green
                default:
                    return Color.black
            }
        }
    
    
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
//        NavigationStack{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColor.Navy, CustomColor.SkyPurple]), startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea()
                RoundedRectangle(cornerRadius: 20).fill(CustomColor.LavenderBox)
                .padding(10)
        
                
                VStack(alignment: .center) {
                    TextField("Name your dream", text: $title)
                        .textFieldStyle(.roundedBorder)
                    Picker("Dream Type", selection: $selectedCategory) {
                        ForEach(Category.allCases) {
                            category in Text(category.title).tag(category)
                                .accentColor(.orange)
                        }
                    }.pickerStyle(.segmented)
//                        .background(CustomColor.SkyPurple)
                        
                    
                    TextField("Describe your dream...", text: $topic, axis: .vertical)
                        .lineLimit(10, reservesSpace:true)
                        .textFieldStyle(.roundedBorder)
                    

                    Button(action: {
                        saveDream()
                        goToEntries = true
                    }){
                        Text("Save")
                    }.navigationDestination(isPresented: $goToEntries) {
                        AllEntriesView()
                    }
                    
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.indigo)
                    .foregroundColor(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius:10, style:.continuous))
                    
                    Spacer()
                }
                .padding(30)
                .padding()
                .background(
                        Image("StarsBg")
                    )
                
//                .navigationTitle("Sweet Dreams")
            }
        }
//        Image("CloudBg")
//            .resizable()
//            .scaledToFit()
//            .frame(height:300, alignment: .bottom)
        
//    }
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView{
//            let persistedContainer = CoreDataManager.shared.persistentContainer
//            NewEntryView().environment(\.managedObjectContext, persistedContainer.viewContext)
        NewEntryView()
//        }
    }
}

