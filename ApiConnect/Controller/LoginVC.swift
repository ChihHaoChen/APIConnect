//
//  LoginVC.swift
//  ApiConnect
//
//  Created by chihhao on 2019-02-27.
//  Copyright © 2019 ChihHao. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.layer.cornerRadius = 5
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    
    let nameField: UITextField = {
        let nameTF = UITextField()
        nameTF.placeholder = "Name"
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        return nameTF
    }()
    
    let emailField: UITextField = {
        let TF = UITextField()
        TF.placeholder = "Email"
        TF.translatesAutoresizingMaskIntoConstraints = false
        return TF
    }()

    let passwordField: UITextField = {
        let TF = UITextField()
        TF.placeholder = "Password"
        TF.translatesAutoresizingMaskIntoConstraints = false
        return TF
    }()
    
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "smackLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let cancelImageView: UIButton = {
        let iv = UIButton()
        iv.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.addTarget(self, action: #selector(cancelLogin), for: .touchUpInside)
        return iv
    }()
    
    let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profileDefault")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.layer.cornerRadius = 5
        sc.selectedSegmentIndex = 1
        
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    @objc func cancelLogin()    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleLoginRegisterChange()    {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        // change the height of inputsContainerView
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        // change the height of nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        // change the height of emailTextField
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        // change the height of passwordTextField
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
        // change the appearing of avatarImageView
        avatarImageView.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? true : false
        
        // change the top anchor of the login-register button
        loginRegisterButtonTopAnchor?.isActive = false
        loginRegisterButtonTopAnchor = loginRegisterButton.topAnchor.constraint(equalTo: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? inputsContainerView.bottomAnchor : avatarImageView.bottomAnchor, constant: 12)
        loginRegisterButtonTopAnchor?.isActive = true
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0  {
            print("Login Button")
            loginRegisterButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
        }
        else    {
            print("Register Button")
            loginRegisterButton.addTarget(self, action: #selector(registerButtonPressed(_:)), for: .touchUpInside)
        }
        
    }
    
    @objc func registerButtonPressed(_ sender: Any) {
        guard let email = emailField.text, emailField.text != "" else {return}
        guard let password = passwordField.text, passwordField.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: password)
    }
    
    @objc func loginButtonPressed(_ sender: Any) {
        guard let email = emailField.text, emailField.text != "" else {return}
        guard let password = passwordField.text, passwordField.text != "" else {return}
        
        AuthService.instance.loginUser(email: email, password: password)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        
        setupUIView()
        // Do any additional setup after loading the view.
    }
    
    private func setupUIView()  {
        view = GradientView()
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(loginImageView)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(cancelImageView)
        view.addSubview(avatarImageView)
        
        setupInputContainerView()
        setupLoginRegisterButton()
        setupLoginImage()
        setupLoginRegisterSegmentedControl()
        setupCancelImage()
        setupAvatarImage()
    }
    
    func setupCancelImage() {
        // it needs x, y, width, height constraints
        cancelImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        cancelImageView.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -48).isActive = true
        cancelImageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        cancelImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    func setupLoginRegisterSegmentedControl()   {
        // it needs x, y, width, height constraints
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: inputsContainerView.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    func setupLoginImage()  {
        loginImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        loginImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupInputContainerView()  {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordField)
        
        //nameField needs x, y, width, height constraints
        nameField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        
        nameField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //nameSeparator needs x, y, width, height constraints
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //emailField needs x, y, width, height constraints
        emailField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor).isActive = true
        
        emailField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //emailSeparator needs x, y, width, height constraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //passowrdField needs x, y, width, height constraints
        passwordField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        
        passwordField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    var loginRegisterButtonTopAnchor: NSLayoutConstraint?
    
    func setupLoginRegisterButton() {
        //button needs x, y, widht, height constraints
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButtonTopAnchor = loginRegisterButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12)
        loginRegisterButtonTopAnchor?.isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    func setupAvatarImage() {
        avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
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

extension UIColor   {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat)    {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
