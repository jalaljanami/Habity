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

    @Query(sort: \Habit2.createdAt, order: .reverse) var habits: [Habit2]
    @State var selectedHabit: Habit2?
    
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
                        addNewHabitAction()
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
                ScrollView {
//                    Text("hi")
                    ForEach(habits, id: \.self) { habit in
//                        NavigationLink(value: habit) {
//                            VStack(alignment: .leading) {
//                                
//                                HStack {
//                                    Circle()
//                                        .fill(Color(habit.color))
//                                        .frame(maxWidth: 16)
//                                    Text(habit.title)
//                                }
//                            }
                        HabitListItem(habit: habit)
                            .onTapGesture {
                                showAddNewHabitView = true
                                selectedHabit = habit
                            }
//                        }
                    }
                    .onDelete(perform: RemoveHabit)
//                    .onAppear {
//                        reversedItems = habits.reversed()
//                    }
//                    .onChange(of: habits) { newReversedItems in
//                        reversedItems = newReversedItems.reversed()
//                    }
                   
                    
                    
                }
                .onTapGesture { IndexPath in
                    
                    
                }
//                .background {
//                    Color.red
//                }
//                NavigationLink(destination: AddNewHabit(habit: habits[0]), label: {
//                    
//                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView(habits.isEmpty ? .init() : .vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        
                        if habits.isEmpty {
                            Button {
                                addNewHabitAction()
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
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .sheet(isPresented: $showAddNewHabitView) {
            // MARK: Erasing all existing content
            habitModel.resetData()
        } content: {
            if (selectedHabit != nil) {
                AddNewHabit(habit: selectedHabit!)
                    .interactiveDismissDisabled(true)
            } else {
                AddNewHabit(habit: Habit2(title: "New Habite Title", weekDays: [], isReminderOn: false))
//                .environmentObject(habitModel)
                    .interactiveDismissDisabled(true)
            }
        }
        
    }
    
    func addNewHabitAction() {
        showAddNewHabitView = true
    }
    
    func RemoveHabit(_ indexSet: IndexSet) {
        for index in indexSet {
            let habit = habits[index]
            modelContex.delete(habit)
        }
    }
    
//    func addSample() {
//        
//        DispatchQueue.main.async {
//            let firstHabit = Habit2(id: <#String#>, title: "Test01" ,isReminderOn: false)
//            modelContex.insert(firstHabit)
//        }
//        
//    }
}

#Preview {
    Home()
        .preferredColorScheme(.dark)
}
