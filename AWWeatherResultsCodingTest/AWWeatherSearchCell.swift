//
//  AWWeatherSearchCell.swift
//  AWCodingAssessmentBBVA
//
//  Created by Augustus on 3/8/17.
//  Copyright © 2017 Augustus. All rights reserved.
//

import UIKit
protocol ButtonActionProtocol {
    func performActionOnButtonClick()
}

class AWWeatherSearchCell: UITableViewCell {
    var delegate:ButtonActionProtocol! = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func SearchBtn(_ sender: Any) {
        self.delegate.performActionOnButtonClick()
    }
    @IBOutlet weak var searchTF: UITextField!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
