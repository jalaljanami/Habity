//
//  ContentView.swift
//  Habity
//
//  Created by jalal on 6/26/24.
//

import SwiftUI

struct ContentView: View {
    
    let items: [item] = [
        item(title: "First Item", icon: Image(uiImage: .checkmark), createdAt: .now, deadLine: .distantFuture.addingTimeInterval(.pi), isCompelet: true),
        item(title: "Second Item", icon: Image(uiImage: .checkmark), createdAt: .now, deadLine: .distantFuture.addingTimeInterval(.pi), isCompelet: false),
        item(title: "Thired Item", icon: Image(uiImage: .checkmark), createdAt: .now, deadLine: .distantFuture.addingTimeInterval(.pi), isCompelet: false)
    ]
    
    var body: some View {
        
        List {
            ForEach(items) { item in
                
                HStack {
                    if item.isCompelet {
                        Image(systemName: "checkmark.circle.fill")
//                            .resizable()
                            .renderingMode(.template) // <1>
                            .foregroundColor(Color(.blue)) // <2>
//                            .font(. system(size: 60))
//                            .frame(width: 20)
                        
                            
//                            .font(.title)
//                            .tint(.red)
                    } else {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(Color.blue.opacity(0.2))
                            
                    }
                    Text(item.title)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        
}
