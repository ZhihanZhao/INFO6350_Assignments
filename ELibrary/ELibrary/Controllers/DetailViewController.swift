//
//  DetailViewController.swift
//  ELibrary
//
//  Created by 赵芷涵 on 12/14/21.
//

import UIKit
import RealmSwift
import Realm
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit

class DetailViewController: UIViewController {

    var picURL:String = ""
    var detailBook = Book()
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblPublisher: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBook: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        showInformation()
    }
    
    
    @IBAction func refreshAction(_ sender: Any) {
        showInformation()
    }
    
    func showInformation(){
                    //updateUI
        self.lblSummary.text = self.detailBook.summury
        self.lblTitle.text = "< \(self.detailBook.title) >"
        self.lblAuthor.text = "Author: \(self.detailBook.author)"
        self.lblSubject.text = "Subject: \(self.detailBook.subjects)"
        self.lblLanguage.text = "Language: \(self.detailBook.language)"
        self.lblVersion.text = "Version: \(self.detailBook.version)"
        if detailBook.picAddress != ""{
        let loadURL = URL(string: self.detailBook.picAddress)!
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: loadURL) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.imgBook.image = UIImage(data: data!)
            }
        }
    }
    }
    
    func loadData(){
        let url = "https://openlibrary.org/works/\(detailBook.InnerKey).json"
        AF.request(url).responseJSON { response in
            if response.error != nil {
            }
            let resJSON = JSON(response.value)
            self.detailBook.summury = resJSON["description"].stringValue
            self.detailBook.title = resJSON["title"].stringValue
            self.detailBook.subjects = resJSON["subjects"][0].stringValue
            self.detailBook.version = resJSON["revision"].stringValue
            self.detailBook.picAddress = "https://covers.openlibrary.org/b/id/\(resJSON["covers"][0].stringValue).jpg"
        }
    }
    
    
    
}
