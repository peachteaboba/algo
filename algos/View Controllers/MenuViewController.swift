//
//  MenuViewController.swift
//  algos
//
//  Created by Andy Feng on 12/19/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    
    
    // MARK: Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   
    
    
    
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    @IBOutlet var menuTableView: UITableView!
    

    @IBOutlet weak var tracksLabel: UILabel!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var leaderboardLabel: UILabel!
    
    @IBOutlet weak var tracksImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    
    
    
    @IBOutlet weak var loginViewBG: UIView!
    @IBOutlet weak var loginLabel: UILabel!
    
    
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::


    
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        if appDel.currentView == "tracks" {

            // Text
            self.tracksLabel.textColor = self.UIColorFromRGB(0xFFFFFF) // white
            self.profileLabel.textColor = self.UIColorFromRGB(0x868F91) // grey
            self.leaderboardLabel.textColor = self.UIColorFromRGB(0x868F91) // grey
            
        } else if appDel.currentView == "profile" {

            // Text
            self.tracksLabel.textColor = self.UIColorFromRGB(0x868F91) // white
            self.profileLabel.textColor = self.UIColorFromRGB(0xFFFFFF) // grey
            self.leaderboardLabel.textColor = self.UIColorFromRGB(0x868F91) // grey
            
        } else if appDel.currentView == "leaderboard" {

            // Text
            self.tracksLabel.textColor = self.UIColorFromRGB(0x868F91) // white
            self.profileLabel.textColor = self.UIColorFromRGB(0x868F91) // grey
            self.leaderboardLabel.textColor = self.UIColorFromRGB(0xFFFFFF) // grey
            
        }
        
        self.menuTableView.backgroundColor = self.UIColorFromRGB(0x211f27) // dark purp
        
        // Login View Styles
        self.loginViewBG.layer.cornerRadius = 5
        self.loginViewBG.backgroundColor = self.UIColorFromRGB(0x19191f) // dark dark purp
        self.loginLabel.textColor = self.UIColorFromRGB(0x211f27) // dark purp
        

        
        
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: Initial Styles :::::::::::::::::::::::::::::::::::::::::::::::::::

    
    
    
    
    
    // Helper function to set colors with Hex values
    func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}
