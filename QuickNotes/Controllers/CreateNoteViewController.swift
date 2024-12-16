//
//  CreateNoteViewController.swift
//  QuickNotes
//
//  Created by Visarg on 15.12.2024.
//

import UIKit

// MARK: - CreateNoteDelegate Протокол для передачи данных обратно на главный экран
protocol CreateNoteDelegate: AnyObject {
    func didCreateNote(_ note: Note)
}

class CreateNoteViewController: UIViewController {
   
    // Делегат для передачи данных
    weak var delegate: CreateNoteDelegate?
    
    // Текстовое поле для ввода заметки
    private let textView: UITextView = {
           let textView = UITextView()
           textView.font = UIFont.systemFont(ofSize: 16)
           textView.translatesAutoresizingMaskIntoConstraints = false
           textView.layer.borderWidth = 1
           textView.layer.borderColor = UIColor.systemGray4.cgColor
           textView.layer.cornerRadius = 8
           return textView
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    // Настройка интерфейса
    private func setupUI() {
          view.backgroundColor = .systemBackground
          title = "Новая заметка"

          // Добавляем кнопку "Сохранить"
          navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveNote))

          // Настраиваем текстовое поле
          view.addSubview(textView)
          NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
              textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
              textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
              textView.heightAnchor.constraint(equalToConstant: 600)
          ])
      }
    
    // Метод для обработки нажатия кнопки "Сохранить"
    @objc private func saveNote() {
        
        // Проверяем, что текст не пустой
        guard let text = textView.text, !text.isEmpty else { return }
        // Создаем объект заметки
           let newNote = Note(id: UUID(), text: text, date: Date())
        // Передаем заметку через делегат
           delegate?.didCreateNote(newNote)
        // Возвращаемся на предыдущий экран
           navigationController?.popViewController(animated: true)
       }


}

