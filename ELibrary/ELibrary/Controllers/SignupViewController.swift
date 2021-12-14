//
//  SignupViewController.swift
//  ELibrary
//
//  Created by 赵芷涵 on 12/12/21.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    @IBOutlet weak var txtAccount: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtRePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func backButtonPress(_ sender: Any) {
        performSegue(withIdentifier: "SignupSegue", sender: nil)
        print("button work")
    }
    
    
    @IBAction func SignupAction(_ sender: Any) {
        let email = txtAccount.text
        let password = txtPassword.text
        let repassword = txtRePassword.text
        
        if email?.count == 0{
            print("email is null")
            UIAlertController.showAlert(message: "Please enter an email!", in: self)
        }
        else if isValidEmail(email!) == false{
            print("email wrong")
            UIAlertController.showAlert(message: "Please enter a valid email!", in: self)
        }
        if password != repassword {
            UIAlertController.showAlert(message: "Two password input inconsistencies, please re-enter!", in: self)
            return 
        }
        
        
        Auth.auth().createUser(withEmail: email!, password: password!) { authResult, error in
            if error != nil{
                UIAlertController.showAlert(message: "\(error?.localizedDescription)", in: self)
                return
            }
            UIAlertController.showAlert(message: "successful!", in: self)
        }
        
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    

}
