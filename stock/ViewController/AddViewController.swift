//
//  AddViewController.swift
//  stock
//
//  Created by zhiyuan10 on 2018/2/20.
//  Copyright © 2018年 钱宝. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import RxCocoa
import Then
import MJRefresh
import NSObject_Rx




class AddViewController: UIViewController {
    var resultTableView : UITableView!
    var closeBtn = UIButton(frame: CGRect(x: ScreenW-100 , y: 10, width: 80, height: 80))
    let searchFiled = UITextField(frame: CGRect(x: 50, y: 100, width: ScreenW-100, height: 40))
    //let dataSource : RxTableViewSectionedReloadDataSource<LXFSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        //搜索结果ui
        resultTableView  = UITableView(frame: CGRect(x:0, y:100+50, width:ScreenW, height:ScreenH-150),style:.plain)
        resultTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        resultTableView.backgroundColor = UIColor.black
        resultTableView.rowHeight = 60
        resultTableView.separatorStyle = .none
        //搜索框
        searchFiled.backgroundColor = UIColor.gray
 
        
//        searchFiled.rx.text
//            .filter{
//                ($0?.lengthOfBytes(using: .utf8))! > 0 //长度大于1
//            }
//            .throttle(0.5, scheduler: MainScheduler.instance) //延迟0.5秒再执行
//            .flatMap{
//                ListViewModel().searchFromApi(repositoryName:String(describing: $0!)) //查询结果，返回可订阅的SearchModel
//                    .observeOn(MainScheduler.instance) // 将返回结果切换到到主线程上
//                    .catchErrorJustReturn([])  // 如果有问题，错误结果将会得到处理
//            }
//            .share(replay: 1)
//            //事件流发出者（searchFiled）和观察者（resultTableView）绑定在一起
//            .bind(to: self.resultTableView.rx.items(cellIdentifier: "SearchTableViewCell", cellType: SearchTableViewCell.self)) {(_, model:SearchModel, cell:SearchTableViewCell) in
//                cell.nameLabel.text = model.name
//                cell.codeLabel.text = model.code
//            }
//            .disposed(by: rx.disposeBag)

    searchFiled.rx.text
        .filter{
            ($0?.lengthOfBytes(using: .utf8))! > 0 //长度大于1
        }
        .throttle(0.5, scheduler: MainScheduler.instance) //延迟0.5秒再执行
        .flatMap{
            ListViewModel().searchFromApi(repositoryName:String(describing: $0!))
        }
        .asDriver(onErrorJustReturn: [])
        .drive(resultTableView.rx.items(cellIdentifier: "SearchTableViewCell", cellType: SearchTableViewCell.self)) {
            (tableView, element, cell) in
            cell.nameLabel.text = element.name
            cell.codeLabel.text = element.code
        }
        .disposed(by: rx.disposeBag)

        
        //关闭按钮
        closeBtn.setTitle("关闭", for: .normal)
        closeBtn.rx.tap.asObservable().subscribe(
            onNext: {
                self.dismiss(animated: true, completion: nil)
            }
        ).disposed(by: rx.disposeBag)
 
        
        view.addSubview(resultTableView)
        view.addSubview(searchFiled)
        view.addSubview(closeBtn)
    }

}

