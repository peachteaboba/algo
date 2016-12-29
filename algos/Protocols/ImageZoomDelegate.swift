//
//  ImageZoomDelegate.swift
//  algos
//
//  Created by Andy Feng on 12/29/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit
protocol ImageZoomDelegate: class {
    
    func HandleImageTapped(photoModel: Photo, cell: PhotosTableViewCell)
    
    
}
