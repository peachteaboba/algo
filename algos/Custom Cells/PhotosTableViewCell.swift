//
//  PhotosTableViewCell.swift
//  algos
//
//  Created by Andy Feng on 12/22/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit



class PhotosTableViewCell: UITableViewCell {

    
    // Variables -------------------------------
    var timeAgo:String?
    var timeDate:String?
    
    
    
    var secondsAgo = 0
    var minutesAgo = 0
    var hoursAgo = 0
    var daysAgo = 0
    var monthsAgo = 0
    var yearsAgo = 0
    
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var myAwesomeImageView: UIImageView!
    @IBOutlet weak var dotsView: UIView!
    
    
    
    // Delegates ---------------------------
    var photoMenuDelegate: PhotoMenuDelegate?
    var imageZoomDelegate: ImageZoomDelegate?
    
    
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
        
        self.timeAgo = timeAgoSinceDate(numericDates: false)
        self.timeDate = getTimeDate(date: (self._model?.timestamp)!)
        
        // Set time label
        
        if self.daysAgo >= 2 {
            self.timestampLabel.text = self.timeDate
        } else {
            self.timestampLabel.text = self.timeAgo
        }

        self.timestampLabel.textColor = self.UIColorFromRGB(0xccccd5) // light grey
    }
    
    
    // Protocol Method
    func handledotsViewTapped(){
        self.photoMenuDelegate?.HandlePhotoMenuButtonTapped(photoModel: self._model!, cell: self)
    }
    
    
    
    func getTimeDate(date:NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM dd yyyy - h:mm a"
        return dateFormatter.string(from: date as Date)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Assign event handler to dotsView
        let dotsViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handledotsViewTapped))
        self.dotsView.isUserInteractionEnabled = true
        self.dotsView.addGestureRecognizer(dotsViewTap)
        
        
        // Assign event handler to timestampLabel
        let timestampLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTimestampLabelTapped))
        self.timestampLabel.isUserInteractionEnabled = true
        self.timestampLabel.addGestureRecognizer(timestampLabelTap)
        
        
        // Assign event handler to myAwesomeImageView
        let myAwesomeImageViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleMyAwesomeImageViewTapped))
        self.myAwesomeImageView.isUserInteractionEnabled = true
        self.myAwesomeImageView.addGestureRecognizer(myAwesomeImageViewTap)
        
        
        
        
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

    
    
    // Switch between two date formats
    func handleTimestampLabelTapped(){

        self.timeAgo = timeAgoSinceDate(numericDates: false)
        
        if self.timestampLabel.text == self.timeDate {
            self.timestampLabel.text = self.timeAgo
        } else {
            self.timestampLabel.text = self.timeDate
        }
    
        
        
        
    }
    
    func timeAgoSinceDate(numericDates:Bool) -> String{
        
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.timeZone = TimeZone.ReferenceType.local
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.hour = Calendar.current.component(.hour, from: now)
        nowComponents.minute = Calendar.current.component(.minute, from: now)
        nowComponents.second = Calendar.current.component(.second, from: now)
        now = calendar.date(from: nowComponents)!
        
        
        var ago = self._model?.timestamp as! Date
        var agoComponents = DateComponents()
        let calendarAgo = Calendar.current
        agoComponents.timeZone = TimeZone.ReferenceType.local
        agoComponents.year = Calendar.current.component(.year, from: ago)
        agoComponents.month = Calendar.current.component(.month, from: ago)
        agoComponents.day = Calendar.current.component(.day, from: ago)
        agoComponents.hour = Calendar.current.component(.hour, from: ago)
        agoComponents.minute = Calendar.current.component(.minute, from: ago)
        agoComponents.second = Calendar.current.component(.second, from: ago)
        ago = calendarAgo.date(from: agoComponents)!
        
        self.secondsAgo = nowComponents.second! - agoComponents.second!
        self.minutesAgo = nowComponents.minute! - agoComponents.minute!
        self.hoursAgo = nowComponents.hour! - agoComponents.hour!
        self.daysAgo = nowComponents.day! - agoComponents.day!
        self.monthsAgo = nowComponents.month! - agoComponents.month!
        self.yearsAgo = nowComponents.year! - agoComponents.year!

        
        if (yearsAgo >= 2) {
            return "\(yearsAgo) years ago"
        } else if (yearsAgo >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (monthsAgo >= 2) {
            return "\(monthsAgo) months ago"
        } else if (monthsAgo >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        }else if (daysAgo >= 2) {
            return "\(daysAgo) days ago"
        } else if (daysAgo >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (hoursAgo >= 2) {
            return "\(hoursAgo) hours ago"
        } else if (hoursAgo >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (minutesAgo >= 2) {
            return "\(minutesAgo) minutes ago"
        } else if (minutesAgo >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (secondsAgo >= 3) {
            return "\(secondsAgo) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
    
    
    
    
    
    
    // Call protocol methods
    func handleMyAwesomeImageViewTapped(){
        self.imageZoomDelegate?.HandleImageTapped(image: self.myAwesomeImageView.image!)
    }

}
