//
//  AlgoDetailsViewController.swift
//  algos
//
//  Created by Andy Feng on 12/22/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit
import CoreData

class AlgoDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PhotoMenuDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageZoomDelegate {
    
    
    // MARK: Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var algoData:Algo?
    var algoIndex:Int?
    var trackData:Track?
    
    var photosArray:[Photo]?
    
    var photoToDelete:Photo?
    var deleteIndex:Int?
    
    var imagesArray:[UIImage] = []
    
    
    var picker = UIImagePickerController()
    var photo:UIImage?
    
    
    // Delegates -----------------------
    var updateTDVCForDeleteDelegate: UpdateTDVCForPhotoDeleteDelegate?
    var updateTDVCForAddDelegate: UpdateTDVCForPhotoAddDelegate?
    
    
    
    
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
   
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var addButtonView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var photosTableView: UITableView!
   
    
    @IBOutlet weak var menuBGView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuViewBottomConstraint: NSLayoutConstraint!
   
    
    @IBOutlet weak var deleteButtonView: UIView!
    
    
    @IBOutlet weak var bugLabel: UILabel!
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::
    func handleBackButtonTapped(){
        
        // Dismiss this view controller
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func handleAddButtonTapped(){
        
        self.openCamera()
        
    }
    
    
    // MARK: Camera Methods :::::::::::::::::::::::::::::::::::::::::::::::::::
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
        
        self.imagesArray.insert(chosenImage, at: 0)
        
        self.photo = chosenImage

        // Save the photo object to CoreData and adjust cache accordingly
        self.saveImage()
        
    }

    
    func saveImage(){
        if self.photo != nil {
            
            // Create Photo object :::::::::::::::::::::::::::::::
            let photo = NSEntityDescription.insertNewObject(forEntityName: "Photo",  into: context) as! Photo
            
            if let imageToSave = self.photo {
                let data = UIImagePNGRepresentation(imageToSave)
                photo.image = data as NSData?
            }
            
            photo.comment = ""
            photo.timestamp = NSDate()
            
            photo.track = (self.algoData?.track)!
            photo.algoPlace = (self.algoData?.place)!
            // ::::::::::::::::::::::::::::::::::::::::::::::::::::
         

            // Update algos and tracks CoreDate stuffs accordingly ++++++++++++++++
            self.algoData?.numPhotos += 1

            self.photosArray?.insert(photo, at: 0)
            self.photosTableView.reloadData()
            self.updateTDVCForAddDelegate?.HandlePhotoAdded(algo: self.algoData!, index: self.algoIndex!)
            
            
            // Save CodeData context ++++++++++++++++++++++++++++++++++++++++++++++
            if self.context.hasChanges {
                do {
                    try self.context.save()
                    print("Success")
                
                } catch {
                    print("\(error)")
                }
            }
            
        } else {
            print("Photo is nil...")
        }
    }
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    override func viewWillAppear(_ animated: Bool) {
        
        // Table view margins
        if self.photosArray?.count == 2 {
            self.photosTableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 300.0, 0.0)
        } else if self.photosArray?.count == 3 {
            self.photosTableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 250.0, 0.0)
        } else {
            self.photosTableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 200.0, 0.0)
        }
        
        self.photosTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.picker.delegate = self
        
        // Assign event handler to backButtonView
        let backButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackButtonTapped))
        self.backButtonView.isUserInteractionEnabled = true
        self.backButtonView.addGestureRecognizer(backButtonTap)
        
        // Assign event handler to addButtonView
        let addButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleAddButtonTapped))
        self.addButtonView.isUserInteractionEnabled = true
        self.addButtonView.addGestureRecognizer(addButtonTap)

        
        // Initial Styling -----------
        self.titleLabel.text = self.algoData?.title
        self.bugLabel.textColor = self.UIColorFromRGB(0x6e21d0) // dark purple
        self.bugLabel.text = self.algoData?.hint
        
//        print("Number of photos ----------> \(self.photosArray?.count)")

        
        // Menu View Initial Styles
        self.menuViewInitialStyles()
        
        
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Initial Styles :::::::::::::::::::::::::::::::::::::::::::::::::::
    func menuViewInitialStyles() {
        
        
        // Assign event handler to menuBGView
        let menuBGViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleMenuBGViewTapped))
        self.menuBGView.isUserInteractionEnabled = true
        self.menuBGView.addGestureRecognizer(menuBGViewTap)
        
        
        // Assign event handler to deleteButtonView
        let deleteButtonViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleDeleteButtonViewTapped))
        self.deleteButtonView.isUserInteractionEnabled = true
        self.deleteButtonView.addGestureRecognizer(deleteButtonViewTap)
        
        
        
        self.menuViewHeightConstraint.constant = 200
        self.menuViewBottomConstraint.constant = -200
        
        self.menuView.isHidden = true
        self.menuView.backgroundColor = self.UIColorFromRGB(0xffffff) // white
        
        self.menuBGView.isHidden = true
        self.menuBGView.alpha = 0
        
        self.deleteButtonView.layer.cornerRadius = self.deleteButtonView.frame.height / 2
    }
    
    
    
    // MARK: Collection View Methods :::::::::::::::::::::::::::::::::::::::::::::::::::
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.photosArray?.count)! + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return UITableViewAutomaticDimension
        } else {
//            return self.view.frame.width + 50
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlgoHeaderCell", for: indexPath) as! AlgoHeaderTableViewCell
            
            cell.model = self.algoData!
            
            
            // Set dynamic cell height
            self.photosTableView.estimatedRowHeight = self.view.frame.width
            self.photosTableView.rowHeight = UITableViewAutomaticDimension
            
            return cell
            
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotosTableViewCell
            
            let cellIndex = indexPath.row - 1
            
            
            // Set Model
            cell.model = (self.photosArray?[cellIndex])!
            cell.myAwesomeImageView.image = self.imagesArray[cellIndex]
            cell.myAwesomeImageView.layer.masksToBounds = true
            cell.myAwesomeImageView.layer.cornerRadius = 4
            cell.photoMenuDelegate = self
            cell.imageZoomDelegate = self
            
            
            // Set dynamic cell height
            self.photosTableView.estimatedRowHeight = self.view.frame.width
            self.photosTableView.rowHeight = UITableViewAutomaticDimension
            
            
            return cell
        }
    }
    
    
    // MARK: Protocol Methods ---------------------------
    func HandleImageTapped(photoModel: Photo, cell: PhotosTableViewCell) {
        print("image tapped")
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    func handleMenuBGViewTapped(){
        
        self.animateBG()
        self.animateMenu()
        
    }
    
    
    
    func animateMenu(){
        
        
        if self.menuViewBottomConstraint.constant == -200{
            self.menuView.isHidden = false
            self.menuViewBottomConstraint.constant = -70
        } else {
            self.menuViewBottomConstraint.constant = -200
//            self.menuView.isHidden = true
        }
        

        // Code to start animation
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
            self.view.layoutIfNeeded()
 
        }) { (finished) in
            if finished {
                // Code to execute after animation...
            }
        }
    }
    

    func animateBG(){
        
        let alph:CGFloat?
        
        if self.menuBGView.isHidden == true {
            self.menuBGView.isHidden = false
            alph = 0.8
        } else {
            self.menuBGView.isHidden = true
            alph = 0.0
        }
        
        
        
        // Code to start animation
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
            self.view.layoutIfNeeded()
            
            self.menuBGView.alpha = alph!
            
        }) { (finished) in
            if finished {
                // Code to execute after animation...
            }
        }
        
        
    }
    
    
    
    func HandlePhotoMenuButtonTapped(photoModel: Photo, cell: PhotosTableViewCell) {
        
        print("dots menu button tapped!")
        self.photoToDelete = photoModel
        self.deleteIndex = ((self.photosTableView.indexPath(for: cell)?.row)! - 1) as Int
        self.animateBG()
        self.animateMenu()
        
        print("delete index ----> \(self.deleteIndex)")
        
    }
    
    
    
    func handleDeleteButtonViewTapped(){
        
        print("gonna delete some stuff up in hurr! ..")
        
        // Dismiss menu BG --------------------------------------------
        self.animateBG()
        self.animateMenu()
        
        // Delete the photo from coreData -----------------------------
        context.delete(self.photoToDelete!)
        self.algoData?.numPhotos -= 1

        if self.context.hasChanges {
            do {
                try self.context.save()
                print("Successfully deleted photo object from CoreData")
                
            } catch {
                print("\(error)")
            }
        }
        
        // Delete the photo from local cache -----------------------------
        self.photosArray?.remove(at: self.deleteIndex!)
        self.imagesArray.remove(at: self.deleteIndex!)
        print("removing  ----> \(self.deleteIndex)")
        self.photosTableView.reloadData()
        
        
        // Update data in TrackDetailsViewController
        self.updateTDVCForDeleteDelegate?.HandlePhotoDeleted(algo: self.algoData!, index: self.deleteIndex!)
        
        if self.algoData?.numPhotos == 0 {
            // Return to Track Details VC
            self.dismiss(animated: true, completion: nil)
        }
        
        
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
