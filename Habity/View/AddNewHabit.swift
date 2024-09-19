//
//  AddNewHabit.swift
//  Habity
//
//  Created by jalal on 7/28/24.
//

import SwiftUI

struct AddNewHabit: View {
    
    @Environment(\.modelContext) var modelContex
    @EnvironmentObject var habitModel: HabitViewModel
    @Environment(\.self) var selfEnvironment
    
    // MARK: Environment Values
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    TextField("Title", text: $habitModel.title)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(
                            // MARK: A method to add shape and color
                            Color("TFBG"), in:
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                        )
                    
                    // MARK: Habit Color Picker
                    
//                    ColorPicker(habitModel: $habitModel)
                    HStack(spacing: 16) {
                        ForEach(1...7, id: \.self) { index in
                            let color = "Card-\(index)"
                            Circle()
                                .fill(Color(color))
                                .frame(maxWidth: 30)
                                .overlay {
                                    if color == habitModel.color {
                                        Image(systemName: "checkmark")
                                            .font(.caption.bold())
                                    }
                                }
                                .onTapGesture {
                                    withAnimation {
                                        habitModel.color = color
                                    }
                                }
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    
                    // MARK: Frequency Selection
                    
                    VStack(alignment: .leading) {
                        Text("Frequency")
                            .font(.callout.bold())
                        let weekDays = Calendar.current.weekdaySymbols
                        HStack {
                            ForEach(weekDays, id: \.self) { day in
                                let index = habitModel.weekDays.firstIndex { value in
                                    return value == day
                                } ?? -1
                                Text(day.prefix(2))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        // MARK: A different method to add shape and color
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .fill(index != -1 ? Color(habitModel.color) : Color("TFBG"))
                                    )
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 0.3)) {
                                            if index != -1 {
                                                habitModel.weekDays.remove(at: index)
                                            } else {
                                                habitModel.weekDays.append(day)
                                            }
                                        }
                                    }
                            }
                        }
                        .padding(.top, 16)
                    }
                    .padding(.vertical, 16)
                    
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Remainder")
                                .fontWeight(.semibold)
                            Text("Just Notification")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Toggle(isOn: $habitModel.isReminderOn) {}
                            .labelsHidden()
                        
                    }
                    .padding(.vertical, 16)
                    
                    HStack {
                        Label(
                            title: { Text(habitModel.reminderDate.formatted(date: .omitted, time: .shortened)) },
                            icon: { Image(systemName: "clock") }
                        )
                        .padding(.horizontal)
                        .padding(.vertical, 16)
                        .background {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color("TFBG"))
                        }
                        .onTapGesture {
                            withAnimation {
                                habitModel.showTimePicker.toggle()
                            }
                        }
                        
                        TextField("Reminder Text", text: $habitModel.reminderText)
                            .padding(.horizontal)
                            .padding(.vertical, 16)
                            .background(
                                // MARK: A method to add shape and color
                                Color("TFBG"), in:
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                            )
                    }
                    .frame(height: habitModel.isReminderOn ? 20 : 10 )
                    .opacity(habitModel.isReminderOn ? 1 : 0)
                    
                }
                .animation(.easeInOut(duration: 0.3), value: habitModel.isReminderOn)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Add Habit")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            
                            selfEnvironment.dismiss()
                            
                        } label: {
                            Image(systemName: "xmark.circle")
                                .tint(.white)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            //                            DispatchQueue.main.async {
                            selfEnvironment.dismiss()

                            saveHabit(Habit: habitModel)
                            
                            
                            //                            }
                            //                            Task {
                            //                                if await habitModel.addHabit(context: selfEnvironment.managedObjectContext) {
                            //                                    selfEnvironment.dismiss()
                            //                                }
                            //                            }
                        }
                        .tint(.white)
                        .disabled(!habitModel.doneStatus())
                        .opacity(habitModel.doneStatus() ? 1 : 0.6)
                    }
                
            }
            }
        }
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .scrollDismissesKeyboard(.interactively)
        .contentMargins(.bottom, 16)
        .overlay {
            if habitModel.showTimePicker {
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                habitModel.showTimePicker.toggle()
                            }
                        }
                    DatePicker.init("", selection: $habitModel.reminderDate, displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color("TFBG"))
                        }
                        .padding()
                }
            }
        }
    }
    
    func saveHabit(Habit: HabitViewModel) {
        let habit = Habit2(title: Habit.title, isReminderOn: Habit.isReminderOn)
        modelContex.insert(habit)
    }
}

struct ColorPicker: View {
    
    @Environment var habitModel: HabitViewModel
    
    var body: some View {
        VStack() {
            
        }
    }
}
#Preview {
    AddNewHabit()
        .environmentObject(HabitViewModel())
        .preferredColorScheme(.dark)
}
