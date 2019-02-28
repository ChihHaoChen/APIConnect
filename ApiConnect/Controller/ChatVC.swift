//
//  ChatVC.swift
//  ApiConnect
//
//  Created by chihhao on 2019-02-13.
//  Copyright © 2019 ChihHao. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    let chatView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        //view.layer.cornerRadius = 15
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        // Do any additional setup after loading the view.
        setupNavigationBarItems()
        slideViewSlide()
       
    }
    
    fileprivate func setupNavigationBarItems()    {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "smackLogo"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
        
        let smackButton = UIButton(type: .system)
        smackButton.setImage(#imageLiteral(resourceName: "smackBurger").withRenderingMode(.alwaysOriginal), for: .normal)
        smackButton.frame = CGRect(x: 0, y: 0, width: 24, height: 18)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: smackButton)
        smackButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    fileprivate func slideViewSlide()   {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
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
