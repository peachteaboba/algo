//
//  RegViewController.swift
//  algos
//
//  Created by Andy Feng on 2/17/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit
import Alamofire

class RegViewController: UIViewController {
    // MARK: Global Variables -----------------------------
    var emailCheck = false
    var usernameCheck = false
    var passwordCheck = false
    var showLoginDelegate: ShowLoginDelegate?
    
    
    
    // MARK: Outlets --------------------------------------
    @IBOutlet weak var cancelButtonView: UIView!
    @IBOutlet weak var topBGView: UIView!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailCheckView: UIView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var usernameCheckView: UIView!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckView: UIView!
    
    
    @IBOutlet weak var loginButtonLabel: UILabel!
    
    
    // Error view
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var errorViewLabel: UILabel!
    
    
    
    
    // MARK: Actions --------------------------------------
    func handleCancelButtonTapped() {
        // Hide error view
        self.errorView.isHidden = true
        // Dismiss keyboard
        self.view.endEditing(true)
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleLoginButtonTapped() {
        // Hide error view
        self.errorView.isHidden = true
        // Dismiss keyboard
        self.view.endEditing(true)
        // Dismiss view
        self.dismiss(animated: true, completion: nil)
        showLoginDelegate?.ShowLoginVC()
    }
    
    @IBAction func handleRegisterButtonPressed(_ sender: UIButton) {
        if emailCheck && usernameCheck && passwordCheck {
            print("all validations passed")
            
            
            let headers = ["secret": "robot"]
 
            let parameters: [String: AnyObject] = [
                "email" : self.emailField.text! as AnyObject,
                "username" : usernameField.text! as AnyObject,
                "password" : passwordField.text! as AnyObject
            ]
            
            
            /// Make API call to register user ----------- (to do)
            Alamofire.request("http://localhost:9000/reg", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { response in
                    
                    
                    if let data = response.result.value as? NSDictionary{
                        
                        if ((data["error_message"] as? String) != nil) {
                            
                            print((data["error_message"] as? String)!)
                            
                            // There's an error. Display the error.
                            self.errorViewLabel.text = (data["error_message"] as? String)!
                            self.displayError()
                            
                        } else {
                            print("no errors")
                            print(data)
                            
                           

                            // Cache user data in appDel
                            let appDel = (UIApplication.shared).delegate as! AppDelegate
                            let user = User(email: (data["email"] as? String)!, username: (data["username"] as? String)!, password: (data["password"] as? String)!)
                            appDel.thisUser = user
                            
                            // Save the user's email and password in NSUserDefaults (To Do: ---> Generate real tokens to save here..)
                            let token: [String: String] = [
                                "email" : self.emailField.text!,
                                "password" : self.passwordField.text!
                            ]
                            UserDefaults.standard.set(token, forKey: "user_auth_token")
                            
                            // Dismiss this view and show user profile page
                            // Hide error view
                            self.errorView.isHidden = true
                            // Dismiss keyboard
                            self.view.endEditing(true)
                            // Dismiss view
                            self.dismiss(animated: true, completion: nil)

                        }
 
                    }
            }
            
            
        } else {
            // There's an error. Display the error.
            self.errorViewLabel.text = "Validations not passed"
            self.displayError()
        }
    }
    
    // Input field validations :::::::::::::::::::::::::::::::::::::::::::::
    @IBAction func handleEmailFieldEditingChanged(_ sender: UITextField) {
        if isValidEmailAddress(emailAddressString: self.emailField.text!){
            emailCheck = true
        } else {
            emailCheck = false
        }
        updateValidationColors()
    }
    
    @IBAction func handleUsernameFieldEditingChanged(_ sender: UITextField) {
        if (usernameField.text?.characters.count)! > 3 {
            usernameCheck = true
        } else {
            usernameCheck = false
        }
        updateValidationColors()
    }

    @IBAction func handlePasswordFieldEditingChanged(_ sender: UITextField) {
        if (passwordField.text?.characters.count)! > 3 {
            passwordCheck = true
        } else {
            passwordCheck = false
        }
        updateValidationColors()
    }
    
    
    

    
    
    
    
    
    
    
    
    
    
    // MARK: UI Lifecycle ---------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign event handler to cancelButtonView
        let cancelButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleCancelButtonTapped))
        self.cancelButtonView.isUserInteractionEnabled = true
        self.cancelButtonView.addGestureRecognizer(cancelButtonTap)
        
        // Assign event handler to loginButtonLabel
        let loginButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.handleLoginButtonTapped))
        self.loginButtonLabel.isUserInteractionEnabled = true
        self.loginButtonLabel.addGestureRecognizer(loginButtonTap)
        
        // Background styles
        self.topBGView.backgroundColor = self.UIColorFromRGB(0x19191f) // dark dark purp
        self.view.backgroundColor = self.UIColorFromRGB(0x211f27) // dark purp
        
        // Register button styles
        self.registerButton.backgroundColor = self.UIColorFromRGB(0x19191f)
        self.registerButton.layer.cornerRadius = 5
        
        // Auto-focus email text field
        self.emailField.becomeFirstResponder()
        
        
        // Rounded corners on right side only ::::::::::::::::::::::::::::::::::
        let path = UIBezierPath(roundedRect:emailCheckView.bounds,
                                byRoundingCorners:[.topRight, .bottomRight],
                                cornerRadii: CGSize(width: 5, height:  5))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        emailCheckView.layer.mask = maskLayer
        let maskLayer2 = CAShapeLayer()
        maskLayer2.path = path.cgPath
        usernameCheckView.layer.mask = maskLayer2
        let maskLayer3 = CAShapeLayer()
        maskLayer3.path = path.cgPath
        passwordCheckView.layer.mask = maskLayer3
        // :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
        
        // Check view styles
        updateValidationColors()
        
        // Error view
        self.errorViewTopConstraint.constant = -100
        
        // Hide error view
        self.errorView.isHidden = true
        
    }
    
    
    
    // MARK: Helper Functions ------------------------------
    func displayError() {
        // Show error view
        self.errorView.isHidden = false
        
        self.errorViewTopConstraint.constant = -30
        
        // Code to start animation
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
            self.view.layoutIfNeeded()
        }) { (finished) in
            if finished {
                // Code to execute after animation...
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    // do stuff 2 seconds later
                    self.hideError()
                }
            }
        }
    }
    
    func hideError() {
        self.errorViewTopConstraint.constant = -100
        
        // Code to start animation
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.7, options: [UIViewAnimationOptions.allowUserInteraction], animations: {
            self.view.layoutIfNeeded()
        }) { (finished) in
            if finished {
                // Code to execute after animation...
            }
        }
    }
    
    
    
    
    
    func updateValidationColors(){
        
        // Update email color
        if emailCheck {
            self.emailCheckView.backgroundColor = self.UIColorFromRGB(0x47D68C) // green
        } else {
            self.emailCheckView.backgroundColor = self.UIColorFromRGB(0xE6606E) // red
        }
        // Update username color
        if usernameCheck {
            self.usernameCheckView.backgroundColor = self.UIColorFromRGB(0x47D68C)
        } else {
            self.usernameCheckView.backgroundColor = self.UIColorFromRGB(0xE6606E)
        }
        // Update password color
        if passwordCheck {
            self.passwordCheckView.backgroundColor = self.UIColorFromRGB(0x47D68C)
        } else {
            self.passwordCheckView.backgroundColor = self.UIColorFromRGB(0xE6606E)
        }

    }
    
    // Check valid email format
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
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


