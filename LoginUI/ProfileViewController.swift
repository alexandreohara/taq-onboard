//
//  ProfileViewController.swift
//  LoginUI
//
//  Created by Taqtile on 14/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        let userService = UserService()
        userService.getProfile(id: id!) { (profile) in
            DispatchQueue.main.async {
                self.displayUserData(profile)
            }
        }
    }
    
    fileprivate func displayUserData(_ profile: Profile) {
        self.nameLabel.text = profile.data!.name
        self.roleLabel.text = profile.data!.role
        self.emailLabel.text = profile.data!.email
        self.nameLabel.isHidden = false
        self.roleLabel.isHidden = false
        self.emailLabel.isHidden = false
    }
}
