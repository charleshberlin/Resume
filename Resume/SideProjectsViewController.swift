//
//  SideProjectsViewController.swift
//  Resume
//
//  Created by Charles H Berlin IV on 4/25/16.
//  Copyright © 2016 Berlin. All rights reserved.
//
import UIKit

class SideProjectsViewController: DetailViewController {
    @IBOutlet var projectImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    var sideProject: SideProject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard self.sideProject != nil else {
            return
        }
        
        self.projectImageView.image = UIImage(named: self.sideProject!.image)
        self.dateLabel.text = self.sideProject!.dateString
        
        self.descriptionTextView.text = self.sideProject!.descriptionText + "\n\n" + self.sideProject!.websites.joined(separator: "\n")
        
        self.title = self.sideProject!.name
    }
}
