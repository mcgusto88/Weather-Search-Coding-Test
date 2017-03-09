//
//  AWWeatherResultsCell.swift
//  AWCodingAssessmentBBVA
//
//  Created by Augustus on 3/8/17.
//  Copyright © 2017 Augustus. All rights reserved.
//

import UIKit

class AWWeatherResultsCell: UITableViewCell {

    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
