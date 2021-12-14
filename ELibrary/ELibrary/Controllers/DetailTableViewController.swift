//
//  DetailTableViewController.swift
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

class DetailTableViewController: UITableViewController {

    
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
        loadDetailInformation()
    }
    
    func loadDetailInformation(){
        let url = "https://openlibrary.org/works/\(detailBook.InnerKey).json"
        var picURL = "https://covers.openlibrary.org/b/id/\(detailBook.InnerKey).jpg"
        AF.request(url).responseJSON { response in
            if response.error != nil {
            }
            let resJSON = JSON(response.value)
            self.lblSummary.text = resJSON["description"].stringValue
            self.lblTitle.text = resJSON["title"].stringValue
            self.lblAuthor.text = self.detailBook.author
            self.lblSubject.text = resJSON["subjects"][0].stringValue
            self.lblLanguage.text =  self.detailBook.language
            self.lblVersion.text = resJSON["revision"].stringValue
            let picURL = "https://covers.openlibrary.org/b/id/\(resJSON["covers"][0].stringValue).jpg"
        }
        let loadURL = URL(string: picURL)!
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: loadURL) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.imgBook.image = UIImage(data: data!)
            }
        }
        
    }
}
