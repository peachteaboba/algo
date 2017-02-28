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
    var algosArray:[Algo] = []
   
    
    // TRACKS Data <-------------------------------------------- Dummy Data for Tracks
    func initTracksData(){
        
        // Create Track 1 object :::::::::::::::::::::::::::::::
        let track1 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track1.track = 1
        track1.name = "Fundamentals"
        track1.desc = "The Basic 13. #PumpkinSpicedLatte"
        track1.completedM = 0
        track1.completedO = 0
        track1.totalM = 100
        track1.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 2 object :::::::::::::::::::::::::::::::
        let track2 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track2.track = 2
        track2.name = "Arrays I"
        track2.desc = "Why did the developer quit his job? He didn't get []'s"
        track2.completedM = 0
        track2.completedO = 0
        track2.totalM = 100
        track2.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 3 object :::::::::::::::::::::::::::::::
        let track3 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track3.track = 3
        track3.name = "Strings I"
        track3.desc = "The Wifi Password. We're not savages."
        track3.completedM = 0
        track3.completedO = 0
        track3.totalM = 100
        track3.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 4 object :::::::::::::::::::::::::::::::
        let track4 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track4.track = 4
        track4.name = "Lists I"
        track4.desc = "A single-file line of elephants"
        track4.completedM = 0
        track4.completedO = 0
        track4.totalM = 100
        track4.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 5 object :::::::::::::::::::::::::::::::
        let track5 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track5.track = 5
        track5.name = "Recursion"
        track5.desc = "Basically like Inception.."
        track5.completedM = 0
        track5.completedO = 0
        track5.totalM = 100
        track5.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 6 object :::::::::::::::::::::::::::::::
        let track6 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track6.track = 6
        track6.name = "Arrays II"
        track6.desc = "He didn't get Arrays.."
        track6.completedM = 0
        track6.completedO = 0
        track6.totalM = 100
        track6.totalO = 5
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 7 object :::::::::::::::::::::::::::::::
        let track7 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track7.track = 7
        track7.name = "Strings II"
        track7.desc = "Tacocat spelled backwards is Tacocat."
        track7.completedM = 0
        track7.completedO = 0
        track7.totalM = 100
        track7.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 8 object :::::::::::::::::::::::::::::::
        let track8 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track8.track = 8
        track8.name = "Lists II"
        track8.desc = "SPACESHIPS!"
        track8.completedM = 0
        track8.completedO = 0
        track8.totalM = 100
        track8.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 9 object :::::::::::::::::::::::::::::::
        let track9 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track9.track = 9
        track9.name = "Sorts"
        track9.desc = "Just sort it out.."
        track9.completedM = 0
        track9.completedO = 0
        track9.totalM = 100
        track9.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 10 object :::::::::::::::::::::::::::::
        let track10 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track10.track = 10
        track10.name = "Binary Search Tree"
        track10.desc = "Please make it stop.."
        track10.completedM = 0
        track10.completedO = 0
        track10.totalM = 100
        track10.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 11 object :::::::::::::::::::::::::::::
        let track11 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track11.track = 11
        track11.name = "Data Structures I"
        track11.desc = "'Bleep Bloop Blop Bleep Boob' - R2-D2"
        track11.completedM = 0
        track11.completedO = 0
        track11.totalM = 100
        track11.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Track 12 object :::::::::::::::::::::::::::::
        let track12 = NSEntityDescription.insertNewObject(forEntityName: "Track",  into: context) as! Track
        track12.track = 12
        track12.name = "Data Structures II"
        track12.desc = "'I find that answer vague and inconvincing' - K-2SO"
        track12.completedM = 0
        track12.completedO = 0
        track12.totalM = 100
        track12.totalO = 0
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::

        if self.context.hasChanges {
            do {
                try self.context.save()
                print("Successfully saved some TRACKS data to CoreData")
                self.fetchAllTracks()
                
            } catch {
                print("\(error)")
            }
        }

    }
    
    
    
    // ALGO Data <---------------------------------------------- Dummy Data for Algos
    func initAlgosData(){
        
        // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ TRACK 1 - Fundamentals
        // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ TRACK 1 - Fundamentals
        // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ TRACK 1 - Fundamentals
        
        // Create Algo 1 object :::::::::::::::::::::::::::::::
        let algo1 = NSEntityDescription.insertNewObject(forEntityName: "Algo",  into: context) as! Algo
        algo1.track = 1
        algo1.place = 1
        algo1.isCompleted = false
        algo1.title = "Print 1-255"
        algo1.desc = "Print all the integers from 1 to 255"
        algo1.difficulty = "1"
        algo1.completedOn = nil
        algo1.numPhotos = 0
        algo1.hint = "I am one with the force, the force is with me."
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Algo 2 object :::::::::::::::::::::::::::::::
        let algo2 = NSEntityDescription.insertNewObject(forEntityName: "Algo",  into: context) as! Algo
        algo2.track = 1
        algo2.place = 2
        algo2.isCompleted = false
        algo2.title = "Print Odds 1-255"
        algo2.desc = "Print all odd integers from 1 to 255"
        algo2.difficulty = "1"
        algo2.completedOn = nil
        algo2.numPhotos = 0
        algo2.hint = "Do or do not.. there is no try"
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Algo 3 object :::::::::::::::::::::::::::::::
        let algo3 = NSEntityDescription.insertNewObject(forEntityName: "Algo",  into: context) as! Algo
        algo3.track = 1
        algo3.place = 3
        algo3.isCompleted = false
        algo3.title = "Print Sum 1-255"
        algo3.desc = "Print integers from 0 to 255, and the sum so far"
        algo3.difficulty = "2"
        algo3.completedOn = nil
        algo3.numPhotos = 0
        algo3.hint = "I find that answer vague and inconvincing.."
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Algo 4 object :::::::::::::::::::::::::::::::
        let algo4 = NSEntityDescription.insertNewObject(forEntityName: "Algo",  into: context) as! Algo
        algo4.track = 1
        algo4.place = 4
        algo4.isCompleted = false
        algo4.title = "Iterate Array"
        algo4.desc = "Print all values in a given array"
        algo4.difficulty = "2"
        algo4.completedOn = nil
        algo4.numPhotos = 0
        algo4.hint = "Let the wookie win."
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Algo 5 object :::::::::::::::::::::::::::::::
        let algo5 = NSEntityDescription.insertNewObject(forEntityName: "Algo",  into: context) as! Algo
        algo5.track = 1
        algo5.place = 5
        algo5.isCompleted = false
        algo5.title = "Find Max"
        algo5.desc = "Print the largest element in a given array"
        algo5.difficulty = "3"
        algo5.completedOn = nil
        algo5.numPhotos = 0
        algo5.hint = "Never tell me the odds."
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Algo 6 object :::::::::::::::::::::::::::::::
        let algo6 = NSEntityDescription.insertNewObject(forEntityName: "Algo",  into: context) as! Algo
        algo6.track = 1
        algo6.place = 6
        algo6.isCompleted = false
        algo6.title = "Get Average"
        algo6.desc = "Analyze an array's values and print the average"
        algo6.difficulty = "3"
        algo6.completedOn = nil
        algo6.numPhotos = 0
        algo6.hint = "Would you like to know the probability of her using that against you? It's high."
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ TRACK 2 - Arrays I
        // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ TRACK 2 - Arrays I
        // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ TRACK 2 - Arrays I
        
        // Create Algo 1 object :::::::::::::::::::::::::::::::
        let algo2_1 = NSEntityDescription.insertNewObject(forEntityName: "Algo",  into: context) as! Algo
        algo2_1.track = 2
        algo2_1.place = 1
        algo2_1.isCompleted = false
        algo2_1.title = "PushFront"
        algo2_1.desc = "Given an array and an additional value, insert this value at the beginning of the array. Do this without using any built-in array methods"
        algo2_1.difficulty = "1"
        algo2_1.completedOn = nil
        algo2_1.numPhotos = 0
        algo2_1.hint = "That's not how the force works.."
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::

        // Create Algo 2 object :::::::::::::::::::::::::::::::
        let algo2_2 = NSEntityDescription.insertNewObject(forEntityName: "Algo",  into: context) as! Algo
        algo2_2.track = 2
        algo2_2.place = 2
        algo2_2.isCompleted = false
        algo2_2.title = "PopFront"
        algo2_2.desc = "Given an array, remove and return the value at the beginning of the array. Do this without using any built-in array methods except pop()"
        algo2_2.difficulty = "2"
        algo2_2.completedOn = nil
        algo2_2.numPhotos = 0
        algo2_2.hint = "In my experience, there is no such thing as luck."
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Algo 3 object :::::::::::::::::::::::::::::::
        let algo2_3 = NSEntityDescription.insertNewObject(forEntityName: "Algo",  into: context) as! Algo
        algo2_3.track = 2
        algo2_3.place = 3
        algo2_3.isCompleted = false
        algo2_3.title = "InsertAt"
        algo2_3.desc = "Given an array, an index, and an additional value, insert the value into the array at the given index. Do this without using any built-in array methods"
        algo2_3.difficulty = "2"
        algo2_3.completedOn = nil
        algo2_3.numPhotos = 0
        algo2_3.hint = "Who's scruffy looking??"
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Create Algo 3 object :::::::::::::::::::::::::::::::
        let algo2_4 = NSEntityDescription.insertNewObject(forEntityName: "Algo",  into: context) as! Algo
        algo2_4.track = 2
        algo2_4.place = 4
        algo2_4.isCompleted = false
        algo2_4.title = "RemoveAt"
        algo2_4.desc = "Given an array and an index into the array, remove and return the array value at that index. Do this without using any built-in array methods except pop()"
        algo2_4.difficulty = "3"
        algo2_4.completedOn = nil
        algo2_4.numPhotos = 0
        algo2_4.hint = "It's a trap!!"
        // ::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        
        
        if self.context.hasChanges {
            do {
                try self.context.save()
                print("Successfully saved some ALGO data to CoreData")
                self.fetchAllAlgos()
                
                // Calculate the progress of all tracks to initialize
                
            } catch {
                print("\(error)")
            }
        }
        
        
    }
    
    
    
    
    
    
    
    

    
    
    // MARK: Variables ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    @IBOutlet weak var menuButtonView: UIView!
    @IBOutlet weak var tracksTableView: UITableView!

    
    
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::
    
    override func viewWillAppear(_ animated: Bool) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.currentView = "tracks"
        
        
        // Initialize Tracks Data ++++++++++++++++++++++++++++++++++++++++++++
        // Initialize Tracks Data ++++++++++++++++++++++++++++++++++++++++++++
        // Initialize Tracks Data ++++++++++++++++++++++++++++++++++++++++++++
        if appDel.tracksArray == nil {
            // Tracks are not yet cached
            self.fetchAllTracks()
            
            if self.tracksArray.count == 0 {
                // No data in Core Data, initialize tracks data
                self.initTracksData()
                appDel.tracksArray = self.tracksArray
            } else {
                
//                for track in self.tracksArray {
//                    print(track.name!)
//                }
                
            }

        } else {
            // Tracks are already cached in appDel
            print("got some cool stuff from the appDel (tracksArray)")
//            print(appDel.tracksArray!)
            self.tracksArray = appDel.tracksArray!
            self.tracksTableView.reloadData()
        }
        
        
        
        
        // Initialize Algo Data ++++++++++++++++++++++++++++++++++++++++++++
        // Initialize Algo Data ++++++++++++++++++++++++++++++++++++++++++++
        // Initialize Algo Data ++++++++++++++++++++++++++++++++++++++++++++
        if appDel.algosArray == nil {
            // Algos are not yet cached
            self.fetchAllAlgos()
            
            if self.algosArray.count == 0 {
                // No data in Core Data, initialize tracks data
                self.initAlgosData()
                appDel.algosArray = self.algosArray
                
            } else {
//                for algo in self.algosArray {
//                    print("-----------------> \(algo.title!)")
//                }
            }
        } else {
            // Algos are already cached in appDel
            print("got some cool stuff from the appDel (algosArray)")
//            print(appDel.algosArray!)
            self.algosArray = appDel.algosArray!
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Initial Styling ----------
        // Table view margins
        self.tracksTableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 40.0, 0.0)
        
        
        
        // Reveal left menu when top left corner is tapped and when swiped from the left
        if self.revealViewController() != nil {
            
            let menuTap = UITapGestureRecognizer(target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            self.menuButtonView.isUserInteractionEnabled = true
            self.menuButtonView.addGestureRecognizer(menuTap)
            

            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        }
        
        
        
        
        
//        transition.duration = 0.25
//        transition.type = kCATransitionPush
//        transition.subtype = kCATransitionFromRight
//        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
       
        
        
        
        
        
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
        
        cell.setInit()

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

            var algoArray:[Algo] = []
            for algo in self.algosArray {
                if(algo.track == self.tracksArray[indexPath.row].track){
                    algoArray.append(algo)
                }
            }
            
            
            vc.algosArray = algoArray
            
            // Make the transition
            self.present(vc, animated: true, completion: nil)
        }
        
        
        
        
    }
    

    
    
    
    
    
    
    
    
    // MARK: Core Data Methods :::::::::::::::::::::::::::::::::::::::::::::::::::
    func fetchAllTracks() {
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Track")
        do {
            let results = try context.fetch(userRequest)
            let tempArr = results as! [Track]
            self.tracksArray = tempArr.sorted { $0.track < $1.track }
            print("Got all the tracks from CoreData")
    
        } catch {
            print("\(error)")
        }
        // Reload TV data
        self.tracksTableView.reloadData()
    }
    
    func fetchAllAlgos() {
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Algo")
        do {
            let results = try context.fetch(userRequest)
            let tempArr = results as! [Algo]
            self.algosArray = tempArr.sorted { $0.place < $1.place }
            print("Got all the algos from CoreData")
            
            // Calculate total number of algos for each track
            if self.algosArray.count != 0  && self.tracksArray.count != 0 {
                
                var c = 0
                for track in self.tracksArray {
                    c = 0
                    for algo in self.algosArray {
                        if algo.track == track.track {
                            c += 1
                        }
                    }
                    if c > 0 {
                       track.totalM = Int16(c)
                    }
                }
            }

            if self.context.hasChanges {
                do {
                    try self.context.save()
                    print("Successfully updated total number of algos in each track")

                } catch {
                    print("\(error)")
                }
            }

            
        } catch {
            print("\(error)")
        }
    }
    


    
    
    
    
    
    
    
}

