//
//  SeeAllViewController.swift
//  Watch, Play & Read
//
//  Created by Shreya Bhatia on 26/04/19.
//  Copyright © 2019 Shreya Bhatia. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class SeeAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "seeCellIdentifier"
    var player = AVPlayer()
    var objectArray = [ObjectModel]()
    var heading = ""
    var clickedItem = Int()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = heading
        self.tableView.separatorColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SeeAllTableViewCell else { return UITableViewCell()}
        
        cell.selectionStyle = .none
        cell.backgroundImageView.image = objectArray[indexPath.row].image
        cell.nameLabel.text = objectArray[indexPath.row].name
        cell.descriptionLabel.text = objectArray[indexPath.row].artistName
        if clickedItem != 0 {
            cell.nameLabel.textColor = UIColor.white
            cell.descriptionLabel.textColor = UIColor.white
            cell.playButton.isHidden = true
        } else {
            cell.nameLabel.textColor = UIColor.black
            cell.descriptionLabel.textColor = UIColor.black
            cell.playButton.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if clickedItem == 3 {
            return 400
        } else {
            return 350
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if clickedItem == 0 {
            let object = objectArray[indexPath.row]
            let playerItem = AVPlayerItem(url: URL(string: (object.url)!)!)
            player = AVPlayer(playerItem: playerItem)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
            super.view.layer.addSublayer(playerLayer)
            player.play()
        }
    }
    
}
