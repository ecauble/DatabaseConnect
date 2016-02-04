//
//  MediaBrowserViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/21/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import SwiftyJSON
import SVProgressHUD


class MediaBrowserViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    
    //MARK:- variables
    var searchResults = [String]()
    
    
    // MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMedia()
        
    }
    
    //loads video files from request
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


//MARK:- TODO
func getImageFromURL(path : String)->UIImage{
    var image : UIImage?
    var err: NSError? = nil
    do {
        let asset = AVURLAsset(URL: NSURL(fileURLWithPath: path), options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        let cgImage = try imgGenerator.copyCGImageAtTime(CMTimeMake(0, 1), actualTime: nil)
        image = UIImage(CGImage: cgImage)
        //let imageView = UIImageView(image: image)
        // lay out this image view, or if it already exists, set its image property to uiImage
    } catch let error as NSError {
        print("Error generating thumbnail: \(error)")
        image = nil
    }
    return image!
}


//MARK: - Extensions
extension MediaBrowserViewController : UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.searchResults[indexPath.row] as String
        //let thumbnail = getImageFromURL(kLocalHost + "/media/" + self.searchResults[indexPath.row])
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