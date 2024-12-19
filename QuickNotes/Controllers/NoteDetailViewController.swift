//
//  NoteDetailViewController.swift
//  QuickNotes
//
//  Created by Visarg on 18.12.2024.
//

import UIKit

protocol NoteDetailDelegate: AnyObject {
    func didUpdateNote(at index: Int, with text: String)
}

class NoteDetailViewController: UIViewController {

    var note: Note?
    var noteIndex: Int?
    
    weak var delegate: NoteDetailDelegate?
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(  title: "Редактировать",
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(editNote))
        
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
    
    
    
    
    @objc private func editNote() {
        //Разрешаем редактирование текста
        textView.isEditable = true
        // Устанавливаем фокус на текстовое поле
        textView.becomeFirstResponder()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .done,
            target: self,
            action: #selector(saveNote)
        )
    }
    
    
    @objc private func saveNote() {
        guard let updatedText = textView.text, !updatedText.isEmpty else {return}
        
        // Обновляем текст заметки
      note?.text = updatedText
       
        // Закрываем клавиатуру и запрещаем редактирование
            textView.isEditable = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Редактировать",
                style: .plain,
                target: self,
                action: #selector(editNote)
            )
        if let index = noteIndex {
                   delegate?.didUpdateNote(at: index, with: updatedText)
               }
    }
    }


