//
//  AlgoHeaderTableViewCell.swift
//  algos
//
//  Created by Andy Feng on 12/26/16.
//  Copyright © 2016 Andy Feng. All rights reserved.
//

import UIKit

class AlgoHeaderTableViewCell: UITableViewCell {


   
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var algoDescriptionLabel: UILabel!
    @IBOutlet weak var completedOnView: UIView!
    @IBOutlet weak var completedOnLabel: UILabel!
    
    var completedDate:String?
    
    // Model -------------------------------
    private var _model:Algo?
    var model : Algo {
        set{
            _model = newValue
            
            // call function to set some controls
            self.setControls()
        }
        get {
            return _model!
        }
    }
    
    
    func setControls(){
        self.completedDate = self.getTimeDate(date: (self._model?.completedOn)!)
        
        self.algoDescriptionLabel.text = self._model?.desc

        self.completedOnLabel.text = self.completedDate
        
    }
    
    func getTimeDate(date:NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM dd yyyy"
        return dateFormatter.string(from: date as Date)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.completedOnView.layer.cornerRadius = self.completedOnView.frame.height / 2
        self.completedOnView.backgroundColor = self.UIColorFromRGB(0x6e21d0) // dark purple
        self.algoDescriptionLabel.textColor = self.UIColorFromRGB(0x6e21d0) // dark purple
        
        
        
        // Assign event handler to completedOnView
        let completedOnViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleCompletedOnViewTapped))
        self.completedOnView.isUserInteractionEnabled = true
        self.completedOnView.addGestureRecognizer(completedOnViewTap)
  
    }
    
    func handleCompletedOnViewTapped(){
        if self.completedOnLabel.text == self.completedDate {
            self.completedOnLabel.text = "Completion Date"
        } else {
            self.completedOnLabel.text = self.completedDate
        }
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
