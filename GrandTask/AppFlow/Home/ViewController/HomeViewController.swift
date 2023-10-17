//
//  HomeeViewController.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/16/23.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

class HomeViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var calendarTableView: UITableView!
    // MARK: - private valriables
    private var header = ZVRefreshNormalHeader()
    private var footer = ZVRefreshBackAnimationFooter()
    var matchesCoreData = [NSManagedObject]()
    // MARK: - shared valriables
    var firstPage = true
    let disposeBag = DisposeBag()
    let viewModel = HomeViewModel()
    var DayArray = [DayModel]()
    var matchesData = [Matches]()
    var current_matchday = 1
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        if Helper.getCheckNetwork() == "Offline" {
            self.matchesCoreData = getMatches()
        }else{
            emptyMatches()
            viewModel.GetMatches(matchday: 1)
        }
        initObjects()
        addDataHandler()
        SubscribeMatchesData()
        SubscribeLoading()
        NotificationCenter.default.addObserver(self, selector: #selector(offlineMode), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    // MARK: - Private functions
    private func initObjects(){
        firstPage = true
        matchesData.removeAll()
        DayArray.removeAll()
    }
    private func addDataHandler() {
        header.refreshHandler = { [self] in
            initObjects()
            footer.isNoMoreData = false
            if Helper.getCheckNetwork() == "Offline" {
                
            }else{
                viewModel.GetMatches(matchday: 1)
            }
        }
        calendarTableView.header = self.header
        footer.refreshHandler = { [self] in
            firstPage = false
            if (current_matchday + 1) <= 38 {
                if Helper.getCheckNetwork() == "Offline" {
                    footer.isNoMoreData = true
                }else{
                    viewModel.GetMatches(matchday: (current_matchday + 1))
                }
            }else{
                footer.isNoMoreData = true
            }
        }
        calendarTableView.footer = footer
    }
    private func updateList(data : [Matches]){
        for day in data {
            if !(matchesData.contains(where: { $0.matchday == day.matchday })) {
                matchesData.append(day)
            }
        }
        calendarTableView.header?.endRefreshing()
        calendarTableView.footer?.endRefreshing()
        calendarTableView.reloadData()
    }
    private func SubscribeLoading(){
        viewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                BGLoading.showLoading(self.view)
            }else{
                BGLoading.dismissLoading()
            }
        }).disposed(by: disposeBag)
    }
    private func SubscribeMatchesData() {
        viewModel.homeModelObservable.subscribe(onNext: { (data) in
            self.current_matchday = Int(data.filters?.matchday ?? "") ?? 1
            self.DayArray.append(DayModel(date: data.matches?.first?.utcDate , matches: data.matches ?? []))
            self.updateList(data: data.matches ?? [])
            self.calendarTableView.reloadData()
        }).disposed(by: disposeBag)
    }
    // MARK: - TableView Setup
    private func setupTableView(){
        calendarTableView.delegate = self
        calendarTableView.dataSource = self
        calendarTableView.RegisterNib(cell: HomeTableViewCell.self)
        calendarTableView.RegisterNib(cell: HomeHeaderTableViewCell.self)
        calendarTableView.reloadData()
    }
    // MARK: - Objc functions
    @objc func offlineMode(notification: NSNotification){
        Helper.SaveCheckNetwork(check: "Offline")
        self.current_matchday = 1
        firstPage = true
        matchesData.removeAll()
        DayArray.removeAll()
        self.calendarTableView.reloadData()
    }
    // MARK: - IBAction functions
}
// MARK: - TableView Delegate Datasource
extension HomeViewController : UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if Helper.getCheckNetwork() == "Offline" {
            return 1
        }else{
            return self.DayArray.count
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "HomeHeaderTableViewCell") as! HomeHeaderTableViewCell
        if Helper.getCheckNetwork() == "Offline" {
            headerView.dayLabel.text = "Today"
            headerView.timeLabel.text = ""
        }else{
            headerView.setupData(data: (self.DayArray[section]))
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Helper.getCheckNetwork() == "Offline" {
            return matchesCoreData.count
        }else{
            return self.DayArray[section].matches?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell" , for: indexPath) as! HomeTableViewCell
        if Helper.getCheckNetwork() == "Offline" {
            let offlineModel = matchesCoreData[indexPath.row]
            cell.setupOfflineData(model: offlineModel)
        }else{
            let Model = DayArray[indexPath.section].matches?[indexPath.row]
            cell.setupData(data: Model!)
            // Save the match in core data
            self.addToMatches(id: "\(RandomNumberGenerator.self)", status: Model?.status ?? "" , result: "\(Model?.score?.fullTime?.homeTeam ?? 0) - \(Model?.score?.fullTime?.awayTeam ?? 0)", homeTeam: Model?.homeTeam?.name ?? "", date: "Today", awayTeam: Model?.awayTeam?.name ?? "")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
