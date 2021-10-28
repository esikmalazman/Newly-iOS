//
//  ViewController.swift
//  Newly
//
//  Created by Ikmal Azman on 22/10/2021.
//

import UIKit
import VisionKit

final class HomepageVC : UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var identifyBtn: UIButton!
    
    private let presenter = HomepagePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func identifyBtnTap(_ sender: UIButton) {
    
    }
    

    
}

extension HomepageVC : HomepagePresenterDelegate {}




