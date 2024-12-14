//
//  ViewController.swift
//  QuickNotes
//
//  Created by Visarg on 14.12.2024.
//

import UIKit

class MainViewController: UIViewController {
   
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension MainViewController:UITableViewDelegate, UITableViewDataSource{
   
    //Сколько строк в таблице:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // Что показывать в каждой строке
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
    }
    
    
}
