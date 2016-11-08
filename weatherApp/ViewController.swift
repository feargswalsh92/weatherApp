//
//  ViewController.swift
//  weatherApp
//
//  Created by Feargal Walsh on 11/6/16.
//  Copyright © 2016 Feargal Walsh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!
   
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func submitButton(_ sender: AnyObject) {
    let url = URL(string: "http://www.weather-forecast.com/locations/" + city.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")!
        
        let request = NSMutableURLRequest(url: url)
        var message = ""
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data,response,error in
            if error != nil {
                print(error)
            }
            else {
                if let unwrappedata = data {
                    
        let dataString = NSString(data: unwrappedata, encoding: String.Encoding.utf8.rawValue)
                    
        var stringSeperator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                    if let contentArray = dataString?.components(separatedBy: stringSeperator) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeperator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeperator)
                            
                            
                            if newContentArray.count > 1 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;",with:"°")
                                
                                print(message)
                            }
                        }
                    }
                }
                
            }
            
            if message == "" {
                
                message = "The weather there couldn't be found. Please try again."
                
            }
            
            DispatchQueue.main.sync(execute: {
                
                self.resultLabel.text = message
                
            })
            
        }
        
        task.resume()
    
//    } else {
//    
//       resultLabel.text = "The weather there couldn't be found. Please try again."
//    
//    }
//        // Do any additional setup after loading the view, typically from a nib.
//
//    }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

