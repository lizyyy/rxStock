//
//  ViewController.swift
//  stock
//
//  Created by zhiyuan10 on 2018/1/10.
//  Copyright © 2018年 钱宝. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import RxCocoa
import RxDataSources
import Then
import MJRefresh

class ViewController: UIViewController {
    var searchResult : UITableView!
    var bag:DisposeBag! = DisposeBag()
    typealias SectionTableMode = SectionModel<String,ListModel>
    let result = [ListModel]();
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResult  = UITableView(frame: CGRect(x:0, y:49, width:ScreenW, height:ScreenH),style:.plain)
        searchResult.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.ReuseIdentifier)
        self.view.addSubview(searchResult)
        let todoId: Int? = nil
        Observable.of(todoId)
            .flatMap { route in
                return self.searchForGithub(repositoryName: "")
            }
            .subscribe(
                onNext:{ rs in
                    let a = Observable<[ListModel]>.just(rs)
                    a.bind(to: self.searchResult.rx.items(cellIdentifier: ListTableViewCell.ReuseIdentifier, cellType: ListTableViewCell.self)) { (_, model:ListModel, cell:ListTableViewCell) in
                            cell.nameLabel?.text = model.name
                        }.disposed(by: self.bag)
                }
            )
            .disposed(by: bag)
    }
}

typealias rsInfo = Dictionary<String,AnyObject>
extension ViewController{
    private func searchForGithub(repositoryName: String) -> Observable<[ListModel]> {
        return Observable.create {
            (observer: AnyObserver<[ListModel]>) -> Disposable in
            let provider = MoyaProvider<StockApi>()
            _ = provider.rx.request(.GetStocks(code:"00365,01727,02318,00700,03968,02319,NQ,KODK,VIPS,SH603868,SH601933,SH603711,RYB,XNET,SZ000001,SZ000725,JT,JNJ,ATVI,TTWO,SZ002310,SOGO,SZ000538,SZ000799,SZ002230,SZ002271,OC833209,AMD,SZ002236,SZ002508,SZ000423,MOMO,SH600887,BIDU,TCEHY,SZ000333,SH600036,NTES,TWTR,SZ000651,FB,WMT,AMZN,SZ002415,SZ000895,SINA,SH601318,TSLA,AAPL,DIS"))
                .mapJSON()
                .subscribe(
                    onSuccess:{json in
                        let info = self.parseGithubResponse(response: json as AnyObject)
                        observer.on(.next(info))
                        observer.on(.completed)
                    },
                    onError:{error in
                        observer.on(.error(error))
                        print(error)
                })
            return  Disposables.create()
        }
    }
    
    private func parseGithubResponse(response: AnyObject) -> [ListModel] {
        var ret: [ListModel] = []
        let a = response as! [String:AnyObject]
        for (_, subJson ) in a {
            let s = subJson as! [String:String]
            ret.append(ListModel(
                name:s["name"]!,
                current:s["current"]!
            ))
        }
        return ret
    }
}
