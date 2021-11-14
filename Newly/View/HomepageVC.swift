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
    @IBOutlet weak var contentView: UIView!
    
    //MARK: - Variables
    private let presenter = HomepagePresenter()
    private var containerVC : HomePageContainerVC {
        get {
            let storyboard = storyboard?.instantiateViewController(withIdentifier: HomePageContainerVC.identifier) as! HomePageContainerVC
            return storyboard
        }
    }
    private var selectedRow : Int?
    
    var history = [History]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    
    static func instantiate() -> HomepageVC {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomePageVC") as! HomepageVC
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == IdentifyNewsVC.segueIdentifier {
            let destinationVC = segue.destination as! IdentifyNewsVC
            destinationVC.delegate = self
        } else if segue.identifier == HistoryDetailVC.segueIdentifier {
            let desinationVC = segue.destination  as! HistoryDetailVC
            desinationVC.setVCProperties(data: history[selectedRow ?? 0])
        }
    }
}

//MARK: - TV Datasource
extension HomepageVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if history.count > 0 {
            contentView.removeFromSuperview()
        } else {
            view.addSubview(contentView)
        }
        debugPrint("Object count in array : \(history.count)")
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyObj = history[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell else {
            fatalError("Could not load history object")
        }
        cell.selectionStyle = .none
        cell.setCell(configuration: historyObj)
        return cell
    }
}
//MARK: - TV Delegate
extension HomepageVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapRowAt(indexPath)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 0, width: 200, height: 30)
        label.numberOfLines = 0
        label.textColor = .primaryPurple
        label.text = "History"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
        let headerView = UIView()
        headerView.addSubview(label)
        
        return headerView
    }
}

//MARK: - HomePresenterDelegate
extension HomepageVC : HomepagePresenterDelegate {
    
    func presentHistoryDetail(_ indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: HistoryDetailVC.segueIdentifier, sender: self)
    }
}

//MARK: - IdentifyNewsDelegate
extension HomepageVC : IdentifyNewsVCDelegate {
    func addNewHistory(view: IdentifyNewsVC, _ historyData: History) {
        history.append(historyData)
        tableView.reloadData()
    }
}

//MARK: - Private method
extension HomepageVC {
    private func renderView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = 200
        tableView.register(HistoryCell.nib(), forCellReuseIdentifier: HistoryCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        identifyBtn.layer.cornerRadius = 15
        identifyBtn.backgroundColor = .white
        identifyBtn.tintColor = .primaryPurple
        identifyBtn.layer.borderWidth = 3
        identifyBtn.layer.borderColor = UIColor.primaryPurple.cgColor
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.primaryPurple]
        
        presenter.setViewDelegate(delegate: self)
    }
}

