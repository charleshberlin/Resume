//
//  ProfileViewController.swift
//  Resume
//
//  Created by Charles H Berlin IV on 4/25/16.
//  Copyright © 2016 Berlin. All rights reserved.
//
import UIKit
import MessageUI

class ProfileViewController: DetailViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var profileTitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UITextView!
    
    var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard self.profile != nil else {
            return
        }
        
        self.profileImageView.image = UIImage(named: self.profile!.profileImageName)
        self.profileNameLabel.text = self.profile!.name
        self.profileTitleLabel.text = self.profile!.title
        self.descriptionLabel.text = self.profile!.mission

        self.title = "Profile"
    }
    
    @IBAction func phone(sender: UIButton) {
        if let phone = self.profile?.phone {
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(phone)")!)
        } else {
            showErrorAlert(title: "Missing Profile", message: "Phone not provided")
        }
    }
    
    @IBAction func tweet(sender: UIButton) {
        if let twitter = self.profile?.twitterUrl {
            UIApplication.sharedApplication().openURL(NSURL(string: twitter)!)
        } else {
            showErrorAlert(title: "Missing Profile", message: "Twitter profile not provided")
        }
    }
    
    @IBAction func git(sender: UIButton) {
        if let git = self.profile?.githubUrl {
            UIApplication.sharedApplication().openURL(NSURL(string: git)!)
        } else {
            showErrorAlert(title: "Missing Profile", message: "Github profile not provided")
        }
    }
    
    @IBAction func email(sender: UIButton) {
        if MFMailComposeViewController.canSendMail(), let email = self.profile?.email {
            let mailComposerVC = MFMailComposeViewController()
        
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([email])
        
            self.presentViewController(mailComposerVC, animated: true, completion: nil)
        } else {
            self.showErrorAlert(title: "Could Not Send Email", message: "Your device is not setup for email")
        }
    }
    
    func showErrorAlert(title title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Cancel) { (_) in }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
