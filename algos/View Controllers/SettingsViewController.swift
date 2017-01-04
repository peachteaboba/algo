//
//  SettingsViewController.swift
//  algos
//
//  Created by Andy Feng on 12/30/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
  
    
    @IBOutlet weak var cancelBGView: UIView!
    @IBOutlet var settingsTableView: UITableView!

    
    @IBOutlet weak var saveToCameraRollSwitch: UISwitch!
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::
    @IBAction func handleSaveToCameraRollSwitchToggled(_ sender: UISwitch) {
        
        print(sender.isOn)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        
    }
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Assign event handler to settingsBGView
        let cancelBGViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleCancelBGViewTapped))
        self.cancelBGView.isUserInteractionEnabled = true
        self.cancelBGView.addGestureRecognizer(cancelBGViewTap)
        
        
        // Initial Styling -----------
        self.cancelBGView.backgroundColor = self.UIColorFromRGB(0x211f27) // dark purp
        
        self.settingsTableView.backgroundColor = self.UIColorFromRGB(0xF7F9FA) // light light grey

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Initial Styles :::::::::::::::::::::::::::::::::::::::::::::::::::
    func handleCancelBGViewTapped(){
        dismiss(animated: true, completion: nil)
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
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 60
        }
    }
    

    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            
            let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
            returnedView.backgroundColor = .lightGray
            
            let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 25))
            label.text = "Photos"
            label.textColor = .black
            returnedView.addSubview(label)
            
            return returnedView
        } else {
            let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 0))
            return returnedView
        }
        
        
        
    }
    
    

    
    
    
    
  
    
}
