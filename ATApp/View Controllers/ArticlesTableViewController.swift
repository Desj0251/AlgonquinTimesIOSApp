//
//  TableViewController.swift
//  Articles View
//
//  Created by John Desjardins on 2018-01-25.
//  Copyright © 2018 John Desjardins. All rights reserved.
//

import UIKit

// Custom Classes --------------------------------
class Setting: NSObject {
    let name: String
    let imageName: String
    let id: Int
    
    init(name: String, id: Int, imageName: String) {
        self.name = name
        self.id = id
        self.imageName = imageName
    }
}

// Global Declerations --------------------------------
let imageCache = NSCache<AnyObject, AnyObject>()

class ArticlesTableViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Global Declerations --------------------------------
    var jsonArray: [[String:Any]]?
    let searchBar = UISearchBar()
    var filteredData: [[String: Any]]?
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    var titleString = "Articles"
    let navigationTitlelabel = UILabel(frame: CGRect(x: 0,y: 0, width: 200, height: 21))
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    let blackView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    let settings: [Setting] = {
        return[Setting(name: "All", id: 0, imageName: "help"),
               Setting(name: "Activities", id: 1252, imageName: "help"),
               Setting(name: "Advertise with Us", id: 1173, imageName: "help"),
               Setting(name: "Algonquin Reads", id: 1226, imageName: "help"),
               Setting(name: "Blog", id: 1310, imageName: "help"),
               Setting(name: "Careers", id: 2, imageName: "help"),
               Setting(name: "Classifieds", id: 1176, imageName: "help"),
               Setting(name: "Entertainment", id: 3, imageName: "help"),
               Setting(name: "Featured Stories", id: 1311, imageName: "help"),
               Setting(name: "Focus", id: 10, imageName: "help"),
               Setting(name: "Full Editions", id: 593, imageName: "help"),
               Setting(name: "Gallery", id: 1145, imageName: "help"),
               Setting(name: "Gallery Pages", id: 4, imageName: "help"),
               Setting(name: "Innovations", id: 5, imageName: "help"),
               Setting(name: "Life", id: 6, imageName: "help"),
               Setting(name: "News", id: 7, imageName: "help"),
               Setting(name: "Off Campus", id: 8, imageName: "help"),
               Setting(name: "Opinions", id: 9, imageName: "help"),
               Setting(name: "People", id: 1626, imageName: "help"),
               Setting(name: "Place an Ad", id: 1246, imageName: "help"),
               Setting(name: "Social Events", id: 1309, imageName: "help"),
               Setting(name: "Sports", id: 11, imageName: "help"),
               Setting(name: "Submissions", id: 1623, imageName: "help"),
               Setting(name: "Technology", id: 1627, imageName: "help"),
               Setting(name: "Times Capsule", id: 1584, imageName: "help"),
               Setting(name: "Uncategorized", id: 1, imageName: "help"),
               Setting(name: "Video", id: 12, imageName: "help")]
    }()
    
    // onLoad and onAppear --------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupNavBarButtons()
        setLoadingScreen()
        moreSetUp()
        setupFetch()
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false;
        self.navigationItem.rightBarButtonItem?.isEnabled = false;
    }

    // QoL functions --------------------------------
    func cleanTheTitle(title: String) -> String {
        return title.replacingOccurrences(of: "&#8211;", with: "-", options: .literal, range: nil).replacingOccurrences(of: "&#038;", with: "&", options: .literal, range: nil).replacingOccurrences(of: "&#8217;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#8216;", with: "'", options: .literal, range: nil).replacingOccurrences(of: "&#233;", with: "é", options: .literal, range: nil).replacingOccurrences(of: "&#8230;", with: "...", options: .literal, range: nil).replacingOccurrences(of: "&#8212;", with: "--", options: .literal, range: nil)
    }
    
    // Data Fetch Requests --------------------------------
    func setupFetch() {
        let requestUrl: URL = URL(string: "http://algonquintimes.com/wp-json/wp/v2/posts?per_page=100&_embed=true")!
        let myRequest: URLRequest = URLRequest(url: requestUrl)
        let mySession: URLSession = URLSession.shared
        let myTask = mySession.dataTask(with: myRequest, completionHandler: requestTask)
        myTask.resume()
    }
    
    func requestTask (serverData: Data?, serverResponse: URLResponse?, serverError: Error?) -> Void {
        if serverError != nil {
            self.myCallback(responseString: "", error: serverError?.localizedDescription)
        }else{
            let result = String(data: serverData!, encoding: .utf8)!
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
                    filteredData = jsonArray
                } catch let convertError {
                    print(convertError.localizedDescription)
                }
            }
        }
        DispatchQueue.main.async() {
                self.removeLoadingScreen()
                self.tableView.reloadData()
        }
    }
    
    // UI Setup --------------------------------
    func setupNavBarButtons() {
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "help"), style: .plain, target: self, action: #selector(handleMore))
        
        moreButton.tintColor = UIColor.white
        searchBarButtonItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = moreButton
        navigationItem.leftBarButtonItem = searchBarButtonItem
        
        navigationTitlelabel.center = CGPoint(x: 160, y: 284)
        navigationTitlelabel.textAlignment = NSTextAlignment.center
        navigationTitlelabel.textColor  = UIColor.white
        navigationTitlelabel.text = self.titleString
        navigationTitlelabel.font = UIFont.boldSystemFont(ofSize: 19.0)
        self.navigationController!.navigationBar.topItem!.titleView = navigationTitlelabel
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func moreSetUp() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FilterCell.self, forCellWithReuseIdentifier: cellId)
        
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.showsCancelButton = true
        searchBar.textColor = UIColor.white
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 140.0;
    }
    
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
    
    func showSearchBar() {
        searchBar.isHidden =  false
        searchBar.alpha = 0
        navigationItem.titleView = searchBar
        searchBar.tintColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        
        self.searchBar.alpha = 1
        self.searchBar.becomeFirstResponder()
    }
    
    // onHandle or Dismiss Functions --------------------------------
    @objc func handleMore() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(collectionView)
            let cellHeight: CGFloat = window.frame.height / 2
            let y = window.frame.height - cellHeight
            collectionView.frame = CGRect(x: 0,y: window.frame.height, width: window.frame.width, height: cellHeight)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        })
    }
    
    @objc func handleSearch() {
        showSearchBar()
    }
    
    private func removeLoadingScreen() {
        self.navigationItem.leftBarButtonItem?.isEnabled = true;
        self.navigationItem.rightBarButtonItem?.isEnabled = true;
        tableView.isUserInteractionEnabled = true
        self.tableView.separatorStyle = .singleLine
        
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
    }

    func hideSearchBar() {
        searchBar.isHidden =  true
        setupNavBarButtons()
        
        self.navigationItem.titleView?.alpha = 1
    }
    
    // SearchBar Controls --------------------------------
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        titleString = "Articles"
        filteredData = searchText.isEmpty ? jsonArray : jsonArray?.filter { (item: [String: Any]) -> Bool in
            let title = item["title"] as? [String: Any]
            let titleRendered = title?["rendered"] as? String
            let cleanTitle = cleanTheTitle(title: titleRendered!)
            return cleanTitle.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {}
    
    // CollectionView Controls --------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FilterCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = settings[indexPath.item]
        self.searchBar.text = ""
        
        if setting.id != 0 {
            // Code here for Filtering
            let categoryFilter = jsonArray?.filter { (item: [String: Any]) -> Bool in
                let ids = item["categories"] as? [Int]
                for nums in ids! {
                    if (nums == setting.id) { return true }
                }
                return false
            }
            handleDismiss()
            if (categoryFilter?.isEmpty)! {
                let refreshAlert = UIAlertController(title: "No Articles Found", message: "Did not find any Articles with the category \"\(setting.name)\"!", preferredStyle: UIAlertControllerStyle.alert)
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    // print("Handle Ok logic here")
                }))
                present(refreshAlert, animated: true, completion: nil)
            } else {
                filteredData = categoryFilter
                self.titleString = setting.name
                navigationTitlelabel.text = self.titleString
                self.navigationController!.navigationBar.topItem!.titleView = navigationTitlelabel
                tableView.reloadData()
            }
        } else {
            handleDismiss()
            filteredData = jsonArray
            self.titleString = "Articles"
            navigationTitlelabel.text = self.titleString
            self.navigationController!.navigationBar.topItem!.titleView = navigationTitlelabel
            tableView.reloadData()
        }
    }
    
    // TableView Controls --------------------------------
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for:
            indexPath) as! ArticleTableViewCell
        
        if let eventInfo = filteredData?[indexPath.row] {
            let title = eventInfo["title"] as? [String: Any]
            let titleRendered = title?["rendered"] as? String
            let cleanTitle = cleanTheTitle(title: titleRendered!)
            cell.bioLabel.text = cleanTitle
            
            let embedded = eventInfo["_embedded"] as? [String: Any]
            let author = embedded!["author"] as? [[String: Any]]
            cell.nameLabel.text = author![0]["name"] as? String
            
            if let media = embedded!["wp:featuredmedia"] as? [[String: Any]] {
                let mediaDetails = media[0]["media_details"] as? [String: Any]
                let sizes = mediaDetails!["sizes"] as? [String: Any]
                let large = sizes!["thumbnail"] as? [String: Any]
                let imageUrl = large!["source_url"] as? String
                let url = URL(string: imageUrl!)
                
                if let imageFromCache = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage{
                    cell.articleImageView.image = imageFromCache
                } else {
                    DispatchQueue.main.async {
                        let data = try? Data(contentsOf: url!)
                        let articleimage = UIImage(data: data!)
                        imageCache.setObject(articleimage!, forKey: imageUrl as AnyObject)
                        cell.articleImageView.image = articleimage
                    }
                }
            } else {
                cell.articleImageView.image = UIImage(named: "404")
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let events = filteredData?.count {
            return events
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            filteredData?.remove(at:indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Segues --------------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showArticle" {
            let eventVC = segue.destination as? ArticleViewController
            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            eventVC?.article = (filteredData?[indexPath.row])!
        }
    }
    
}
