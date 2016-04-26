//
//  EducationViewController.swift
//  Resume
//
//  Created by Charles H Berlin IV on 4/25/16.
//  Copyright © 2016 Berlin. All rights reserved.
//


import UIKit

class EducationViewController: DetailViewController {
    @IBOutlet var collegeImageView: UIImageView!
    @IBOutlet var gpaLabel: UILabel!
    @IBOutlet var majorLabel: UILabel!
    @IBOutlet var graduationLabel: UILabel!
    
    var college: College?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard self.college != nil else {
            return
        }
        
        self.collegeImageView.image = UIImage(named: self.college!.image)
        self.gpaLabel.text = self.college!.gpa
        self.majorLabel.text = self.college!.major
        self.graduationLabel.text = self.college!.graduation
        self.title = self.college!.shortName
    }
}