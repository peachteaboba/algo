//
//  CustomTracksTableViewCell.swift
//  algos
//
//  Created by Andy Feng on 12/19/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class TracksTableViewCell: UITableViewCell {

    @IBOutlet weak var myCoolImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var progressBarBG: UIView!
    @IBOutlet weak var progressBarBGWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressBarBGHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var progressBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressTextLabel: UILabel!

    func setInit(){
        
        
//        print("hi")
        
        if self.frame.width < 330 {
            self.progressBarBGWidthConstraint.constant = self.frame.width * 0.25
        } else {
            self.progressBarBGWidthConstraint.constant = self.frame.width * 0.3
        }
        
        self.progressBarWidthConstraint.constant = 0
        
//        print("\(self.progressBarBGWidthConstraint.constant)")
        
        
    }
  
    
    // Model -------------------------------
    private var _model:Track?
    var model : Track {
        set{
            _model = newValue
            
            // call function to set some controls
            setControls()
        }
        get {
            
            return _model!
        }
    }
    
    // Helper functions -----------------------
    func setControls(){
        
        self.backgroundColor = self.UIColorFromRGB(0xFFFFFF) // white
        
        self.myCoolImage.image = UIImage(named: "code")
        
        self.nameLabel.text = self._model?.name
        self.nameLabel.textColor = self.UIColorFromRGB(0x333333)
        
        self.descriptionLabel.text = self._model?.desc
        self.descriptionLabel.textColor = self.UIColorFromRGB(0xDCDFE3) // light grey
        
        
        // Progress Bar BG
        self.progressBarBGHeightConstraint.constant = 4
        self.progressBarBG.layer.cornerRadius = self.progressBarBGHeightConstraint.constant / 2
        self.progressBarBG.backgroundColor = self.UIColorFromRGB(0xEDF0F2) // lighter grey
        

        
        
        
        // Progress Bar
        self.progressBarHeightConstraint.constant = 6
        self.progressBar.layer.cornerRadius = self.progressBarHeightConstraint.constant / 2
        self.progressBar.backgroundColor = self.UIColorFromRGB(0x25C271) // green
        self.progressTextLabel.font = .systemFont(ofSize: 13)
        
        
        
        

        
        let total = self._model?.totalM
        let completed = self._model?.completedM
        
        self.progressTextLabel.textColor = self.UIColorFromRGB(0xD4D6D9) // light grey
        self.progressTextLabel.text = "\(completed!)/\(total!)"
        
        
        let percentage = CGFloat(completed!) / CGFloat(total!)

        
        if percentage <= 0.4 {
            self.progressBar.backgroundColor = self.UIColorFromRGB(0xFA9A2D) // orange
        } else if percentage <= 0.6 {
            self.progressBar.backgroundColor = self.UIColorFromRGB(0xF7E160) // yellow
        } else if percentage >= 1.0 {
            self.progressBar.backgroundColor = self.UIColorFromRGB(0x25C271) // green
            
            
            self.backgroundColor = self.UIColorFromRGB(0x873ae9) // purp
            self.nameLabel.textColor = self.UIColorFromRGB(0xFFFFFF) // white
            self.descriptionLabel.textColor = self.UIColorFromRGB(0x6119bc) // dark purp
            self.progressTextLabel.textColor = self.UIColorFromRGB(0xffffff) // white
            
            self.myCoolImage.image = UIImage(named: "codeD")

        }
        
        // Set a delay to execute the animation :::::::::::::::::::::::::::::::::::::::
        let when = DispatchTime.now() + 0.05 // change to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.animatePercentage(p: percentage)
        }
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        
    }
    
    
    func animatePercentage(p: CGFloat){
        
        self.progressBarWidthConstraint.constant = self.progressBarBGWidthConstraint.constant * p
        
        
        
        // Code to start animation ---------------------------
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
            self.layoutIfNeeded()
      
        }) { (finished) in
            if finished {
                // Code to execute after animation...
            }
        } // -------------------------------------------------
        
        
        
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

}
