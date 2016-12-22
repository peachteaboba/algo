//
//  AlgosTableViewCell.swift
//  algos
//
//  Created by Andy Feng on 12/21/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class AlgosTableViewCell: UITableViewCell, AnimateCheckMarkDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dot1: UIView!
    @IBOutlet weak var dot2: UIView!
    @IBOutlet weak var dot3: UIView!
    @IBOutlet weak var dot1WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var dot2WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var dot3WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var addBtnImage: UIImageView!
    @IBOutlet weak var addBtnHeightConstraint: NSLayoutConstraint!
  
    
    
    
    // Model -------------------------------
    private var _model:Algo?
    var model : Algo {
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
        self.titleLabel.text = self._model?.title
        self.descriptionLabel.text = self._model?.desc
        
        self.dot1.layer.cornerRadius = 3
        self.dot2.layer.cornerRadius = 3
        self.dot3.layer.cornerRadius = 3
        
        self.dot1.backgroundColor = self.UIColorFromRGB(0xDCDFE3) // light grey
        self.dot2.backgroundColor = self.UIColorFromRGB(0xDCDFE3) // light grey
        self.dot3.backgroundColor = self.UIColorFromRGB(0xDCDFE3) // light grey
        
        self.dot1WidthConstraint.constant = 6
        self.dot2WidthConstraint.constant = 6
        self.dot3WidthConstraint.constant = 6
        
        // Set a delay to execute the animation :::::::::::::::::::::::::::::::::::::::
        let when = DispatchTime.now() + 0.25 // change to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.animateDots(status: (self._model?.difficulty)!)
        }
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        
    }
    
    
    func animateDots(status: String){
        
        
        
        self.dot1WidthConstraint.constant = 10
        
        
        // Code to start animation
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
            self.layoutIfNeeded()
            
            self.dot1.layer.cornerRadius = 5
            
            if status == "1" {
                self.dot1.backgroundColor = self.UIColorFromRGB(0x25C271) // green
            } else if status == "2" {
                self.dot1.backgroundColor = self.UIColorFromRGB(0xF7E160) // yellow
            } else if status == "3" {
                self.dot1.backgroundColor = self.UIColorFromRGB(0xFA9A2D) // orange
            }

        }) { (finished) in
            if finished {
                // Code to execute after animation...
                
                
                if status != "1" {
                    self.animateDot2(status: status)
                }
                
                
                self.dot1WidthConstraint.constant = 6
                
                
                // Code to start animation ---------------------------
                self.setNeedsLayout()
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
                    self.layoutIfNeeded()
                    self.dot1.layer.cornerRadius = 3
                }) { (finished) in
                    if finished {
                        // Code to execute after animation...
                    }
                } // -------------------------------------------------
                

                
                
            }
        }
        
    }
    
    
    func animateDot2(status: String){
        
        
        self.dot2WidthConstraint.constant = 10
        
        
        // Code to start animation
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
            self.layoutIfNeeded()
            
            self.dot2.layer.cornerRadius = 5
            
            if status == "2" {
                self.dot2.backgroundColor = self.UIColorFromRGB(0xF7E160) // yellow
            } else if status == "3" {
                self.dot2.backgroundColor = self.UIColorFromRGB(0xFA9A2D) // yellow
            }
            
            
            
        }) { (finished) in
            if finished {
                // Code to execute after animation...
                
                
                if status != "2" {
                    self.animateDot3(status: status)
                }
                
                
                self.dot2WidthConstraint.constant = 6
                
                
                // Code to start animation ---------------------------
                self.setNeedsLayout()
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
                    self.layoutIfNeeded()
                    self.dot2.layer.cornerRadius = 3
                }) { (finished) in
                    if finished {
                        // Code to execute after animation...
                    }
                } // -------------------------------------------------
                
            }
        }
        
    }
    
    
    func animateDot3(status: String){
        
        
        self.dot3WidthConstraint.constant = 10
        
        
        // Code to start animation
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
            self.layoutIfNeeded()
            self.dot3.layer.cornerRadius = 5
            if status == "3" {
                self.dot3.backgroundColor = self.UIColorFromRGB(0xFA9A2D) // orange
            }

        }) { (finished) in
            if finished {
                // Code to execute after animation...

                self.dot3WidthConstraint.constant = 6
                // Code to start animation ---------------------------
                self.setNeedsLayout()
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
                    self.layoutIfNeeded()
                    
                    self.dot3.layer.cornerRadius = 3
 
                }) { (finished) in
                    if finished {
                        // Code to execute after animation...
                    }
                } // -------------------------------------------------
  
            }
        }
        
    }
    
    
    
    func AnimateCheckMark() {
        
        print("Animating check mark now!! ----> cell name ----> \(self._model?.title)")
        
        self.addBtnImage.image = UIImage(named: "check")
        self.addBtnHeightConstraint.constant = 0
        
        
        
        // Set a delay to execute the animation :::::::::::::::::::::::::::::::::::::::
        let when = DispatchTime.now() + 0.05 // change to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.performCheckAnimation()
        }
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
       
        
    }
    
    
    func performCheckAnimation(){
        
        
        self.addBtnHeightConstraint.constant = 50
        
        
        // Code to start animation ---------------------------
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
            
            
            
            
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
