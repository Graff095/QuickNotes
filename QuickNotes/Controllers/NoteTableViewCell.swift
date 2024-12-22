//
//  NoteTableViewCell.swift
//  QuickNotes
//
//  Created by Visarg on 22.12.2024.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupUI()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupUI()
       }
    
    private func setupUI() {
           // Настройка titleLabel
           titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
           titleLabel.textColor = .label
           titleLabel.numberOfLines = 2
           
           // Настройка dateLabel
           dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
           dateLabel.textColor = .secondaryLabel
           
           // Добавление subviews
           contentView.addSubview(titleLabel)
           contentView.addSubview(dateLabel)
           
           // Установка constraints
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           dateLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
               titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
               titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
               
               dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
               dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
               dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
               dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
           ])
       }

    
    // Метод для обновления содержимого ячейки
       func configure(with note: Note, formatter: DateFormatter) {
           titleLabel.text = note.text
           dateLabel.text = formatter.string(from: note.date)
       }
}
