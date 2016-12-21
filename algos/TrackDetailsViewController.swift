//
//  TrackDetailsViewController.swift
//  algos
//
//  Created by Andy Feng on 12/20/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class TrackDetailViewController: UIViewController {
    
    // MARK: Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    var trackData:Track?
    
    
    
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    @IBOutlet var backButtonView: UIView!
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet weak var downArrowImageView: UIImageView!

    
    
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::
    
    func handleBackButtonTapped(){
        
        // Dismiss this view controller
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func animateDownButton(){
//       
////        self.downArrowImageView.transform = CGAffineTransform.identity.rotated(by: CGFloat(M_PI))
//        let rotateAngle: CGFloat
//        rotateAngle = CGFloat(0)
//        
//        
//        // Code to start animation :::::::::::::::::::::::::::::::::::::::::::::::
//        self.view.setNeedsLayout()
//        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
//            // During the animation
//            self.view.layoutIfNeeded()
//            
//            
//            self.downArrowImageView.transform = CGAffineTransform.identity.rotated(by: rotateAngle)
//            
//            
//        }) { (finished) in
//            if finished {
//                
//                // do some stuff after the animation is finished
//            }
//        }
//        // :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//        
//    }
    
    
    
    
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    
    override func viewWillAppear(_ animated: Bool) {
    
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("View Did Load")
        self.trackNameLabel.text = self.trackData?.name
        
        
        // Assign event handler to backButtonView
        let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButtonTapped))
        self.backButtonView.isUserInteractionEnabled = true
        self.backButtonView.addGestureRecognizer(backButtonTap)
       
        
        
        // Initial Styling -----------
//        self.downArrowImageView.transform = CGAffineTransform.identity.rotated(by: CGFloat(-0.5))
//        self.animateDownButton()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
//        self.animateDownButton()
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Initial Styles :::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    
}

