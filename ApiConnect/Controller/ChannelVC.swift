//
//  ChannelVC.swift
//  ApiConnect
//
//  Created by chihhao on 2019-02-14.
//  Copyright © 2019 ChihHao. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let myArray: NSArray = ["First","Second","Third"]
    private let cellId = "cellId"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath)
        cell.textLabel?.text = "\(myArray[indexPath.row])"
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "avenir", size: 25)
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Smack"
        label.textColor = UIColor.white
        label.font = UIFont(name: "avenir", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let channelLabel: UILabel = {
        let label = UILabel()
        label.text = "CHANNELS"
        label.textColor = UIColor.white
        label.font = UIFont(name: "avenir", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "addChannelButton").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        return button
    }()
    
    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "profileDefault")
        return iv
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "avenir", size: 25)
        
        return button
    }()
    
    lazy var channelTabelView: UITableView = {
        let tv = UITableView()
        //tv.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tv.backgroundColor = UIColor.clear
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
        
        loginButton.addTarget(self, action: #selector(toLoginPage), for: .touchUpInside)
        setupView()
        // Do any additional setup after loading the view.
    }
    
    @objc func toLoginPage()  {
        let loginController = LoginVC()
        self.present(loginController, animated: false, completion: nil)
    }
    
    func setupView()    {
        self.view = GradientView()
        self.view.addSubview(headerLabel)
        headerLabel.setAnchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        self.view.addSubview(channelLabel)
        channelLabel.setAnchor(top: headerLabel.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        self.view.addSubview(addButton)
        addButton.setAnchor(top: headerLabel.bottomAnchor, left: nil, bottom: nil, right: self.view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 80, width: 40, height: 40)
        self.view.addSubview(iconImage)
        iconImage.setAnchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 40, paddingRight: 0, width: 80, height: 80)
        self.view.addSubview(loginButton)
        loginButton.setAnchor(top: nil, left: iconImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0)
        loginButton.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor).isActive = true
        self.view.addSubview(channelTabelView)
        channelTabelView.setAnchor(top: channelLabel.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 0, paddingRight: 80, height: 400)
       
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
