//
//  PhotosTableViewCell.swift
//  algos
//
//  Created by Andy Feng on 12/22/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit



class PhotosTableViewCell: UITableViewCell{

    
    // Variables -------------------------------
    var idx:Int?
    
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var myAwesomeImageView: UIImageView!
    @IBOutlet weak var dotsView: UIView!
    
    
    
    // Delegates ---------------------------
    var photoMenuDelegate: PhotoMenuDelegate?
    
    
    // Model -------------------------------
    private var _model:Photo?
    var model : Photo {
        set{
            _model = newValue
            
            // call function to set some controls
            self.setControls()
        }
        get {
            return _model!
        }
    }

    
    // Helper functions -----------------------
    func setControls(){
        
        
        
        
        // Set time label
        self.timestampLabel.text = self.timeAgoSinceDate(date: (self._model?.timestamp)!, numericDates: false)
        self.timestampLabel.textColor = self.UIColorFromRGB(0xccccd5) // light grey
    }
    
    
    // Protocol Method
    func handledotsViewTapped(){
        self.photoMenuDelegate?.HandlePhotoMenuButtonTapped(photoModel: self._model!, cell: self)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Assign event handler to dotsView
        let dotsViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handledotsViewTapped))
        self.dotsView.isUserInteractionEnabled = true
        self.dotsView.addGestureRecognizer(dotsViewTap)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
