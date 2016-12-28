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
    
    @IBAction func phone(_ sender: UIButton) {
        if let phone = self.profile?.phone {
            UIApplication.shared.openURL(URL(string: "tel://\(phone)")!)
        } else {
            showErrorAlert(title: "Missing Profile", message: "Phone not provided")
        }
    }
    
    @IBAction func tweet(_ sender: UIButton) {
        if let twitter = self.profile?.twitterUrl {
            UIApplication.shared.openURL(URL(string: twitter)!)
        } else {
            showErrorAlert(title: "Missing Profile", message: "Twitter profile not provided")
        }
    }
    
    @IBAction func git(_ sender: UIButton) {
        if let git = self.profile?.githubUrl {
            UIApplication.shared.openURL(URL(string: git)!)
        } else {
            showErrorAlert(title: "Missing Profile", message: "Github profile not provided")
        }
    }
    
    @IBAction func email(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail(), let email = self.profile?.email {
            let mailComposerVC = MFMailComposeViewController()
        
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([email])
        
            self.present(mailComposerVC, animated: true, completion: nil)
        } else {
            self.showErrorAlert(title: "Could Not Send Email", message: "Your device is not setup for email")
        }
    }
    
    func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (_) in }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
