//
//  AlgoDetailsViewController.swift
//  algos
//
//  Created by Andy Feng on 12/22/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class AlgoDetailsViewController: UIViewController {
    
    
    var algoData:Algo?
    var photosArray:[Photo]?
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
   
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::
    func handleBackButtonTapped(){
        
        // Dismiss this view controller
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let appDel = UIApplication.shared.delegate as! AppDelegate
      
        
    }
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Assign event handler to backButtonView
        let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButtonTapped))
        self.backButtonView.isUserInteractionEnabled = true
        self.backButtonView.addGestureRecognizer(backButtonTap)
        

        
        // Initial Styling -----------
        self.titleLabel.text = self.algoData?.title
        
        
        print("Number of photos ----------> \(self.photosArray?.count)")

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Initial Styles :::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    
}
