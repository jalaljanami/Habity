//
//  AddNewHabit.swift
//  Habity
//
//  Created by jalal on 7/28/24.
//

import SwiftUI

struct AddNewHabit: View {
    
    // MARK: Environment Values
    @Environment(\.self) var selfEnvironment
    @Environment(\.presentationMode) var presentationMode
        
    @Environment(\.modelContext) var modelContex
    @EnvironmentObject var habitModel: HabitViewModel

    @Bindable var habit: Habit2
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // MARK: Habit Title
                    HabitTitleTextfield(Habit: habit)
                    
                    // MARK: Habit Color Picker
                    ColorPicker(habit: habit)
                    
                    // MARK: Frequency Selection
                    FrequencySelection(habit: habit)
                    
 
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text("Remainder")
//                                .fontWeight(.semibold)
//                            Text("Just Notification")
//                                .font(.caption)
//                                .foregroundStyle(.gray)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        
//                        Toggle(isOn: $habit.isReminderOn) {}
//                            .labelsHidden()
//                        
//                    }
//                    .padding(.vertical, 16)
//                    
//                    HStack {
//                        Label(
//                            title: { Text(Habit.reminderDate.formatted(date: .omitted, time: .shortened)) },
//                            icon: { Image(systemName: "clock") }
//                        )
//                        .padding(.horizontal)
//                        .padding(.vertical, 16)
//                        .background {
//                            RoundedRectangle(cornerRadius: 16, style: .continuous)
//                                .fill(Color("TFBG"))
//                        }
//                        .onTapGesture {
//                            withAnimation {
//                                habitModel.showTimePicker.toggle()
//                            }
//                        }
//                        
//                        TextField("Reminder Text", text: $Habit.reminderText)
//                            .padding(.horizontal)
//                            .padding(.vertical, 16)
//                            .background(
//                                // MARK: A method to add shape and color
//                                Color("TFBG"), in:
//                                RoundedRectangle(cornerRadius: 16, style: .continuous)
//                            )
//                    }
//                    .frame(height: Habit.isReminderOn ? 20 : 10 )
//                    .opacity(Habit.isReminderOn ? 1 : 0)
                    
                }
                .animation(.easeInOut(duration: 0.3), value: habit.isReminderOn)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Add Habit")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
//                            presentationMode.wrappedValue.dismiss()
//                            didDismiss()
//                            presentationMode.wrappedValue.dismiss()
                            selfEnvironment.dismiss()
                        } label: {
                            Image(systemName: "xmark.circle")
                                .tint(.white)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            //                            DispatchQueue.main.async {
                            habit.createdAt = Date()
//                            didDismiss()
//                            presentationMode.wrappedValue.dismiss()
                            selfEnvironment.dismiss()
                            
                            saveHabit(Habit: habit)
                            
                            
                            //                            }
                            //                            Task {
                            //                                if await habitModel.addHabit(context: selfEnvironment.managedObjectContext) {
                            //                                    selfEnvironment.dismiss()
                            //                                }
                            //                            }
                        }
                        .tint(.white)
//                        .disabled(!habitModel.doneStatus())
//                        .opacity(habitModel.doneStatus() ? 1 : 0.6)
                    }
                
            }
            }
        }
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .scrollDismissesKeyboard(.interactively)
        .contentMargins(.bottom, 16)
        

//       .overlay {
//            if habitModel.showTimePicker {
//                ZStack {
//                    Rectangle()
//                        .fill(.ultraThinMaterial)
//                        .ignoresSafeArea()
//                        .onTapGesture {
//                            withAnimation {
//                                habitModel.showTimePicker.toggle()
//                            }
//                        }
//                    DatePicker.init("", selection: $habitModel.reminderDate, displayedComponents: [.hourAndMinute])
//                        .datePickerStyle(.wheel)
//                        .labelsHidden()
//                        .padding()
//                        .background {
//                            RoundedRectangle(cornerRadius: 16, style: .continuous)
//                                .fill(Color("TFBG"))
//                        }
//                        .padding()
//                }
//            }
//        }
    }
    
    func saveHabit(Habit: Habit2) {
//        let habit = Habit2(title: Habit.title, isReminderOn: Habit.isReminderOn)
        modelContex.insert(Habit)
        
    }
}

struct HabitTitleTextfield: View {
    
    @Bindable var Habit: Habit2
    
    var body: some View {
        TextField("Title", text: $Habit.title)
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(
                // MARK: A method to add shape and color
                Color("TFBG"), in:
                RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
    }
}

struct ColorPicker: View {
    
//    @Environment var habitModel: HabitViewModel
    var habit: Habit2
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(1...7, id: \.self) { index in
                let color = "Card-\(index)"
                Circle()
                    .fill(Color(color))
                    .frame(maxWidth: 30)
                    .overlay {
                        if color == habit.color {
                            Image(systemName: "checkmark")
                                .font(.caption.bold())
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            habit.color = color
                        }
                    }
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
    }
}

struct FrequencySelection : View {
    
    var habit : Habit2
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Frequency")
                .font(.callout.bold())
            let weekDays = Calendar.current.weekdaySymbols
            HStack {
                ForEach(weekDays, id: \.self) { day in
                    let index = habit.weekDays.firstIndex { value in
                        
                        return value == day
                    } ?? -1
                    let _ = print(index)
                Text(day.prefix(3))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            // MARK: A different method to add shape and color
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(index != -1 ? Color(habit.color) : Color("TFBG"))
                        )
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.3)) {
                                if index != -1 {
                                    habit.weekDays.remove(at: index)
                                } else {
                                    habit.weekDays.append(day)
                                }
                            }
                        }
                }
            }
            .padding(.top, 16)
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    AddNewHabit(habit: Habit2(title: "Test", isReminderOn: false))
        .environmentObject(HabitViewModel())
        .preferredColorScheme(.dark)
}
