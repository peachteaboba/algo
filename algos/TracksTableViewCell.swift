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
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var progressBarWidthConstraint: NSLayoutConstraint!
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
        
        self.progressBarBG.layer.cornerRadius = 3
        self.progressBarBG.backgroundColor = self.UIColorFromRGB(0xEDF0F2) // lighter grey
        
//        self.progressBarBGWidthConstraint.constant = 90
        

        
        
        
        
        
        self.progressBar.layer.cornerRadius = 3
        self.progressBar.backgroundColor = self.UIColorFromRGB(0x25C271) // green
        self.progressTextLabel.font = .systemFont(ofSize: 13)
        
        let total = self._model?.totalM
        let completed = self._model?.completedM
        
        self.progressTextLabel.textColor = self.UIColorFromRGB(0xDCDFE3) // light grey
        self.progressTextLabel.text = "\(completed!)/\(total!)"
        
        
        let percentage = CGFloat(completed!) / CGFloat(total!)
        self.progressBarWidthConstraint.constant = self.progressBarBGWidthConstraint.constant * percentage
//        print("\(self._model?.name) -----> \(self.progressBarWidthConstraint.constant) ----> \(self.progressBarBGWidthConstraint.constant) ---> percentage: \(percentage)")
        
        
        
        
        
        if percentage < 0.25 {
            self.progressBar.backgroundColor = self.UIColorFromRGB(0xFA9A2D) // orange
        } else if percentage < 0.5 {
            self.progressBar.backgroundColor = self.UIColorFromRGB(0xF7E160) // yellow
        } else if percentage < 0.75 {
            self.progressBar.backgroundColor = self.UIColorFromRGB(0x25C271) // green
        } else if percentage == 1.0 {
            self.progressBar.backgroundColor = self.UIColorFromRGB(0xFFFFFF) // white
            
            
            self.backgroundColor = self.UIColorFromRGB(0x873ae9) // purp
            self.nameLabel.textColor = self.UIColorFromRGB(0xFFFFFF) // white
            self.descriptionLabel.textColor = self.UIColorFromRGB(0x6119bc) // dark purp
            self.progressTextLabel.textColor = self.UIColorFromRGB(0x6119bc) // dark purp
//            self.progressTextLabel.font = .systemFont(ofSize: 20)
            
            self.myCoolImage.image = UIImage(named: "codeD")

        }
        
        
//        if self._model?.track == 1 {
//            self.myCoolImage.image = UIImage(named: "t1")
//        } else if self._model?.track == 2 {
//            self.myCoolImage.image = UIImage(named: "t2")
//        } else if self._model?.track == 3 {
//            self.myCoolImage.image = UIImage(named: "t3")
//        }
//        
        
        
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
