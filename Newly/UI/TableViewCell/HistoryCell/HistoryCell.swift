//
//  HistoryCell.swift
//  Newly
//
//  Created by Ikmal Azman on 05/11/2021.
//

import UIKit

final class HistoryCell : UITableViewCell {
    //MARK: - Outlets
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var textPlaceholderLabel: UILabel!
    
    //MARK: - Variables
    static let identifier = "HistoryCell"
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryLabel.textColor = .white
        textPlaceholderLabel.textColor = .white
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .primaryPurple
        let padding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        contentView.frame = contentView.frame.inset(by: padding)
        contentView.dropShadow()
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
