//
//  EmployeeVC.swift
//  MVVMArchitecture
//
//  Created by Tejas Patel on 15/10/23.
//

import UIKit
import CoreData

class EmployeeVC: UIViewController {

    @IBOutlet weak var tblData: UITableView!
    let appDelegate = AppDelegate()
    var result: [NSManagedObject]?
    var names = [String]()
    
    let identifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.saveContext()
        tblData.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tblData.dataSource = self
        tblData.delegate = self
    }
    
    @IBAction func retriveRecord(_ sender: UIButton) {
        result = appDelegate.retriveContext() as? [NSManagedObject]
        for data in result!{
            let name = data.value(forKey: "name") as? String ?? ""
            names.append(name)
        }
        tblData.reloadData()
    }
}

extension EmployeeVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblData.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Boardview", sender: nil)
    }
}
