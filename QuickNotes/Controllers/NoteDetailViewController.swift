//
//  NoteDetailViewController.swift
//  QuickNotes
//
//  Created by Visarg on 18.12.2024.
//

import UIKit

class NoteDetailViewController: UIViewController {

    var note: Note?
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayNote()
    }
    

// MARK:  Настройка интерфейса

    func setupUI () {
        view.backgroundColor = .systemBackground
        title = "Просмотр заметки"

        // Добавляем текстовое поле на экран
        view.addSubview(textView)
        NSLayoutConstraint.activate([
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func displayNote() {
            guard let note = note else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short

            let formattedDate = dateFormatter.string(from: note.date)
            textView.text = "\(note.text)\n\nДата создания: \(formattedDate)"
        }
    
    
    
    }


