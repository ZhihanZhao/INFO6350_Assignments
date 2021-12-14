//
//  SearchViewController.swift
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


class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   
    
    
    @IBOutlet weak var lblMesg: UILabel!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var clickBook = Book()
    
    var arrBook: [Book] = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SearchTableViewCell", owner: self, options: nil)?.first as! SearchTableViewCell
        cell.lblTitle.text = self.arrBook[indexPath.row].title
//        cell.lblAuthor.text = self.arrBook[indexPath.row].author
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        clickBook = arrBook[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count != 0{
        getSearchResult(searchBar.text!)
        }
        print(arrBook)
        table.reloadData()
    }
    
    //Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            if searchBar.text!.isEmpty{
                arrBook.removeAll()
                table.reloadData()
            }
            return;
        
    }
    
    
    

    
    func getSearchResult(_ inputText:String){
        let searchText = inputText.replacingOccurrences(of: " ", with: "+")
        let url = "https://openlibrary.org/search.json?title=\(searchText)"
        print(url)
        AF.request(url).responseJSON { response in
            if response.error != nil {
            }
            let resJSON = JSON(response.value)
            
            
            for i in 0...20{
                let searchBook = Book()
                searchBook.author = resJSON["docs"][i]["author_name"][0].stringValue
                searchBook.title = resJSON["docs"][i]["title"].stringValue
                searchBook.language = resJSON["docs"][i]["language"][0].stringValue
                searchBook.InnerKey = resJSON["docs"][i]["edition_key"][0].stringValue
                self.arrBook.append(searchBook)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if  segue.destination is DetailViewController {
                    if let target = segue.destination as? DetailViewController {
                        target.detailBook = clickBook
                    }
                }
            }
}
