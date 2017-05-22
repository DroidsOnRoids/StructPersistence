//
//  DribbbleTableViewResponder.swift
//  SquakersShots
//
//  Created by Michal Pyrka on 19/05/2017.
//  Copyright © 2017 Michal Pyrka. All rights reserved.
//

import UIKit
import Haneke

final class DribbbleTableViewResponder: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var shots = [Shot]() {
        didSet {
            provider.save(shots: shots)
        }
    }
    let provider = ShotsProvider(persistenceType: .keyedArchiver)
    
    override init() {
        shots = provider.loadShots()
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shots.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 311.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DribbbleCell.self)) as! DribbbleCell
        cell.shotView.setupLayout()
        let shot = shots[indexPath.row]
        cell.viewsLabel.text = "\(shot.views)"
        cell.heartsLabel.text = "\(shot.likes)"
        cell.bucketsLabel.text = "\(shot.buckets)"
        cell.commentsLabel.text = "\(shot.comments)"
        if let url = URL(string: shots[indexPath.row].url) {
            cell.shotView.imageView.hnk_setImageFromURL(url, format: Format(name: "original"))
        }
        cell.backgroundColor = .clear
        
        return cell
    }
}
