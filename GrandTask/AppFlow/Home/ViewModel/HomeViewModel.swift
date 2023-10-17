//
//  HomeViewModel.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/16/23.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import PromiseKit

class HomeViewModel {
    // MARK: - public valriables
    var loadingBehavior   = BehaviorRelay<Bool>(value: false)
    var isDataEmpty = BehaviorRelay<Bool>(value: false)
    var homeModelObservable : Observable<HomeModel> {
        return homeModelSubject
    }
    // MARK: - private valriables
    private var homeModelSubject = PublishSubject<HomeModel>()
    private let homeServices = MoyaProvider<Services>()
    // MARK: - API Services
    func GetMatches(matchday : Int) {
        firstly { () -> Promise<Any> in
            loadingBehavior.accept(true)
            return BGServicesManager.CallApi(self.homeServices,Services.matches(matchday: matchday))
        }.done({ response in
            let result = response as! Response
            let data : HomeModel = try BGDecoder.decode(data: result.data)
            self.homeModelSubject.onNext(data)
        }).ensure {
            self.loadingBehavior.accept(false)
        }.catch { (error) in
            print(error)
            BGAlertPresenter.displayToast(title: "Error" , message: "\(error)")
        }
    }
}
