//
//  ViewController.swift
//  QuickNotes
//
//  Created by Visarg on 14.12.2024.
//

import UIKit

class MainViewController: UIViewController {
   
    private var tableView: UITableView!
    private var notes: [Note] = []
    
    // Форматтер для дат
        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadNotes()
        tableView.reloadData()
        
    }


    private func  setupUI() {
        
        // Настраиваем навигацию
            title = "QuickNotes"
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))

        
            // Настраиваем таблицу
            tableView = UITableView(frame: view.bounds, style: .plain)
            tableView.dataSource = self
            tableView.delegate = self

            // Регистрация ячейки
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

            view.addSubview(tableView)

    }
    
    
    private func loadNotes() {
        notes = [
            Note(id: UUID(), text: "Купить молоко", date: Date()),
            Note(id: UUID(), text: "Позвонить другу", date: Date()),
            Note(id: UUID(), text: "Прочитать книгу", date: Date())
        ]
    }
    
    
    
    @objc private func addNote() {
        let createNoteVC = CreateNoteViewController()
            createNoteVC.delegate = self // Назначаем делегатом
            navigationController?.pushViewController(createNoteVC, animated: true)
    }
    
}

extension MainViewController:UITableViewDelegate, UITableViewDataSource{
   
    //Сколько строк в таблице:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    // Что показывать в каждой строке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let note = notes[indexPath.row]
        
        // Форматируем дату
        let formattedDate = dateFormatter.string(from: note.date)
        
        // Отображаем текст заметки и дату
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(note.text) \n\(formattedDate)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = .label
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Удаляем заметку из массива
            notes.remove(at: indexPath.row)
            
            // Удаляем строку из таблицы с анимацией
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
}


// MARK: - CreateNoteDelegate
extension MainViewController: CreateNoteDelegate {
    func didCreateNote(_ note: Note) {
        notes.append(note)
        tableView.reloadData()
    }
}
