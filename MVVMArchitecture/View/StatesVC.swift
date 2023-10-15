//
//  StatesVC.swift
//  MVVMArchitecture
//
//  Created by Tejas Patel on 15/10/23.
//

import UIKit

class StatesVC: UIViewController {

    var selectedCountry = String()
    var jsonData: Json4Swift_Base?
    var states = [States]()
    
    let identifier = "cell"
    let cscDataModel = CSCDataModel()
    
    @IBOutlet weak var tblData: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonData = cscDataModel.loadJson(filename: "CSC")
        let filteredStates = filterStatesFromCountry(countryName: selectedCountry)
        states = filteredStates
        tblData.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tblData.dataSource = self
        tblData.delegate = self
    }
    
    private func filterStatesFromCountry(countryName: String) -> [States]{
        let getCountry = jsonData?.countries?.filter{$0.name == countryName}
        let states = getCountry?.first?.states
        return states!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let citiesVC = segue.destination as? CitiesVC{
            if let stateData = sender{
                citiesVC.selectedStateData = stateData
            }
        }
    }
}

extension StatesVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblData.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = states[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Citiesvc", sender: states[indexPath.row])
    }
}
