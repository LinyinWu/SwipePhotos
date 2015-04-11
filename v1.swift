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
    var children : NSArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url : NSURL = NSURL(string: "http://www.reddit.com/r/pics/top.json")!
        let data : NSData = NSData(contentsOfURL: url)!
        var error : NSError?
        let json : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        if let dataParent : NSDictionary = json["data"] as? NSDictionary {
            if let c : NSArray = dataParent["children"] as? NSArray {
                children = c
                displayImage()
            }
        }
        
        
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
        if let dic :  NSDictionary = children?[index] as? NSDictionary {
            if let dataChild : NSDictionary = dic["data"] as? NSDictionary {
                let dataUrlStr : NSString = dataChild["url"] as NSString
                let imageData : NSData = NSData(contentsOfURL : NSURL(string : dataUrlStr)!)!
                imageView.image = UIImage(data : imageData)
                println(dataUrlStr)
            }
        }
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                println("Swiped right")
                if (index < (children?.count)!-1) {
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

