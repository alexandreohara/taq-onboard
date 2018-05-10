//
//  WelcomeViewController.swift
//  LoginUI
//
//  Created by Taqtile on 09/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var userTextField: UILabel!
    @IBOutlet weak var welcomeTitle: UILabel!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let users = ["Tiba", "Alexandre", "Gabriel", "Leandro", "Rodrigo"]
    let roles = ["Administrator", "User", "User", "User", "User"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        userTextField.text = UserDefaults.standard.string(forKey: "userName")
        tableView.alpha = 0


        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
        cell.userText.text = users[indexPath.row]
        cell.roleText.text = roles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.textView.transform = CGAffineTransform(translationX: -30, y: 0)

        }) { (_) in
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.textView.alpha = 0
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.textView.transform = self.textView.transform.translatedBy(x: 0, y: -150)
            }) {(_) in
                UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.tableView.alpha = 1
                    self.navigationController?.setNavigationBarHidden(false, animated: true)
                })
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
