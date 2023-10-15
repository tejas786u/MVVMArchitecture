//
//  ViewController.swift
//  MVVMArchitecture
//
//  Created by Tejas Patel on 15/10/23.
//

import UIKit

class CountriesVC: UIViewController {
    
    let identifier = "cell"
    var dataCSC: Json4Swift_Base? = nil
    let cscDataModel = CSCDataModel()
    
    @IBOutlet weak var tblData: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataCSC = cscDataModel.loadJson(filename: "CSC")
        tblData.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tblData.dataSource = self
        tblData.delegate = self
//        starPattern(n: 5)
        apiCall()
    }
    
    func apiCall(){
        NetworkManager.shared.fetchMovieData { page, error in
            print(page)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let statesVC = segue.destination as? StatesVC{
            if let selectedCountryName = sender as? String{
                statesVC.selectedCountry = selectedCountryName
            }
        }
    }
    
    func starPattern(n: Int){
        for i in 1...n{
            for _ in stride(from: n, to: i, by: -1){
                print("", terminator: " ")
            }
            for _ in 1...i{
                print("*", terminator: " ")
            }
            print()
        }
        for i in stride(from: n-1, to: 0, by: -1){
            for _ in stride(from: n, to: i, by: -1){
                print("", terminator: " ")
            }
            for _ in 1...i{
                print("*", terminator: " ")
            }
            print()
        }
    }
}

extension CountriesVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCSC?.countries?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblData.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = dataCSC?.countries![indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Statesvc", sender: dataCSC?.countries![indexPath.row].name)
    }
}
