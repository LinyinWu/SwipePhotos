
/* invoke the function by other */
DataManager.getTopAppsDataFromItunesWithSuccess { (iTunesData) -> Void in
            var error : NSError?
            let json : NSDictionary = NSJSONSerialization.JSONObjectWithData(iTunesData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
            
        }

/*  conection */
   let url : NSURL = NSURL(string: "http://www.reddit.com/r/pics/top.json")!   
   var request: NSURLRequest = NSURLRequest(URL: url)
   var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
   connection.start()

func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
       self.data.appendData(data)
   }

/* NSData to NSString */
   if let str: NSString = data.base64EncodedStringWithOptions(nil) as NSString? {
       label.text = str
       println(str)
   }


/* Error!  */
       func getDataFromUrl((urlStr:String) -> NSData) {
        let url : NSURL = NSURL(String : urlStr)!
        let data : NSData = NSData(contentsOfURL: url)!
        return data
    }

       
   
