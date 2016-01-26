//
//  ListConnectionsViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/25/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class ListConnectionsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    
    //MARK:- variables
    var searchResults = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMedia()
        
    }
    
    func loadMedia(){
        Alamofire.request(.POST, kLocalHost + "/api/findMedia.php", parameters: nil).responseJSON {
            response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                for file in json["files"]{
                    self.searchResults.append(file.1.string!)
                }
                self.tableView.reloadData()
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }//end func load media
    
    
}

//MARK: - Extensions

extension ListConnectionsViewController : UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - Tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.searchResults[indexPath.row] as String
        cell.imageView?.image = UIImage(named: "thumbnail")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selection made")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMedia"
        {
            if let path = self.tableView.indexPathForSelectedRow{
                let playerView = segue.destinationViewController as! MediaPlayerViewController
                playerView.fileName = self.searchResults[path.row]
                print(playerView.fileName)
            }
            
        }
        
    }
    
}