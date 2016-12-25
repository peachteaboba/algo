//
//  UpdateTDVCForPhotoDeleteDelegate.swift
//  algos
//
//  Created by Andy Feng on 12/24/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit
protocol UpdateTDVCForPhotoDeleteDelegate: class {
    
    func HandlePhotoDeleted(algo:Algo, index:Int)
    
}
