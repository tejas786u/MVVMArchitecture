//
//  CitiesVC.swift
//  MVVMArchitecture
//
//  Created by Tejas Patel on 15/10/23.
//

import UIKit

class CitiesVC: UIViewController {
    
    var selectedStateData: Any?
    var jsonData: Json4Swift_Base?
    var cities = [String]()
    
    let identifier = "cell"

    @IBOutlet weak var tblData: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let states = selectedStateData as! States
        cities = states.cities ?? ["surat"]
        tblData.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tblData.dataSource = self
        tblData.delegate = self
    }
}

extension CitiesVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblData.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Employeevc", sender: nil)
    }
}
