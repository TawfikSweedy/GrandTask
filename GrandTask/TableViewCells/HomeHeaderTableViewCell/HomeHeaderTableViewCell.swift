//
//  HomeHeaderTableViewCell.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/16/23.
//

import UIKit

class HomeHeaderTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(data : DayModel) {
        let dataFormatterGet = DateFormatter()
        dataFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dayFormatterPrint = DateFormatter()
        dayFormatterPrint.dateFormat = "EEEE"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"

        if let day = dataFormatterGet.date(from: data.date ?? "" ) {
            print(dayFormatterPrint.string(from: day))
            dayLabel.text = dayFormatterPrint.string(from: day)
        } else {
           print("There was an error decoding the string")
        }
        
        if let date = dataFormatterGet.date(from: data.date ?? "") {
            print(dateFormatterPrint.string(from: date))
            timeLabel.text = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        
    }
    
}
