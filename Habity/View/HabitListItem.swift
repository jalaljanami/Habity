//
//  HabitListItem.swift
//  Habity
//
//  Created by Glory's Macmini on 10/2/24.
//

import SwiftUI

struct HabitListItem: View {
    
    @State var habit: Habit2
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
            
//            Circle()
//                .fill(Color.red)
//                .frame(maxWidth: 40)
        }
        
        .frame(maxWidth: .infinity , maxHeight: 80)
        .background(Color(habit.color))
        .modifier(InnerBorder(border: 3, borderColor: .white, opacity: 0.3))
        .padding(.horizontal, 16)
        

    }
}

#Preview {
    HabitListItem(habit: Habit2(title: "New Habite Title", color: "Card-1", weekDays: [], isReminderOn: false))
        .controlSize(.extraLarge)
}
