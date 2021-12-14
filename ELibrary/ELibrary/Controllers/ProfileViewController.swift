//
//  ProfileViewController.swift
//  ELibrary
//
//  Created by 赵芷涵 on 12/13/21.
//

import UIKit
import Firebase
import Realm
import RealmSwift

class ProfileViewController: UIViewController {
    
    //var
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtSummary: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    //outlets

    override func viewDidLoad() {
        super.viewDidLoad()
        showProfile()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateAction(_ sender: Any) {
        updateProfile()
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    
    func updateProfile(){
        if Auth.auth().currentUser != nil {
          // User is signed in.
            let uid = Auth.auth().currentUser?.uid
            let realm = try! Realm()
            let currentUser = realm.object(ofType: User.self, forPrimaryKey: uid)
            try! realm.write {
                if txtFirstName.text?.count != 0{
                    currentUser!.firstName = txtFirstName.text!
                }
                if txtLastName.text?.count != 0{
                    currentUser!.lastName = txtLastName.text!
                }
                if txtAge.text?.count != 0{
                    currentUser!.age = txtAge.text!
                }
                if txtSummary.text?.count != 0{
                    currentUser!.summary = txtSummary.text!
                }
                realm.add(currentUser!, update:.all)
                }
            UIAlertController.showAlert(message: "Update successfully!", in: self)
            txtAge.text?.removeAll()
            txtSummary.text?.removeAll()
            txtFirstName.text?.removeAll()
            txtLastName.text?.removeAll()
        } else {
          // No user is signed in.
            UIAlertController.showAlert(message:"No user is signed in!", in: self)
        }
        showProfile()
    }
    
    func showProfile(){
        let uid = Auth.auth().currentUser?.uid
        let realm = try! Realm()
        let currentUser = realm.object(ofType: User.self, forPrimaryKey: uid)
        self.txtFirstName.placeholder = currentUser?.firstName
        self.txtLastName.placeholder = currentUser?.lastName
        self.txtAge.placeholder = currentUser?.age
        self.txtSummary.placeholder = currentUser?.summary
    }
    
    


}
