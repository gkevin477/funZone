//
//  NotesCollectionViewCell.swift
//  funZone
//
//  Created by admin on 6/4/22.
//

import UIKit

class NotesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelView: UILabel!
    static let identifier = "NotesCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(with text: String){
        labelView.numberOfLines = 0
        labelView.text = text
    }
    static func nib() -> UINib{
        return UINib.init(nibName: identifier, bundle: nil)
    }

}
