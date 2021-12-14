//
//  HomeViewController.swift
//  ELibrary
//
//  Created by 赵芷涵 on 12/13/21.
//


import UIKit
import RealmSwift
import Realm
import Alamofire
import SwiftyJSON
import SwiftSpinner
import PromiseKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("BookListTableViewCell", owner: self, options: nil)?.first as! BookListTableViewCell
        
        let url = URL(string: arrBook[indexPath.row].picAddress)
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                    cell.imgBook.image = UIImage(data: data!)
            }
        }
        
            cell.lblTitle.text = self.arrBook[indexPath.row].title
            cell.lblAuthor.text = self.arrBook[indexPath.row].author
        
        return cell
    }
     

    @IBOutlet weak var tblList: UITableView!
    var arrBook : [Book] = [Book]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblList.dataSource = self
        tblList.delegate = self
        getPopularBookList()

       
    }
    
    func getPopularBookList(){
        self.arrBook.removeAll()
        let url = "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=\(apiKey)" // build URL for current weather here
        print(url)
        
        AF.request(url).responseJSON { response in
            if response.error != nil {
                print(response.error)
            }
            let resJSON = JSON(response.value)
            let bookList = resJSON["results"]["books"]
            let num = resJSON["num_results"].intValue
            
            for i in 0...num-1 {
                let book = Book()
                book.title = bookList[i]["title"].stringValue
                book.author = bookList[i]["author"].stringValue
                book.picAddress = bookList[i]["book_image"].stringValue
                book.InnerKey = bookList[i]["primary_isbn13"].stringValue
                book.publisher = bookList[i]["publisher"].stringValue
                book.summury  = bookList[i]["description"].stringValue
                
                self.arrBook.append(book)
            }
            self.tblList.reloadData()

                    
        }

    }
    
    


}
