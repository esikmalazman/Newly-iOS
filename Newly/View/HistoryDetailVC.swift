//
//  HistoryDetailVC.swift
//  Newly
//
//  Created by Ikmal Azman on 06/11/2021.
//

import UIKit

class HistoryDetailVC: UIViewController {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var categoryDetailLabel: UILabel!
    @IBOutlet private weak var textDetailLabel: UILabel!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
    }
    //MARK: - Variables
    static let segueIdentifier = "goToHistory"
    
    private var category = ""
    private var text = ""

    func setVCProperties(data : History) {
        category = data.category
        text = data.fullText
    }
    private func renderView() {
        contentView.layer.cornerRadius = 15
        categoryDetailLabel.text = category
        textDetailLabel.text = text
    }

}
