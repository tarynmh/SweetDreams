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
    @Binding var goToNewEntry: Bool
    @Binding var goToAllEntries: Bool
    init(goToNewEntry: Binding<Bool>, goToAllEntries: Binding<Bool>) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(CustomColor.buttonPurple)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        self._goToNewEntry = goToNewEntry
        self._goToAllEntries = goToAllEntries
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
    
    private func colorDreamType(_ value: String) -> Color {
            let category = Category(rawValue: value)
            
            switch category {
                case .nightmare:
                return CustomColor.badDream
            case .neutral:
                return CustomColor.neutralDream
                case .good:
                    return CustomColor.goodDream
                default:
                return CustomColor.LavenderBox
            }
        }
    
    
    private func updateEntry(_ entry: Entry) {
        
//        Note: I tried entry.isFave.toggle(), but it couldn't be assigned to bool
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
            ZStack {
                LinearGradient(gradient: Gradient(colors: [CustomColor.Navy, CustomColor.SkyPurple]), startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea()
                RoundedRectangle(cornerRadius: 20).fill(CustomColor.LavenderBox)
                .padding(10)
                
//                Image("CloudBg")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height:300)
//                    .padding(.top, 600)
                
                VStack(alignment: .center) {
                    Text("How was your dream?")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                    Divider()
                        .overlay(.white)
                        .padding(10)
                    TextField("Name your dream", text: $title)
                        .textFieldStyle(.roundedBorder)
                    Picker("Dream Type", selection: $selectedCategory) {
                        ForEach(Category.allCases) {
                            category in Text(category.title).tag(category)
                                .accentColor(.orange)
                        }
                    }.pickerStyle(.segmented)
                        
                    
                    TextField("Describe your dream...", text: $topic, axis: .vertical)
                        .lineLimit(10, reservesSpace:true)
                        .textFieldStyle(.roundedBorder)
                    

                    Button(action: {
                        saveDream()
                        goToEntries = true
                    }){
                        Text("Save")
                    }.navigationDestination(isPresented: $goToEntries) {
                        AllEntriesView(goToNewEntry: self.$goToNewEntry,goToAllEntries: self.$goToAllEntries)
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
            
            }
        }
}

//struct NewEntryView_Previews: PreviewProvider {
//    static var previews: some View {
////        NavigationView{
////            let persistedContainer = CoreDataManager.shared.persistentContainer
////            NewEntryView().environment(\.managedObjectContext, persistedContainer.viewContext)
//        NewEntryView()
////        }
//    }
//}

