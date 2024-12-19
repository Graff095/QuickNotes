//
//  UserDefaults+Notes.swift
//  QuickNotes
//
//  Created by Visarg on 19.12.2024.
//

import Foundation

extension UserDefaults {
    // Ключ для хранения заметок
    private var notesKey: String { "notesKey" }

    // Сохранение массива заметок
    func saveNotes(_ notes: [Note]) {
        if let encoded = try? JSONEncoder().encode(notes) {
            set(encoded, forKey: notesKey)
        }
    }
    
    // Загрузка массива заметок
    func loadNotes() -> [Note] {
        if let data = data(forKey: notesKey),
           let decoded = try? JSONDecoder().decode([Note].self, from: data) {
            return decoded
        }
        return []
    }
}

