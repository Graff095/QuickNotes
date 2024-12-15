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
        cell.textLabel?.text = note.text
        return cell
    }
    
    
}
