//
//  AlgoDetailsViewController.swift
//  algos
//
//  Created by Andy Feng on 12/22/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class AlgoDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PhotoMenuDelegate {
    
    
    // MARK: Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var algoData:Algo?
    var algoIndex:Int?
    var photosArray:[Photo]?
    
    var photoToDelete:Photo?
    var deleteIndex:Int?
    
    var imagesArray:[UIImage] = []
    
    
    // Delegates -----------------------
    var updateTDVCForDeleteDelegate: UpdateTDVCForPhotoDeleteDelegate?
    
    
    
    
    
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
   
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var photosTableView: UITableView!
   
    
    @IBOutlet weak var menuBGView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuViewBottomConstraint: NSLayoutConstraint!
   
    
    @IBOutlet weak var deleteButtonView: UIView!
    
    
    
    
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
        return (self.photosArray?.count)!
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotosTableViewCell
        
        // Set Model
        cell.model = (self.photosArray?[indexPath.row])!
        cell.idx = indexPath.row
        
        cell.myAwesomeImageView.image = self.imagesArray[indexPath.row]
        
        cell.photoMenuDelegate = self
        
        return cell
        
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
    
    
    
    func HandlePhotoMenuButtonTapped(photoModel: Photo, index: Int) {
        
        print("dots menu button tapped!")
        self.photoToDelete = photoModel
        self.deleteIndex = index
        
        self.animateBG()
        self.animateMenu()
        
        
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
        self.photosTableView.reloadData()
        
        
        // Update data in TrackDetailsViewController
        self.updateTDVCForDeleteDelegate?.HandlePhotoDeleted(algo: self.algoData!, index: self.algoIndex!)
        
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
