//
//  ViewController.swift
//  SwipePhotos
//
//  Created by Linyin Wu on 2/4/15.
//  Copyright (c) 2015 Linyin Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    var index : Int = 0
    var photos = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* get the photos from url and store them */
        let url : NSURL = NSURL(string: "http://www.reddit.com/r/pics/top.json")!
        let data : NSData = NSData(contentsOfURL: url)!
        var error : NSError?
        let json : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        if let dataParent : NSDictionary = json["data"] as? NSDictionary {
            if let children : NSArray = dataParent["children"] as? NSArray {
                for i in 0...(children.count-1) {
                    if let dataChild : NSDictionary = children[i]["data"] as? NSDictionary {
                        let dataUrlStr : NSString = dataChild["url"] as NSString
                        println(dataUrlStr)
                        let imageData : NSData = NSData(contentsOfURL : NSURL(string : dataUrlStr)!)!
                        var photo : UIImage? = UIImage(data : imageData)
                        if photo != nil {
                            photos.append(photo!)
//                            println(i)
                        }
                    }
                }
            }
        }
        imageView.image = photos[index]
        
        /* detect the swipe gesture */
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//         Dispose of any resources that can be recreated.
    }
    
    func displayImage() {
        imageView.image = photos[index]
    }
    
    /* action taken when swiping */
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Swiped right")
                if (index < (photos.count)-1) {
                    index = index + 1
                    displayImage()
                }
            case UISwipeGestureRecognizerDirection.Left:
                println("Swiped left")
                if(index > 0) {
                    index = index - 1
                    displayImage()
                }
            default:
                break
            }
        }
    }
    

}

