//
//  ProfileViewController.swift
//  algos
//
//  Created by Andy Feng on 12/19/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ShowLoginDelegate, ShowRegisterDelegate {
    // MARK: Global Variables :::::::::::::::::::::::::::::::::::::::::::::::::
    var user:User?
    
    
    
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    @IBOutlet weak var menuButtonView: UIView!
    

    @IBOutlet weak var loginRegBGView: UIView!
    @IBOutlet weak var loginButtonLabel: UILabel!
    @IBOutlet weak var registerButtonLabel: UILabel!
    
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::
    
    
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    override func viewWillAppear(_ animated: Bool) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.currentView = "profile"
        
        user = appDel.thisUser
        
        if user != nil {
            print(user ?? "user is nil..")
            loginRegBGView.isHidden = true
            
        } else {
            print("user is not logged in..")
            loginRegBGView.isHidden = false
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        // Reveal left menu when top left corner is tapped and when swiped from the left
        if self.revealViewController() != nil {
            let menuTap = UITapGestureRecognizer(target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            self.menuButtonView.isUserInteractionEnabled = true
            self.menuButtonView.addGestureRecognizer(menuTap)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        // Assign event handler to loginButtonLabel
        let loginButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleLoginButtonTapped))
        self.loginButtonLabel.isUserInteractionEnabled = true
        self.loginButtonLabel.addGestureRecognizer(loginButtonTap)
        
        // Assign event handler to registerButtonLabel
        let registerButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleRegisterButtonTapped))
        self.registerButtonLabel.isUserInteractionEnabled = true
        self.registerButtonLabel.addGestureRecognizer(registerButtonTap)

        
        
        
        
        // Initial Styling -----------
        self.applyInitialStyles()
    
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Initial Styles :::::::::::::::::::::::::::::::::::::::::::::::::::
    func applyInitialStyles() {
//        self.loginButtonLabel.textColor = self.UIColorFromRGB(0x211f27) // dark purp
//        self.registerButtonLabel.textColor = self.UIColorFromRGB(0x211f27) // dark purp
        
//        loginButtonLabel.layer.masksToBounds = true
//        registerButtonLabel.layer.masksToBounds = true
//        
//        loginButtonLabel.layer.cornerRadius = 12
//        registerButtonLabel.layer.cornerRadius = 12
    }

    
    
    
    
    
    
    
    
    
    // MARK: Helper Functions :::::::::::::::::::::::::::::::::::::::::::::::::::
    func handleLoginButtonTapped() {
        
        // Instantiate a storyboard VC and downcasting to the specific type
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        
        // Set data
        vc.showRegisterDelegate = self

        // Presenting the vc that we instantiated
        self.present(vc, animated: true, completion: nil)
    }
    
    func handleRegisterButtonTapped() {
        
        // Instantiate a storyboard VC and downcasting to the specific type
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "regVC") as! RegViewController
        
        // Set data
        vc.showLoginDelegate = self
        
        
        // Presenting the vc that we instantiated
        self.present(vc, animated: true, completion: nil)
    }
    
    // Helper function to set colors with Hex values
    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    // MARK: Protocol Functions ::::::::::::::::::::::::::::::::::::::::::::::::::
    func ShowLoginVC() {
        // Instantiate a storyboard VC and downcasting to the specific type
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        
        // Set data
        vc.showRegisterDelegate = self
        
        // Presenting the vc that we instantiated
        self.present(vc, animated: true, completion: nil)
    }
    
    func ShowRegisterVC() {
        // Instantiate a storyboard VC and downcasting to the specific type
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "regVC") as! RegViewController
        
        // Set data
        vc.showLoginDelegate = self
        
        // Presenting the vc that we instantiated
        self.present(vc, animated: true, completion: nil)
    }
    
}

