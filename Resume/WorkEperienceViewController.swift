//
//  WorkEperienceViewController.swift
//  Resume
//
//  Created by Charles H Berlin IV on 4/25/16.
//  Copyright © 2016 Berlin. All rights reserved.
//
import UIKit

class WorkExperienceViewController: DetailViewController {
    @IBOutlet var workLogoView: UIImageView!
    @IBOutlet var jobTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    var job: Job?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard self.job != nil else {
            return
        }
        
        self.workLogoView.image = UIImage(named: self.job!.image)
        self.jobTitleLabel.text = self.job!.jobTitle
        self.dateLabel.text = self.job!.dateString
        
        self.descriptionTextView.text = self.job!.descriptionText + "\n\n" + self.job!.websites.joinWithSeparator("\n")
        
        self.title = self.job!.name
    }
}