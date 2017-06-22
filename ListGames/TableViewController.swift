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
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "game")
        tableView.rowHeight = 100
        
        let headers: HTTPHeaders = ["X-Mashape-Key":"YOUR_KEY", "Accept":"application/json"]
        
        let parameters: Parameters = ["fields":"name,cover", "limit":"20","search":"NBA"]
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
                    print("Name: \(game.name!), ID: \(game.id!)")
                    if let url = game.url {
                        game.url = "https:" + url
                    }
                    print(game.url)
                    
                    if let url = game.url{
                        Alamofire.request(url).responseData(completionHandler: { (response) in
                            if let data = response.result.value {
                                game.coverArt = UIImage(data: data)
                                self.tableView.reloadData()
                            }
                        })
                    }
                    

                }
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gamesArray = gamesArray else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "game", for: indexPath) as? TableViewCell
        if let cell = cell{
            cell.gameName.text = gamesArray[indexPath.row].name
            cell.gameCoverArt.image = gamesArray[indexPath.row].coverArt
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let gamesArray = gamesArray{
            return gamesArray.count
        } else {
            return 1
        }

    }
    
    
}
