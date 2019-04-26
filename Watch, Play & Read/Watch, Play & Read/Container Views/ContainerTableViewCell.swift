//
//  ContainerTableViewCell.swift
//  Watch, Play & Read
//
//  Created by Shreya Bhatia on 25/04/19.
//  Copyright © 2019 Shreya Bhatia. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class ContainerTableViewCell:  UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellIdentifier = "collectionCell"
    var player = AVPlayer()
    var objectData = [ObjectModel]()
    var objectArray = [Any]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadObjectArray()
        objectData = objectArray[self.tag] as! [ObjectModel]
    }
    
    func loadObjectArray() {
        objectArray.append(RestApiManager.musicArray)
        objectArray.append(RestApiManager.tvSeriesArray)
        objectArray.append(RestApiManager.movieArray)
        objectArray.append(RestApiManager.bookArray)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ContainerCollectionViewCell else {
                return UICollectionViewCell()
        }
        if self.tag == 0 {
            cell.objectName.text = objectData[indexPath.row].name
            cell.objectDescription.text = objectData[indexPath.row].artistName
        } else {
            cell.objectName.text = ""
            cell.objectDescription.text = ""
        }
        cell.backgroundImage.image = objectData[indexPath.row].image
        setUpCellShadow(cell: cell)
        return cell
    }
    
    func setUpCellShadow(cell: ContainerCollectionViewCell) {
        cell.backgroundColor = UIColor.clear
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 10.0)
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOpacity = 1.0
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 0).cgPath
        cell.contentView.backgroundColor = UIColor.clear
    }
    
}
