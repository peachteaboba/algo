//
//  TrackDetailsViewController.swift
//  algos
//
//  Created by Andy Feng on 12/20/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit
import CoreData

class TrackDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UpdateTDVCForPhotoDeleteDelegate, UpdateTDVCForPhotoAddDelegate {
    
    // MARK: Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var trackData:Track?
    var algosArray:[Algo]?
    var algoPlace:Int16?
    
    
    var algoTargeted:Algo?
    var cellTargeted: AlgosTableViewCell?
    
    
    
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
        
        let _ = CustomPhotoAlbum.sharedInstance
        
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
        
//            print("cell tapped ----> index: \(indexPath.row) ----> isCompleted: \((self.algosArray?[indexPath.row].isCompleted)!)")
            
            
            let cell = self.algosTableView.cellForRow(at: indexPath) as! AlgosTableViewCell
            self.cellTargeted = cell
            
            
            self.algoTargeted = cell.model
            
            // if isCompleted is false then open the camera to take photo
            if !cell.model.isCompleted {
  
                self.checkMarkDelegate = cell
                
                self.algoPlace = cell.model.place
                
                
                self.openCamera()
            } else {
                // This algo is already completed, go to algo details page
                
                // Instantiate a storyboard VC and downcasting to the specific type
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlgoDetailsVC") as! AlgoDetailsViewController

                // Setting some data
                vc.algoData = self.algoTargeted
                vc.algoIndex = indexPath.row
                vc.trackData = self.trackData
                vc.updateTDVCForDeleteDelegate = self
                vc.updateTDVCForAddDelegate = self
                
                
                // Fetch all images for this algo from core data
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
                
                
//                print("algo place ---> \((self.algoTargeted?.place)!)")
                
                
                
                let placePredicate = NSPredicate(format: "algoPlace = %d", (self.algoTargeted?.place)!)
                let trackPredicate = NSPredicate(format: "track = %d", (self.algoTargeted?.track)!)
                
                request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [placePredicate, trackPredicate])
                
                do {
                    let results = try self.context.fetch(request)
                    let tempArr = results as! [Photo]
                    
                    vc.photosArray = tempArr.reversed()
                    
//                    print("Got all the photos from CoreData")
                    
                    
                    
                    // Convert NSData to UIImage and save in array ----------------------------------------
                    // **** Remember to cache these images later!!! ****
                    for photo in tempArr {
                        let image : UIImage = UIImage(data: photo.image as! Data)!
                        vc.imagesArray.append(image)
                    }
                    
                    vc.imagesArray = vc.imagesArray.reversed()
                    
                } catch {
                    print("\(error)")
                }
                
                

                // Presenting the vc that we instantiated
                vc.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                self.present(vc, animated: true, completion: nil)
                
            }
        
        }
        
        
    }
    

    
    func openCamera(){
//        print("opening camera")
        
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
//        print("cancel camera")
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.photo = chosenImage
        
        
//        print("gotcha!")
        
        // Animate the checkmark
        self.checkMarkDelegate?.AnimateCheckMark(from: "vc")

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
            
            photo.track = (self.trackData?.track)!
            photo.algoPlace = self.algoPlace!
            // ::::::::::::::::::::::::::::::::::::::::::::::::::::
            print(photo)
            
            
            
            // Update algos and tracks CoreDate stuffs accordingly ++++++++++++++++
            self.trackData?.completedM += 1
//            self.algoTargeted?.numPhotos += 1
            
            // Save CodeData context ++++++++++++++++++++++++++++++++++++++++++++++
            if self.context.hasChanges {
                do {
                    try self.context.save()
//                    print("Success")
                    CustomPhotoAlbum.sharedInstance.save(image: self.photo!)
                } catch {
                    print("\(error)")
                }
            }

        } else {
            print("Photo is nil...")
        }
    }
    
    
    
    // Protocol methods ---------------------------------------------------------
    func HandlePhotoDeleted(algo:Algo, index:Int) {
        
        print("In the Track Details VC, updating data for photo delete")
        
        // Update info
//        self.algosArray?[index].numPhotos -= 1
  
        print(index)
        
        
        
        if self.algosArray?[index].numPhotos == 0 {
            self.algosArray?[index].isCompleted = false
            self.cellTargeted?.addBtnImage.image = UIImage(named: "addBtn")
            // Update Track Data
            self.trackData?.completedM -= 1
        }
        
        
        
        
        // Save CodeData context ++++++++++++++++++++++++++++++++++++++++++++++
        if self.context.hasChanges {
            do {
                try self.context.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }

        // Update UI
        self.cellTargeted?.model = (self.algosArray?[index])!
        self.algosTableView.reloadData()
        
        
        
    }
    
    
    
    func HandlePhotoAdded(algo: Algo, index: Int) {
        
        print("In the Track Details VC, updating data for photo add")
        self.algosTableView.reloadData()
        
        
    }
    
    
    
    
}

