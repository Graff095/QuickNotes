//
//  Note.swift
//  QuickNotes
//
//  Created by Visarg on 14.12.2024.
//

import Foundation

struct Note: Codable {
    let id: UUID
    var text: String
    let date: Date
}
