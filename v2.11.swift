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
    
    let animationDuration: NSTimeInterval = 0.25
    let switchingInterval: NSTimeInterval = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
//        imageView.image = photos[index]
        imageView.image = photos[index++]
        animateImageView()
        
        
//        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
//        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
//        self.view.addGestureRecognizer(swipeRight)
//        
//        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
//        self.view.addGestureRecognizer(swipeLeft)
        
        
    }

    func animateImageView() {
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(self.switchingInterval * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.animateImageView()
            }
        }
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        /*
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        */
        imageView.layer.addAnimation(transition, forKey: kCATransition)
        imageView.image = photos[index]
        
        CATransaction.commit()
        
        index = index < photos.count - 1 ? index + 1 : 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//         Dispose of any resources that can be recreated.
    }
    
//    func displayImage() {
//        imageView.image = photos[index]
//    }
//    
//    
//    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
//        
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//            switch swipeGesture.direction {
//            case UISwipeGestureRecognizerDirection.Right:
//                println("Swiped right")
//                if (index < (photos.count)-1) {
//                    index = index + 1
//                    displayImage()
//                }
//            case UISwipeGestureRecognizerDirection.Left:
//                println("Swiped left")
//                if(index > 0) {
//                    index = index - 1
//                    displayImage()
//                }
//            default:
//                break
//            }
//        }
//    }
    

}

