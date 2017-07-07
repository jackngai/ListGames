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
import RealmSwift


class TableViewController: UITableViewController, UISearchBarDelegate {
    
    var gamesArray:[Game]?
    
    let searchBar:UISearchBar = {
        let sBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        sBar.tintColor = .lightGray
        sBar.translatesAutoresizingMaskIntoConstraints = false
        return sBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        setupViews()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "game")
        tableView.rowHeight = 100
        
        let headers: HTTPHeaders = ["X-Mashape-Key":"6ZrY0Zzd9cmshElg8fzEgqJFFuGZp1fw1k4jsnkF3roQLBNEJX", "Accept":"application/json"]
        
        let parameters: Parameters = ["fields":"name,cover", "limit":"20","search":"NBA"]
        
        Alamofire.request("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?", method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseArray { [weak self](response: DataResponse<[Game]>) in
            
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.gamesArray = response.result.value
            //self.tableView.reloadData()
            
            let realm = try? Realm()
            
            try? realm?.write {
                realm?.add(strongSelf.gamesArray!, update: true)
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 5000), execute: { 
                strongSelf.tableView.reloadData()
            })
            
            /*
            
            strongSelf.gamesArray?.forEach({ (game) in
                realm.
            })
            
            
            
            if let gamesArray = strongSelf.gamesArray{
                for game in gamesArray{
                    
                    guard let gameName = game.name else {
                        break
                    }
                    
                    print("Name: \(gameName), ID: \(game.id)")
                    if var url = game.url {
                        url = "https:" + url
                        print(url)
                        game.url = url
                    }
                
                    
                    if let url = game.url{
                        Alamofire.request(url).responseData(completionHandler: { (response) in
                            if let data = response.result.value {
                                game.coverArt = UIImage(data: data)
                                self.tableView.reloadData()
                            }
                        })
                    }
                    

                }
            } */
            
        }
        
    }
    
    func setupViews(){
        
        tableView.tableHeaderView = searchBar
        
//        view.addSubview(searchBar)
//        
//        searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
//        searchBar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
//        searchBar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gamesArray = gamesArray else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "game", for: indexPath) as? TableViewCell
        if let cell = cell{
            cell.gameName.text = gamesArray[indexPath.row].name
            
            if let data = gamesArray[indexPath.row].coverArt {
                let image = UIImage(data: data as Data)
                cell.gameCoverArt.image = image
            }
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
