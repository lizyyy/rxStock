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
import NSObject_Rx

class AddViewController: UIViewController {
    var resultTableView : UITableView!
    var closeBtn = UIButton(frame: CGRect(x: ScreenW-100 , y: 10, width: 80, height: 80))
    let searchFiled = UITextField(frame: CGRect(x: 50, y: 100, width: ScreenW-100, height: 40))
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
                cell.addBtn.rx.tap.subscribe(
                    onNext: {
                        var stocks = UserDefaults.standard.array(forKey: "stockSelected")  as! [String]
                        stocks.append(element.code)
                        UserDefaults.standard.set(stocks, forKey: "stockSelected")
                        cell.addBtn.setTitle("已关注", for: .normal)
                    }
                    ).disposed(by: cell.disposeBag)//注意，这里是cell的disposeBag
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
