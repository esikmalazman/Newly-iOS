//
//  ViewController.swift
//  Newly
//
//  Created by Ikmal Azman on 22/10/2021.
//

import UIKit
import VisionKit

final class HomepageVC : UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var identifyBtn: UIButton!
    @IBOutlet var contentView: UIView!
    
    //MARK: - Variables
    private let presenter = HomepagePresenter()
    private var containerVC : HomePageContainerVC {
        get {
            let storyboard = storyboard?.instantiateViewController(withIdentifier: HomePageContainerVC.identifier) as! HomePageContainerVC
            return storyboard
        }
    }
    
    var history = [History]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
//        let reload = NSNotification.Name("reload")
//        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: reload, object: nil)
        
    }
    
    static func instantiate() -> HomepageVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomePageVC") as! HomepageVC
    }
    
//    @objc func reloadData() {
//        tableView.reloadData()
//    }
}

//MARK: - TV Datasource
extension HomepageVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if history.count > 0 {
            contentView.removeFromSuperview()
        }
        print("Object count in array : \(history.count)")
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyObj = history[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as! HistoryCell
        cell.setCell(configuration: historyObj)
        return cell
    }
}
//MARK: - TV Delegate
extension HomepageVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension HomepageVC : HomepagePresenterDelegate {}

extension HomepageVC : IdentifyNewsVCDelegate {
    func addNewHistory(view: IdentifyNewsVC, _ historyData: History) {
        history.append(historyData)
        tableView.reloadData()
    }
}

//MARK: - Private method
extension HomepageVC {
    private func renderView() {
        tableView.register(HistoryCell.nib(), forCellReuseIdentifier: HistoryCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        identifyBtn.layer.cornerRadius = 15
        identifyBtn.backgroundColor = .primaryPurple
        identifyBtn.tintColor = .white
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.primaryPurple]
        
//        let identifyVC = IdentifyNewsVC.instantiate()
//        identifyVC.delegate = self
    }
}

