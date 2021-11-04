//
//  HistoryCell.swift
//  Newly
//
//  Created by Ikmal Azman on 05/11/2021.
//

import UIKit

final class HistoryCell: UITableViewCell {

    @IBOutlet private var categoryLabel: UILabel!
    @IBOutlet private var textPlaceholderLabel: UILabel!
    
    //MARK: - Variables
    static let identifier = "HistoryCell"
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
        textPlaceholderLabel.text = nil
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "HistoryCell", bundle: nil)
    }
    
    func setCell(configuration data: History) {
        categoryLabel.text = data.category
        textPlaceholderLabel.text = data.fullText
    }
    
    
    
    
    
}
