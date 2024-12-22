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
   
    private var filteredNotes: [Note] = []
    private var isSearching = false
    
    // Форматтер для дат
        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()
    
    private var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadNotes()
        tableView.reloadData()
        
    }


    private func  setupUI() {
        
        
        // Настраиваем Search Controller
           searchController = UISearchController(searchResultsController: nil)
           searchController.searchResultsUpdater = self
           searchController.obscuresBackgroundDuringPresentation = false
           searchController.searchBar.placeholder = "Поиск заметок"
           navigationItem.searchController = searchController
           definesPresentationContext = true
        
        
        // Настраиваем навигацию
            title = "QuickNotes"
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))

        
            // Настраиваем таблицу
            tableView = UITableView(frame: view.bounds, style: .plain)
            tableView.dataSource = self
            tableView.delegate = self

            // Регистрация ячейки
            tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
            view.addSubview(tableView)

    }
    
    
    private func loadNotes() {
        notes = UserDefaults.standard.loadNotes() // Загружаем заметки из UserDefaults

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
        return isSearching ? filteredNotes.count : notes.count

    }
    
    // Что показывать в каждой строке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteTableViewCell else {
               return UITableViewCell()
           }
           
           let note = isSearching ? filteredNotes[indexPath.row] : notes[indexPath.row]
           cell.configure(with: note, formatter: dateFormatter)
           return cell
 
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Удаляем заметку из массива
            notes.remove(at: indexPath.row)
            // Сохраняем обновлённые заметки
            UserDefaults.standard.saveNotes(notes)
            // Удаляем строку из таблицы с анимацией
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Получаем выбранную заметку
        let selectedNote = notes[indexPath.row]
        
        // Переходим на NoteDetailViewController
        let detailVC = NoteDetailViewController()
        detailVC.note = selectedNote
        detailVC.noteIndex = indexPath.row // Передаём индекс заметки
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


// MARK: - CreateNoteDelegate
extension MainViewController: CreateNoteDelegate {
    func didCreateNote(_ note: Note) {
        notes.append(note)
        UserDefaults.standard.saveNotes(notes) // Сохраняем обновлённые заметки
        tableView.reloadData()

    }
}


// MARK: - NoteDetailDelegate
extension MainViewController: NoteDetailDelegate {
    func didUpdateNote(at index: Int, with text: String) {
           notes[index].text = text // Обновляем текст в массиве
           UserDefaults.standard.saveNotes(notes) // Сохраняем обновлённые заметки
           tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic) // Обновляем конкретную ячейку
       }
    
}

// MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }

        isSearching = true
        filteredNotes = notes.filter { $0.text.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
}
