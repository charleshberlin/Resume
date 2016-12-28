//
//  RootViewController.swift
//  Resume
//
//  Created by Charles H Berlin IV on 4/25/16.
//  Copyright © 2016 Berlin. All rights reserved.
//

import UIKit
import MessageUI

class RootViewController: UIViewController, MFMailComposeViewControllerDelegate, UIScrollViewDelegate  {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var imageBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var tableViewHeader: UIView!
    
    @IBOutlet var overImageView: UIImageView!
    
    fileprivate var backgroundImage: UIImage?
    fileprivate var visualEffectView: UIVisualEffectView?
    fileprivate var originalBottomConstraint: CGFloat = 0.0
    
    fileprivate var resume: Resume!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resume = Resume(path: Bundle.main.path(forResource: "resume-data", ofType: "plist")!)!
        self.view.backgroundColor = UIColor.resumePrimaryColor()
        
        self.backgroundImage = UIImage(named: resume.profile.largeImageName)
        self.overImageView.layer.cornerRadius = self.overImageView.frame.size.height/2
        
        originalBottomConstraint = self.imageBottomConstraint.constant
        
        updateBlur()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func sendResume(_ sender: UIButton) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        if let filePath = Bundle.main.path(forResource: "Charles Berlin Resume", ofType: "pdf") {
            
            if let fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
                mailComposerVC.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "Charles Berlin Resume.pdf")
            }
        }
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device is not setup for email", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (_) in }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateBlur()
    }
    
    fileprivate func updateBlur() {
        self.imageBottomConstraint.constant = originalBottomConstraint + self.tableView.contentOffset.y / 4
        
        let blurOffset:CGFloat = 20
        let blurRadius = max(0, self.tableView.contentOffset.y/4+blurOffset)
        
        if blurRadius > 0 {
            self.backgroundImageView.image = UIImageEffects.imageByApplyingBlur(to: self.backgroundImage, withRadius: blurRadius, tintColor: nil, saturationDeltaFactor: 1.0, maskImage: nil)
        } else {
            self.backgroundImageView.image = self.backgroundImage
        }
        self.tableViewHeader.alpha = blurRadius / blurOffset
    }
}

//MARK: UITableViewDelegate
extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if let profileController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profile") as? ProfileViewController {
                profileController.profile = resume.profile
                self.navigationController?.pushViewController(profileController, animated: true)
            }
        case 1:
            if let educationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "education") as? EducationViewController {
                educationController.college = resume.education[indexPath.row]
                self.navigationController?.pushViewController(educationController, animated: true)
            }
        case 2:
            if let workController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "work_experience") as? WorkExperienceViewController {
                workController.job = resume.experience[indexPath.row]
                self.navigationController?.pushViewController(workController, animated: true)
            }
        default:
            if let sideProjectController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "side_projects") as? SideProjectsViewController {
                sideProjectController.sideProject = resume.sideProjects[indexPath.row]
                self.navigationController?.pushViewController(sideProjectController, animated: true)
            }
        }
        
        self.tableView .deselectRow(at: indexPath, animated: true)
    }
}

//MARK: UITableViewDataSource
extension RootViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:     return 1
            case 1:     return resume.education.count
            case 2:     return resume.experience.count
            default:    return resume.sideProjects.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.font = UIFont(descriptor: UIFontDescriptor(fontAttributes:[UIFontDescriptorFamilyAttribute:"Didot", UIFontDescriptorTraitsAttribute:[UIFontWeightTrait:UIFontWeightRegular]]), size: 14.0)
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor(red: 0.19, green: 0.29, blue: 0.10, alpha: 1.0)
        cell.textLabel?.textColor = UIColor.white
        
        switch indexPath.section {
            case 0:
                cell.textLabel?.text = "Display \(resume.profile.name)'s Profile"
            case 1:
                cell.textLabel?.text = resume.education[indexPath.row].name
            case 2:
                cell.textLabel?.text = resume.experience[indexPath.row].name
            default:
                cell.textLabel?.text = resume.sideProjects[indexPath.row].name
        }
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0,y: 0, width: tableView.frame.size.width, height: 40))
        
        let headerText = UILabel(frame: CGRect(x: 16,y: 0, width: tableView.frame.size.width - 32, height: 40))
        headerText.textColor = UIColor.white
        headerText.font = UIFont(descriptor: UIFontDescriptor(fontAttributes:[UIFontDescriptorFamilyAttribute:"Didot", UIFontDescriptorTraitsAttribute:[UIFontWeightTrait:UIFontWeightBold]]), size: 18.0)
        
        switch section {
        case 0:
            headerText.text = "Profile"
        case 1:
            headerText.text = "Education"
        case 2:
            headerText.text = "Professional Experience"
        default:
            headerText.text = "Side Projects"
        }
        
        header.addSubview(headerText)
        header.backgroundColor = UIColor(red: 0.16, green: 0.60, blue: 0.04, alpha: 1.0)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
