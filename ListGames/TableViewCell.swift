//
//  TableViewCell.swift
//  ListGames
//
//  Created by Jack Ngai on 6/22/17.
//  Copyright © 2017 Jack Ngai. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let gameName:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gameCoverArt:UIImageView = {
       let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = #imageLiteral(resourceName: "nba2k18")
        return imageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(gameName)
        addSubview(gameCoverArt)
        
        gameCoverArt.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        gameCoverArt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        gameCoverArt.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        gameCoverArt.widthAnchor.constraint(equalTo: gameCoverArt.heightAnchor, multiplier: 0.72).isActive = true
        
        gameName.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        gameName.leadingAnchor.constraint(equalTo: gameCoverArt.trailingAnchor, constant: 10).isActive = true
    }
}
