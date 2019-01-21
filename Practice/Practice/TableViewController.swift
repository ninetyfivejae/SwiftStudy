//
//  TableViewController.swift
//  Practice
//
//  Created by 신재혁 on 20/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var numberOfObjectsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        let cellData = indexPath.row
        cell.customTextField.text = String(cellData)
        
        if indexPath.row % 2 == 0 {
            cell.checkLabel.isHidden = true
        }
        
        cell.taskLabel.text = "Task \(indexPath.row)"
        print("Function call \(indexPath)")

        return cell
    }
    
    //section마다 구분을 view 배경색함
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }
}
