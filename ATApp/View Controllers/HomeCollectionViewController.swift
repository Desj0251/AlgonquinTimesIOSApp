//
//  HomeCollectionViewController.swift
//  ATApp
//
//  Created by John Desjardins on 2018-04-06.
//  Copyright © 2018 Algonquin College. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SomeId"



class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {}

    var jsonArray: [[String:Any]]?
    
    // Global Declerations --------------------------------
    let searchBar = UISearchBar()
    var filteredData: [[String: Any]]?
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    var titleString = "Articles"
    let navigationTitlelabel = UILabel(frame: CGRect(x: 0,y: 0, width: 200, height: 21))
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(videoCell.self, forCellWithReuseIdentifier: "CellId")
        
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
            self.collectionView?.reloadData()
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
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.75
        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        settingView.dataSource = self
        settingView.delegate = self
        settingView.register(FilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBarStyle.minimal
        searchBar.showsCancelButton = true
        searchBar.textColor = UIColor.white
        
    }
    
    // UI Setup --------------------------------
    private func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = ((collectionView?.frame.width)! / 2) - (width / 2)
        let y = ((collectionView?.frame.height)! / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
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
        
        collectionView?.addSubview(loadingView)
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
        showSettings()
    }
    
    @objc func handleSearch() {
        showSearchBar()
    }
    
    private func removeLoadingScreen() {
        self.navigationItem.leftBarButtonItem?.isEnabled = true;
        self.navigationItem.rightBarButtonItem?.isEnabled = true;
        collectionView?.isUserInteractionEnabled = true
        
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
    }
    
    func hideSearchBar() {
        searchBar.isHidden =  true
        setupNavBarButtons()
        
        self.navigationItem.titleView?.alpha = 1
    }
    
    // Filter View Controls --------------------------------
    let settingView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    let blackView = UIView()
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.75)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(settingView)
            let cellHeight: CGFloat = window.frame.height * 0.75
            let y = window.frame.height - cellHeight
            settingView.frame = CGRect(x: 0,y: window.frame.height, width: window.frame.width, height: cellHeight)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.settingView.frame = CGRect(x: 0, y: y, width: self.settingView.frame.width, height: self.settingView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.settingView.frame = CGRect(x: 0, y: window.frame.height, width: self.settingView.frame.width, height: self.settingView.frame.height)
            }
        })
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
        self.collectionView?.reloadData()
    }
    
    // Collection View Controls --------------------------------
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            if let articles = filteredData?.count {
                return articles
            }
            return 0
        } else {
            return settings.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! videoCell
            cell.article = filteredData?[indexPath.row]
            return cell
        } else {
            let cell = settingView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FilterCell
            let setting = settings[indexPath.item]
            cell.setting = setting
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            let height = (view.frame.width - 16 - 16) * 9 / 16
            return CGSize(width: view.frame.width, height: height + 16 + 88)
        } else {
            return CGSize(width: view.frame.width, height: cellHeight)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            
            self.performSegue(withIdentifier: "showArticle", sender: filteredData?[indexPath.row])
            
        }
        else {
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
                    self.collectionView?.reloadData()
                }
            } else {
                handleDismiss()
                filteredData = jsonArray
                self.titleString = "Articles"
                navigationTitlelabel.text = self.titleString
                self.navigationController!.navigationBar.topItem!.titleView = navigationTitlelabel
                self.collectionView?.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticle" {
            guard let object = sender as? [String: Any] else { return }
            let dvc = segue.destination as! ArticleViewController
            dvc.article = object
        }
    }
    
}
