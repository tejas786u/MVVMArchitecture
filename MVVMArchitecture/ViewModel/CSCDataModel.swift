//
//  CSCDataModel.swift
//  MVVMArchitecture
//
//  Created by Tejas Patel on 15/10/23.
//

import Foundation

class CSCDataModel{
    func loadJson(filename fileName: String) -> Json4Swift_Base? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Json4Swift_Base.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
