//
//  ViewController.swift
//  FruitsShowByTableView
//
//  Created by 赵芷涵 on 9/24/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
let arr = ["berries", "kiwi", "papaya", "watermelon", "apple", "banana", "mango", "orange", "pineapple"]


    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.imgView.image = UIImage (named:arr[indexPath.row])
        cell.lblImage.text = arr[indexPath.row]
        
        return cell
    }


}

