//
//  HomeViewController.swift
//  Watch, Play & Read
//
//  Created by Shreya Bhatia on 25/04/19.
//  Copyright © 2019 Shreya Bhatia. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "cellIdentifier"
    let titleArray = ["Trending Music", "Top Series", "Latest Movies", "Interesting Reads"]
    var clicked = Int()
    var objectArray = [Any]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.separatorColor = UIColor.clear
        loadObjectArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    
    func loadObjectArray() {
        objectArray.append(RestApiManager.musicArray)
        objectArray.append(RestApiManager.tvSeriesArray)
        objectArray.append(RestApiManager.movieArray)
        objectArray.append(RestApiManager.bookArray)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContainerTableViewCell else { return UITableViewCell()}
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        cell.objectData = (objectArray[indexPath.row] as? [ObjectModel])!
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.seeAllButton.tag = indexPath.row
        cell.seeAllButton.addTarget(self, action: #selector(seeAllClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func seeAllClicked(_ sender: UIButton) {
        clicked = sender.tag
        self.performSegue(withIdentifier: "seeAllVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeAllVC" {
            guard let targetVC = segue.destination as? SeeAllViewController else { return }
            targetVC.objectArray = objectArray[clicked] as! [ObjectModel]
            targetVC.heading = titleArray[clicked]
            targetVC.clickedItem = clicked
        }
    }
    
}

