//
//  DetailViewController.swift
//  Resume
//
//  Created by Charles H Berlin IV on 4/25/16.
//  Copyright © 2016 Berlin. All rights reserved.
//
import UIKit

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor.resumeSecondaryColor().CGColor, UIColor.resumePrimaryColor().CGColor]
        gradientLayer.frame = self.view.bounds;
        
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
}