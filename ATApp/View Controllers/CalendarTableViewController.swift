//
//  CalendarTableViewController.swift
//  ATApp
//
//  Created by Christian Jurt on 2018-04-03.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

class CalendarTableViewController: UITableViewController {

    var jsonArray: [[String:Any]]?
    var monthAbb = ""
    var monthAbb1 = ""
    var monthAbb2 = ""
    var monthAbb3 = ""
    var monthAbb4 = ""
    var monthAbb5 = ""
    var monthAbb6 = ""
    var monthAbb7 = ""
    var monthAbb8 = ""
    var monthAbb9 = ""
    var monthAbb10 = ""
    var monthAbb11 = ""
    
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    func requestTask (serverData: Data?, serverResponse: URLResponse?, serverError: Error?) -> Void{
        if serverError != nil {
            self.myCallback(responseString: "", error: serverError?.localizedDescription)
        }else{
            var result = String(data: serverData!, encoding: .utf8)!
            
            var omitStart = result
            
            let lowBound = result.index(result.startIndex, offsetBy: 0)
            let hiBound = result.index(result.startIndex, offsetBy: 10)
            let midRange = lowBound ..< hiBound
            omitStart.removeSubrange(midRange) //[result]
            
            var omitEnd = omitStart
            
            let lowBound1 = result.index(omitStart.endIndex, offsetBy: -189)
            let hiBound1 = result.index(omitStart.endIndex, offsetBy: 0)
            let midRange1 = lowBound1 ..< hiBound1
            omitEnd.removeSubrange(midRange1) //[result]
            
            result = omitEnd
            
            self.myCallback(responseString: result as String, error: nil)
        }
    }
    
    func myCallback(responseString: String, error: String?) {
        if error != nil {
            print("ERROR is " + error!)
        }else{
            if let myData: Data = responseString.data(using: String.Encoding.utf8) {
                do {
                    jsonArray = try JSONSerialization.jsonObject(with: myData, options: []) as? [[String:Any]]
                } catch let convertError {
                    print(convertError.localizedDescription)
                }
            }
        }
        DispatchQueue.main.async()
            {
                self.removeLoadingScreen()
                self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoadingScreen()
        
        setNav()
        
        self.tableView.separatorColor = UIColor.forestGreen
        let requestUrl: URL = URL(string: "http://www.algonquinsa.com/wp-json/tribe/events/v1/events?per_page=100")!
        let myRequest: URLRequest = URLRequest(url: requestUrl)
        let mySession: URLSession = URLSession.shared
        let myTask = mySession.dataTask(with: myRequest, completionHandler: requestTask)
        myTask.resume()
        
    }
    
    func setNav() {
        let navigationTitlelabel = UILabel(frame: CGRect(x: 0,y: 0, width: 200, height: 21))
        navigationTitlelabel.center = CGPoint(x: 160, y: 284)
        navigationTitlelabel.textAlignment = NSTextAlignment.center
        navigationTitlelabel.textColor  = UIColor.white
        navigationTitlelabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        navigationTitlelabel.text = "Calendar"
        
        self.navigationController!.navigationBar.topItem!.titleView = navigationTitlelabel
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as?
            CalendarTableViewCell  else {
                fatalError("The dequeued cell is not an instance of TableViewCell.")
        }
        
        if let eventInfo = jsonArray?[indexPath.row] {
            
            let title = eventInfo["title"] as? String
            var startDate = eventInfo["start_date"] as? String
            
            var month = eventInfo["start_date"] as? String
            
            let lowBound5 = month!.index(month!.startIndex, offsetBy: 0)
            let hiBound5 = month!.index(month!.startIndex, offsetBy: 5)
            let midRange5 = lowBound5 ..< hiBound5
            month!.removeSubrange(midRange5) //[result]
            
            let lowBound6 = month!.index(month!.endIndex, offsetBy: -12)
            let hiBound6 = month!.index(month!.endIndex, offsetBy: 0)
            let midRange6 = lowBound6 ..< hiBound6
            month!.removeSubrange(midRange6) //[result]
            
            let monthConversion = month
            
            let lowBound3 = startDate!.index(startDate!.startIndex, offsetBy: 0)
            let hiBound3 = startDate!.index(startDate!.startIndex, offsetBy: 8)
            let midRange3 = lowBound3 ..< hiBound3
            startDate!.removeSubrange(midRange3) //[result]
            
            let lowBound4 = startDate!.index(startDate!.endIndex, offsetBy: -9)
            let hiBound4 = startDate!.index(startDate!.endIndex, offsetBy: 0)
            let midRange4 = lowBound4 ..< hiBound4
            startDate!.removeSubrange(midRange4) //[result]
            
            
            let cleanTitle = title?.replacingOccurrences(of: "&#8211;", with: "-", options: .literal, range: nil).replacingOccurrences(of: "&#038;", with: "&", options: .literal, range: nil).replacingOccurrences(of: "&#8217;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#8216;", with: "'", options: .literal, range: nil)
            
            cell.descriptionLabel.numberOfLines = 2
            cell.dayLabel!.text = startDate
            cell.descriptionLabel!.text = cleanTitle
            
            switch monthConversion
            {
            case "01"?:
                monthAbb = "JAN"
                cell.monthLabel!.text = monthAbb
            case "02"?:
                monthAbb1 = "FEB"
                cell.monthLabel!.text = monthAbb1
            case "03"?:
                monthAbb2 = "MAR"
                cell.monthLabel!.text = monthAbb2
            case "04"?:
                monthAbb3 = "APR"
                cell.monthLabel!.text = monthAbb3
            case "05"?:
                monthAbb4 = "MAY"
                cell.monthLabel!.text = monthAbb4
            case "06"?:
                monthAbb5 = "JUN"
                cell.monthLabel!.text = monthAbb5
            case "07"?:
                monthAbb6 = "JUL"
                cell.monthLabel!.text = monthAbb6
            case "08"?:
                monthAbb7 = "AUG"
                cell.monthLabel!.text = monthAbb7
            case "09"?:
                monthAbb8 = "SEP"
                cell.monthLabel!.text = monthAbb8
            case "10"?:
                monthAbb9 = "OCT"
                cell.monthLabel!.text = monthAbb9
            case "11"?:
                monthAbb10 = "NOV"
                cell.monthLabel!.text = monthAbb10
            case "12"?:
                monthAbb11 = "DEC"
                cell.monthLabel!.text = monthAbb11
            default:
                print("there ius no date")
            }
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let events = jsonArray?.count {
            return events
        }
        return 0
    }
    
    // Set the activity indicator into the main view
    private func setLoadingScreen() {
        
        tableView.isUserInteractionEnabled = false
        self.tableView.separatorStyle = .none
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        
        // Sets spinner
        spinner.activityIndicatorViewStyle = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        
        tableView.addSubview(loadingView)
        
    }
    
    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        
        tableView.isUserInteractionEnabled = true
        self.tableView.separatorStyle = .singleLine
        
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "EventDetail" {
            let eventVC = segue.destination as? CalendarViewController
            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            eventVC?.events = jsonArray?[indexPath.row]
        }
    }

}
