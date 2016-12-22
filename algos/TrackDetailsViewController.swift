//
//  TrackDetailsViewController.swift
//  algos
//
//  Created by Andy Feng on 12/20/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class TrackDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    var trackData:Track?
    var algosArray:[Algo]?
    
    // Image Picker Stuffs ---------------------------
    var picker = UIImagePickerController()
    var photo:UIImage?
    var checkMarkDelegate: AnimateCheckMarkDelegate?
    
    
    
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

        self.picker.delegate = self

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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // Force this action into the main queue
        DispatchQueue.main.async {
        
            print("cell tapped ----> index: \(indexPath.row) ----> isCompleted: \((self.algosArray?[indexPath.row].isCompleted)!)")
            
            // if isCompleted is false then open the camera to take photo
            if !(self.algosArray?[indexPath.row].isCompleted)! {
                
                let cell = self.algosTableView.cellForRow(at: indexPath) as! AlgosTableViewCell
                self.checkMarkDelegate = cell
                
                self.openCamera()
            }
        
        }
        
        
    }
    

    
    func openCamera(){
        print("opening camera")
        
        // Camera stuffs!
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            print("No Camera!")
            self.noCamera()
        }
        
    }
    
    // In case you're using the simulator..
    func noCamera(){
        
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Image picker delegates -------------------------------------------------------
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel camera")
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.photo = chosenImage
        
        
        print("gotcha!")
        
        // animate the checkmark 
        self.checkMarkDelegate?.AnimateCheckMark()

        
        
        
        // save the photo object to CoreData
        
        
        
        // Update CoreDate stuffs accordingly 
        
        
        // Update cached appDel stuffs accordingly
        
        
        
        
        
        
    }
    

    
    
    
    
    
    
    
    
}

