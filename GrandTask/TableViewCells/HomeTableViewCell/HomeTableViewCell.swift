//
//  HomeTableViewCell.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/16/23.
//

import UIKit
import CoreData

class HomeTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var weakLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusTitleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(data : Matches) {
        homeTeamNameLabel.text = data.homeTeam?.name
        awayTeamNameLabel.text = data.awayTeam?.name
        weakLabel.text = "weak 1"
        startTimeLabel.text = "Today"
        resultLabel.text = "\(data.score?.fullTime?.homeTeam ?? 0) - \(data.score?.fullTime?.awayTeam ?? 0)"
        let dataFormatterGet = DateFormatter()
        dataFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        if let date = dataFormatterGet.date(from: data.utcDate ?? "") {
            print(dateFormatterPrint.string(from: date))
            dateLabel.text = "Started At \(dateFormatterPrint.string(from: date))"
        } else {
           print("There was an error decoding the string")
        }
        statusTitleLabel.text = data.status
    }
    
    func setupOfflineData(model : NSManagedObject) {
        homeTeamNameLabel.text = model.value(forKey: "homeTeam") as? String
        awayTeamNameLabel.text = model.value(forKey: "awayTeam") as? String
        weakLabel.text = "weak 1"
        startTimeLabel.text = "Today"
        resultLabel.text = model.value(forKey: "result") as? String
        dateLabel.text = "Started At \(model.value(forKey: "date") as? String ?? "")"
        statusTitleLabel.text = model.value(forKey: "status") as? String
    }
}
