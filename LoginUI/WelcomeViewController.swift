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
    
    var usersArray: [User] = []
    
    fileprivate func navigationSetup() {
        navigationItem.title = "Users"
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    fileprivate func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.text = UserDefaults.standard.string(forKey: "userName")
        tableViewSetup()
        navigationSetup()
        getUserList { (database) in
            for user in database.data! {
                DispatchQueue.main.async {
                    self.usersArray.append(user)
                    self.tableView.reloadData()
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
        cell.userText.text = usersArray[indexPath.row].name
        cell.roleText.text = usersArray[indexPath.row].role
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ProfileViewController {
            destinationVC.id = usersArray[(tableView.indexPathForSelectedRow?.row)!].id!
        }
        
    }
    
    func getUserList(completion: @escaping(Database) -> ()) {
        let baseUrl = "https://tq-template-server-sample.herokuapp.com/users"
        let queryItemPage = URLQueryItem(name: "pagination", value: "{\"page\": 1 , \"window\": 10}")

        guard var url = URLComponents(string: baseUrl) else {return}
        url.queryItems = [queryItemPage]
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            var responseDatabase: Database
            if let requestError = error {
                print(requestError)
                return
            }
            
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(Database.self, from: data)

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
    
    fileprivate func welcomeAnimation() {
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
    
    override func viewDidAppear(_ animated: Bool) {
        welcomeAnimation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
