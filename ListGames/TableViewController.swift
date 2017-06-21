//
//  TableViewController.swift
//  ListGames
//
//  Created by Jack Ngai on 6/19/17.
//  Copyright © 2017 Jack Ngai. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


class TableViewController: UITableViewController {
    
    var gamesArray:[Game]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headers: HTTPHeaders = ["X-Mashape-Key":"YOUR_KEY", "Accept":"application/json"]
        
        let parameters: Parameters = ["fields":"name,popularity", "limit":"50","search":"NBA", "order":"popularity:desc"]
//        
//        Alamofire.request("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?", method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).response { response in
//            print("Request: \(String(describing: response.request))")
//            print("Response: \(String(describing: response.response))")
//            print("Error: \(String(describing: response.error))")
//            
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)")
//            }
//        }
        
        Alamofire.request("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?", method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseArray { (response: DataResponse<[Game]>) in
            
            self.gamesArray = response.result.value
            self.tableView.reloadData()
            
            if let gamesArray = self.gamesArray{
                for game in gamesArray{
                    print(game.name!)
                }
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gamesArray = gamesArray else {
            return UITableViewCell()
        }
        let cell = UITableViewCell(frame: CGRect.zero)
        cell.textLabel?.text = gamesArray[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let gamesArray = gamesArray{
            return gamesArray.count
        } else {
            return 1
        }

    }
    
    
}
