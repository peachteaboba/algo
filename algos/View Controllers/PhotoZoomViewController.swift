//
//  PhotoZoomViewController.swift
//  algos
//
//  Created by Andy Feng on 12/29/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class PhotoZoomViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: Outlets ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!

    
    var imageData: UIImage?
    
    
    
    
    
    // MARK: Handle Stuff Tapped ::::::::::::::::::::::::::::::::::::::::::::::
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    
    // MARK: UI Lifecycle Events ::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = self.imageData!
        
        // Initial Styling -----------
        scrollView.maximumZoomScale = 10.0
        scrollView.minimumZoomScale = 1.0
        
        
        
        // Assign event handler to imageView
        let imageViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleImageViewTapped))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(imageViewTap)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Scroll view protocol methods
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    
    
    func handleImageViewTapped(){
        // Dismiss this view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

