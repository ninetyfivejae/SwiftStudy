//
//  TableViewController.swift
//  TabBarSample
//
//  Created by 신재혁 on 29/01/2019.
//  Copyright © 2019 ninetyfivejae. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, SaveDataDelegate {

    @IBOutlet weak var friendListTableView: UITableView!
    
    private var friendList = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendListTableView.dataSource = self
        
        self.friendListTableView.rowHeight = UITableView.automaticDimension
        self.friendListTableView.estimatedRowHeight = 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
            cell.textLabel?.text = friendList[indexPath.row]["name"]
            cell.detailTextLabel?.text = friendList[indexPath.row]["phone"]
            return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SenderTableViewController
        destination.delegate = self
    }
    
    func saveData(data saveData: [String : String]) {
        friendList.append(saveData)
        friendListTableView.reloadData()
    }
    
}
