//
//  item.swift
//  Habity
//
//  Created by jalal on 6/26/24.
//

import Foundation
import SwiftUI

struct item: Identifiable {
    let id = UUID().uuidString
    let title: String
    let icon: Image?
    let createdAt: Date
    let deadLine: Date
    let isCompelet: Bool
    
    init(title: String, icon: Image?, createdAt: Date, deadLine: Date, isCompelet: Bool) {
        self.title = title
        self.icon = icon
        self.createdAt = createdAt
        self.deadLine = deadLine
        self.isCompelet = isCompelet
    }
}
