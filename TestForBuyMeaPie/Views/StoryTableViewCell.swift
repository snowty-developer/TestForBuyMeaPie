//
//  StoryTableViewCell.swift
//  TestForBuyMeaPie
//
//  Created by Александр Зубарев on 02.03.2021.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfStory: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell (_ title: String, _ image: UIImage?) {
        titleLabel.text = title
        imageOfStory.image = image
    }

}
