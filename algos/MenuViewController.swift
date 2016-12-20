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

    

    @IBOutlet weak var tracksLabel: UILabel!
    
    @IBOutlet weak var tracksImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    
    
    
    
    
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::


    
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initial Styling -----------

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        if appDel.currentView == "tracks" {
            self.tracksImage.image = UIImage(named: "tracksC")
            self.profileImage.image = UIImage(named: "profile")
            self.starImage.image = UIImage(named: "star")
        } else if appDel.currentView == "profile" {
            self.tracksImage.image = UIImage(named: "tracks")
            self.profileImage.image = UIImage(named: "profileC")
            self.starImage.image = UIImage(named: "star")
        } else if appDel.currentView == "leaderboard" {
            self.tracksImage.image = UIImage(named: "tracks")
            self.profileImage.image = UIImage(named: "profile")
            self.starImage.image = UIImage(named: "starC")
        }
        
        

        
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
