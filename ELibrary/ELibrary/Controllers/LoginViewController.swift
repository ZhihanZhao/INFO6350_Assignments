//
//  LoginViewController.swift
//  ELibrary
//
//  Created by 赵芷涵 on 12/12/21.
//

import UIKit
import Firebase
import Realm
import RealmSwift



class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func unwind(_ segue: UIStoryboardSegue){}
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LoginAction(_ sender: Any) {
        let email = txtEmail.text
        let password = txtPassword.text
        
        if email?.count == 0{
            print("email is null")
            UIAlertController.showAlert(message: "Please enter an email !")
        }
        else if isValidEmail(email!) == false{
            UIAlertController.showAlert(message: "Please enter a valid email !")
        }
        if password?.count ?? 0 < 5{
            UIAlertController.showAlert(message: "Please enter a valid password !")
        }
        
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if error != nil{
                UIAlertController.showAlert(message: "\(error?.localizedDescription)")
                return
            }
        }
        if Auth.auth().currentUser?.uid != nil{
            let uid = (Auth.auth().currentUser?.uid)!
            if checkUserExist(ID: uid) == false{
                let newUser = User()
                newUser.userID = uid
                try! realm.write {
                        realm.add(newUser)
                    }
            }
            performSegue(withIdentifier: "HomeSegue", sender: self)
        }
        
       
    }
    
    
    func checkUserExist(ID: String) -> Bool {
        return realm.object(ofType: User.self, forPrimaryKey: ID) != nil
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

extension UIAlertController {
    //在指定视图控制器上弹出普通消息提示框
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .cancel))
        viewController.present(alert, animated: true)
    }
     
    //在根视图控制器上弹出普通消息提示框
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
     
    //在指定视图控制器上弹出确认框
    static func showConfirm(message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }
     
    //在根视图控制器上弹出确认框
    static func showConfirm(message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirm(message: message, in: vc, confirm: confirm)
        }
    }
}
