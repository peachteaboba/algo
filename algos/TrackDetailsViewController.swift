//
//  TrackDetailsViewController.swift
//  algos
//
//  Created by Andy Feng on 12/20/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class TrackDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    var trackData:Track?
    var algosArray:[Algo]?
    
    
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    @IBOutlet var backButtonView: UIView!
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet weak var downArrowImageView: UIImageView!

    @IBOutlet weak var algosTableView: UITableView!
    
    
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::
    
    func handleBackButtonTapped(){
        // Dismiss this view controller
        self.dismiss(animated: true, completion: nil)
    }
    

    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    
    override func viewWillAppear(_ animated: Bool) {
        
        

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Assign event handler to backButtonView
        let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButtonTapped))
        self.backButtonView.isUserInteractionEnabled = true
        self.backButtonView.addGestureRecognizer(backButtonTap)
       
        
        
        // Initial Styling -----------
        self.applyInitialStyles()
        
    }
    
    
    
    
    // MARK: Initial Styles :::::::::::::::::::::::::::::::::::::::::::::::::::
    func applyInitialStyles(){
        
        self.trackNameLabel.text = self.trackData?.name
        
        // Table view margins
        self.algosTableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 40.0, 0.0)
        
    }
    
    
    
    
    
    
    
    
    // MARK: Table View Protocol Methods :::::::::::::::::::::::::::::::::::::::::::::::::::
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let algoArr = self.algosArray {
            return algoArr.count
        } else {
            print("errrrrrrrrrrr")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "algoCell", for: indexPath) as! AlgosTableViewCell
        
        // Set the model
        cell.model = (self.algosArray?[indexPath.row])!
        
        
        
        
        
        // Set dynamic cell height
        self.algosTableView.estimatedRowHeight = 80
        self.algosTableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
}

