//
//  TracksViewController.swift
//  algos
//
//  Created by Andy Feng on 12/19/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit
import CoreData

class TracksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: Fixtures :::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    var tracksArray:[Track] = []
    
    
    func initTracksData(){
        
        // Create Track 1 object :::::::::::::::::::::::::::::::
        let track1 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track1.track = 1
        track1.name = "Fundamentals"
        track1.desc = "The Basic 13. #PumpkinSpicedLatte"
        track1.completedM = 10
        track1.completedO = 5
        track1.totalM = 10
        track1.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 2 object :::::::::::::::::::::::::::::::
        let track2 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track2.track = 2
        track2.name = "Arrays I"
        track2.desc = "Why did the developer quit his job?"
        track2.completedM = 8
        track2.completedO = 0
        track2.totalM = 10
        track2.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 3 object :::::::::::::::::::::::::::::::
        let track3 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track3.track = 3
        track3.name = "Strings I"
        track3.desc = "The Wifi Password. We're not savages."
        track3.completedM = 2
        track3.completedO = 0
        track3.totalM = 10
        track3.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 4 object :::::::::::::::::::::::::::::::
        let track4 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track4.track = 4
        track4.name = "Lists I"
        track4.desc = "A single-file line of elephants."
        track4.completedM = 3
        track4.completedO = 0
        track4.totalM = 10
        track4.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 5 object :::::::::::::::::::::::::::::::
        let track5 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track5.track = 5
        track5.name = "Recursion"
        track5.desc = "Basically like Inception.."
        track5.completedM = 0
        track5.completedO = 0
        track5.totalM = 10
        track5.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 6 object :::::::::::::::::::::::::::::::
        let track6 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track6.track = 6
        track6.name = "Arrays II"
        track6.desc = "He didn't get Arrays..."
        track6.completedM = 0
        track6.completedO = 0
        track6.totalM = 10
        track6.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 7 object :::::::::::::::::::::::::::::::
        let track7 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track7.track = 7
        track7.name = "Strings II"
        track7.desc = "tacocat"
        track7.completedM = 0
        track7.completedO = 0
        track7.totalM = 10
        track7.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 8 object :::::::::::::::::::::::::::::::
        let track8 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track8.track = 8
        track8.name = "Lists II"
        track8.desc = "SPACESHIPS!"
        track8.completedM = 0
        track8.completedO = 0
        track8.totalM = 10
        track8.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 9 object :::::::::::::::::::::::::::::::
        let track9 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track9.track = 9
        track9.name = "Sorts"
        track9.desc = "Just sort it out.."
        track9.completedM = 0
        track9.completedO = 0
        track9.totalM = 10
        track9.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 10 object :::::::::::::::::::::::::::::
        let track10 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track10.track = 10
        track10.name = "Binary Search Tree"
        track10.desc = "Please make it stop.."
        track10.completedM = 0
        track10.completedO = 0
        track10.totalM = 10
        track10.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 11 object :::::::::::::::::::::::::::::
        let track11 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track11.track = 11
        track11.name = "Data Structures I"
        track11.desc = "'Bleep Bloop Blop Bleep Boob' - R2-D2"
        track11.completedM = 0
        track11.completedO = 0
        track11.totalM = 10
        track11.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 12 object :::::::::::::::::::::::::::::
        let track12 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track12.track = 12
        track12.name = "Data Structures II"
        track12.desc = "'I find that answer vague and inconvincing' - K-2SO"
        track12.completedM = 0
        track12.completedO = 0
        track12.totalM = 10
        track12.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        if self.context.hasChanges {
            do {
                try self.context.save()
                print("Success")
                self.fetchAllTracks()
                
            } catch {
                print("\(error)")
            }
        }

    }
    
    
    
    
    

    
    
    // MARK: Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let transition = CATransition()
    
    
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    @IBOutlet weak var menuButtonView: UIView!
    @IBOutlet weak var tracksTableView: UITableView!

    
    
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::
    
    override func viewWillAppear(_ animated: Bool) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.currentView = "tracks"
        
        
        // Initialize Tracks Data
        if appDel.tracksArray == nil {
            // Tracks are not yet cached
            self.fetchAllTracks()
            appDel.tracksArray = self.tracksArray
            
            if self.tracksArray.count == 0 {
                // No data in Core Data, initialize tracks data
                self.initTracksData()
            } else {
                
                for track in self.tracksArray {
                    print(track.name!)
                }
                
            }

        } else {
            // Tracks are already cached in appDel
            print("got some cool stuff from the appDel (tracksArray)")
            self.tracksArray = appDel.tracksArray!
            self.tracksTableView.reloadData()
        }
    }
    
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Initial Styling
        
        
        
        
        // Reveal left menu when top left corner is tapped and when swiped from the left
        if self.revealViewController() != nil {
            
            let menuTap = UITapGestureRecognizer(target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            self.menuButtonView.isUserInteractionEnabled = true
            self.menuButtonView.addGestureRecognizer(menuTap)
            

            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        }
        
        
        
        
        
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
       
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Initial Styles :::::::::::::::::::::::::::::::::::::::::::::::::::


    
    
    
    
    
    // MARK: Table View Protocol Methods :::::::::::::::::::::::::::::::::::::::::::::::::::
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tracksArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TracksTableViewCell
        
        // Set the model
        cell.model = self.tracksArray[indexPath.row]
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Force this action into the main queue
        DispatchQueue.main.async {
            // Instantiate a new instance of the target vc
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrackDetailVC") as! TrackDetailViewController
            
            // Set some data
            vc.trackData = self.tracksArray[indexPath.row]
            
            // Make the transition
            self.present(vc, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        print("doing segure now -----")
//        
//        if segue.identifier == "ShowTrackDetails" {
//            
//            print("doing segure now")
//            
//        }
//        
//        
//        
//        
//        
//        
//    }
    
    
    
//    
//    func prepare(for segue: UIStoryboardSegue, sender: IndexPath) {
//        
//        print("doing segure now -----")
//        
//        
//        if segue.identifier == "ShowTrackDetails" {
//            
//            print("doing segure now")
//            
//        }
//
//    }
//    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: Core Data Methods :::::::::::::::::::::::::::::::::::::::::::::::::::
    func fetchAllTracks() {
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Track")
        do {
            let results = try context.fetch(userRequest)
            let tempArr = results as! [Track]
            self.tracksArray = tempArr.sorted { $0.track < $1.track }
            
        } catch {
            print("\(error)")
        }
        // Reload TV data
        self.tracksTableView.reloadData()
    }
    
    
    
    
    
    
}

