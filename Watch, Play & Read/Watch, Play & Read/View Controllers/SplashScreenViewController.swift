//
//  SplashScreenViewController.swift
//  Watch, Play & Read
//
//  Created by Shreya Bhatia on 25/04/19.
//  Copyright © 2019 Shreya Bhatia. All rights reserved.
//

import Foundation
import UIKit

class SplashScreenViewController: UIViewController, ActivityIndicatorProtocol {
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let restApiInstance = RestApiManager.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        restApiInstance.delegate = self
        startLoading()
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.style = UIActivityIndicatorView.Style.gray
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.restApiInstance.loadAllData()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

internal protocol ActivityIndicatorProtocol {
    func startLoading()
    func stopLoading()
}

