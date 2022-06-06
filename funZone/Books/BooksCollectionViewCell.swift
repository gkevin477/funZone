//
//  SongsCollectionViewCell.swift
//  funZone
//
//  Created by admin on 6/1/22.
//

import UIKit

class BooksCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "BooksCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(with image: UIImage){
        imageView.image = image
    }
    static func nib() -> UINib{
        return UINib.init(nibName: identifier, bundle: nil)
    }

}
