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
    
    fileprivate func displayUserData(_ profile: Profile) {
        self.nameLabel.text = profile.data!.name
        self.roleLabel.text = profile.data!.role
        self.emailLabel.text = profile.data!.email
        self.nameLabel.isHidden = false
        self.roleLabel.isHidden = false
        self.emailLabel.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        navigationItem.largeTitleDisplayMode = .never
        getUserProfile { (profile) in
            DispatchQueue.main.async {
                self.displayUserData(profile)
            }
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUserProfile(completion: @escaping(Profile) -> ()) {
        let baseUrl = "https://tq-template-server-sample.herokuapp.com/users/" + String(id!)
        
        guard let url = URL(string: baseUrl) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            var responseDatabase: Profile
            if let requestError = error {
                print(requestError)
                return
            }
            
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(Profile.self, from: data)
                
                if response.data != nil {
                    responseDatabase = response
                    completion(responseDatabase)
                }
                
            } catch let err {
                print(err)
                return
            }
        }
        task.resume()
    }
}
