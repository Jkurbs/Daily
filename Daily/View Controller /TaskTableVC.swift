//
//  TaskTableVC.swift
//  Daily
//
//  Created by Kerby Jean on 2/3/20.
//  Copyright © 2020 Kerby Jean. All rights reserved.
//

import UIKit

class GenericTableViewController<T, Cell: UITableViewCell>: UITableViewController {
    
    var items: [Task]?
    var configure: (Cell, Task) -> Void
    var selectHandler: (Task) -> Void
    var listController = ListController()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(items: [Task]?, id: String, configure: @escaping (Cell, Task) -> Void, selectHandler: @escaping (Task) -> Void) {
        self.items = items
        self.configure = configure
        self.selectHandler = selectHandler
        
        super.init(style: .plain)
        self.tableView.register(Cell.self, forCellReuseIdentifier: id)
        
        self.view.backgroundColor = .white
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.editingAccessoryType = .checkmark
        let item = itemForSection(indexPath: indexPath)
        configure(cell, item!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if let item = itemForSection(indexPath: indexPath) {
            selectHandler(item)
        }
        tableView.reloadData()
    }
    
    
    
    func itemForSection(indexPath: IndexPath) -> Task? {
        return items?[indexPath.row]
       
    }
}
