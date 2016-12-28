//
//  Model.swift
//  Resume
//
//  Created by Charles H Berlin IV on 4/26/16.
//  Copyright © 2016 Berlin. All rights reserved.
//

import Foundation

struct Resume {
    let profile: Profile
    let education: [College]
    let sideProjects: [SideProject]
    let experience: [Job]
    
    init?(path: String) {
        guard let dict: NSDictionary = NSDictionary(contentsOfFile: path) else {
            return nil
        }
        
        guard let profileDict = dict["profile"] as? [String:AnyObject],
            let profile = Profile(profileDict: profileDict as NSDictionary) else {
                return nil
        }
        
        self.profile = profile

        var colleges:[College] = []
        guard let educationArray = dict["colleges"] as? [[String:AnyObject]] else {
                return nil
        }
        
        for collegeDict in educationArray {
            if let college = College(collegeDict: collegeDict as NSDictionary) {
                colleges.append(college)
            }
        }
        
        self.education = colleges
        
        var projects:[SideProject] = []
        guard let projectsArray = dict["side_projects"] as? [[String:AnyObject]] else {
            return nil
        }
        
        for projectDict in projectsArray {
            if let project = SideProject(projectDict: projectDict as NSDictionary) {
                projects.append(project)
            }
        }
        
        self.sideProjects = projects
        
        var jobs:[Job] = []
        guard let jobsArray = dict["experience"] as? [[String:AnyObject]] else {
            return nil
        }
        
        for jobDict in jobsArray {
            if let job = Job(jobDict: jobDict as NSDictionary) {
                jobs.append(job)
            }
        }
        
        self.experience = jobs
    }
    
}

struct Profile {
    let largeImageName: String
    let overImageName: String
    let profileImageName: String
    let githubUrl: String?
    let twitterUrl: String?
    let phone: String?
    let email: String?
    let mission: String
    let title: String
    let name: String
    
    init?(profileDict: NSDictionary) {
        guard let largeImageName = profileDict["large_image"] as? String,
            let overImageName = profileDict["over_image"] as? String,
            let profileImageName = profileDict["profile_image"] as? String,
            let mission = profileDict["mission"] as? String,
            let title = profileDict["title"] as? String,
            let name = profileDict["name"] as? String else {
                
                return nil
        }
        
        self.largeImageName = largeImageName
        self.overImageName = overImageName
        self.profileImageName = profileImageName
        self.mission = mission
        self.title = title
        self.name = name
    
        self.githubUrl = profileDict["github"] as? String
        self.phone = profileDict["phone"] as? String
        self.twitterUrl = profileDict["twitter"] as? String
        self.email = profileDict["email"] as? String
    }
}

struct College {
    let image: String
    let name: String
    let shortName: String
    let major: String
    let graduation: String
    let gpa: String
    
    init?(collegeDict: NSDictionary) {
        guard let image = collegeDict["image"] as? String,
            let name = collegeDict["name"] as? String,
            let shortName = collegeDict["short_name"] as? String,
            let major = collegeDict["major"] as? String,
            let graduation = collegeDict["graduation"] as? String,
            let gpa = collegeDict["gpa"] as? String else {
                
                return nil
        }
        
        self.image = image
        self.name = name
        self.shortName = shortName
        self.major = major
        self.graduation = graduation
        self.gpa = gpa
    }
}

struct SideProject {
    let image: String
    let name: String
    let dateString: String
    let descriptionText: String
    let websites: [String]
    
    init?(projectDict: NSDictionary) {
        guard let image = projectDict["image"] as? String,
            let name = projectDict["name"] as? String,
            let dateString = projectDict["date_string"] as? String,
            let descriptionText = projectDict["description_text"] as? String,
            let sitesArray = projectDict["websites"] as? [String] else {
                
                return nil
        }
        
        self.image = image
        self.name = name
        self.dateString = dateString
        self.descriptionText = descriptionText
        self.websites = sitesArray
    }
}

struct Job {
    let image: String
    let name: String
    let jobTitle: String
    let dateString: String
    let descriptionText: String
    let websites: [String]
    
    init?(jobDict: NSDictionary) {
        guard let image = jobDict["image"] as? String,
            let name = jobDict["name"] as? String,
            let dateString = jobDict["date_string"] as? String,
            let descriptionText = jobDict["description_text"] as? String,
            let jobTitle = jobDict["job_title"] as? String,
            let sitesArray = jobDict["websites"] as? [String] else {
                
                return nil
        }
        
        self.image = image
        self.name = name
        self.dateString = dateString
        self.descriptionText = descriptionText
        self.websites = sitesArray
        self.jobTitle = jobTitle
    }
}
