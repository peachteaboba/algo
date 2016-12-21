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
    var algosArray:[Algo]?
    
    
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    @IBOutlet var backButtonView: UIView!
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet weak var downArrowImageView: UIImageView!

    
    
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::
    
    func handleBackButtonTapped(){
        
        // Dismiss this view controller
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
   
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Go get algo data from appDel
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let allAlgosArr = appDel.algosArray
        for algo in allAlgosArr! {
            if(algo.track == self.trackData?.track){
                self.algosArray?.append(algo)
                print("+++++++++++++ \(algo.title!) ++++++++++++++")
            }
        }

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.applyInitialStyles()
        
    }
    
    
    
    
    // MARK: Initial Styles :::::::::::::::::::::::::::::::::::::::::::::::::::
    func applyInitialStyles(){
        
        
    }
    
    
}

