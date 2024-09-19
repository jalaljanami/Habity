//
//  Home.swift
//  Habity
//
//  Created by jalal on 7/28/24.
//

import SwiftUI
import SwiftData

struct Home: View {
    @Environment(\.modelContext) var modelContex
//    @FetchRequest(entity: HabitTracker.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \HabitTracker.dateAdded, ascending: false )], animation: .easeInOut)
    @Query var habits: [Habit2]
//    var habits: FetchedResults<HabitTracker>
    
    @StateObject var habitModel: HabitViewModel = HabitViewModel()
    @State var showAddNewHabitView = false
    
    var body: some View {
        VStack {
            Text("Habity")
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title2)
                            .tint(.white)
                    }
                }
                .overlay(alignment: .trailing) {
                    Button {
//                        habitModel.addNewHabit.toggle()
                        showAddNewHabitView = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                            .tint(.white)
                    }
                    .disabled(habits.isEmpty)
                    .opacity(habits.isEmpty ? 0.0 : 1.0)
//                    .padding(.top, 15)
//                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                }
            
//            Button("AddSample", action: addSample)
//            
            if !habits.isEmpty {
                List {
//                    Text("hi")
                    ForEach(habits.reversed()) { habit in
                        VStack(alignment: .leading) {
                            Text(habit.title)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            ScrollView(habits.isEmpty ? .init() : .vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    
                    if habits.isEmpty {
                        Button {
//                            habitModel.addNewHabit.toggle()
                            showAddNewHabitView = true
//                            addSample()
                        } label: {
                            Label (
                                title: { Text("New habit") },
                                icon: { Image(systemName: "plus.circle") }
                            )
                            .font(.callout.bold())
                            .tint(.white)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    } else {
                        
                    }
                }
                .padding(.vertical)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .sheet(isPresented: $showAddNewHabitView) {
            // MARK: Erasing all existing content
            habitModel.resetData()
        } content: {
            AddNewHabit()
                .environmentObject(habitModel)
                .interactiveDismissDisabled(true)
        }
    }
    
    func addSample() {
        
        DispatchQueue.main.async {
            let firstHabit = Habit2(title: "Test01" ,isReminderOn: false)
            modelContex.insert(firstHabit)
        }
        
    }
}

#Preview {
    Home()
        .preferredColorScheme(.dark)
}
