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
import NSObject_Rx

class ViewController: UIViewController {
    var resultTableView : UITableView!
    var addBtn = UIButton(frame: CGRect(x: ScreenW-100 , y: 10, width: 80, height: 80))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        resultTableView  = UITableView(frame: CGRect(x:0, y:LL_StatusBarAndNavigationBarHeight, width:ScreenW, height:ScreenH-LL_StatusBarAndNavigationBarHeight),style:.plain)
        resultTableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        resultTableView.backgroundColor = UIColor.black
        resultTableView.rowHeight = 60
        resultTableView.separatorStyle = .none
        view.addSubview(resultTableView)
        //添加按钮
        addBtn.setTitle("+", for: .normal)
        view.addSubview(addBtn)
        
        addBtn.rx.tap.asObservable().subscribe(
            onNext: {
                self.present(AddViewController(), animated: true, completion: nil)
            }
        ).disposed(by: rx.disposeBag)
        
        Observable<Int>.interval(2, scheduler: MainScheduler.instance).subscribe { (event) in
            self.resultTableView.reloadData() //两秒刷新一次
        }.disposed(by: rx.disposeBag)

        ListViewModel().getFromApi(repositoryName: "").subscribe(
            onNext:{ rs in Observable<[ListModel]>
                .just(rs)
                .bind(to: self.resultTableView.rx.items(cellIdentifier: "ListTableViewCell", cellType: ListTableViewCell.self)) {(_, model:ListModel, cell:ListTableViewCell) in
                        cell.nameLabel.text = model.name
                        cell.codeLabel.text = model.code
                    cell.currentLabel.text = String(describing: model.current)
                        cell.percentageLabel.text = model.percentage + "%"
                        cell.changeLabel.text = model.change
                    cell.afterHoursLabel.text = "盘后:" + String(describing: model.afterHours)
                        cell.afterHoursPctLabel.text = model.afterHoursPct + "%"
                        cell.afterHoursChgLabel.text = model.afterHoursChg
                    cell.openLabel.text = "开:" + String(describing: model.open)
                        cell.highLabel.text = "高:" + model.high
                        cell.lowLabel.text = "低:" + model.low
                    //当前价格
                    if ( Double(model.current)! > Double(model.open)!){
                            cell.currentLabel.textColor = UIColor.red
                            cell.percentageLabel.textColor = UIColor.red
                            cell.changeLabel.textColor = UIColor.red
                        }else{
                            cell.currentLabel.textColor = UIColor.green
                            cell.percentageLabel.textColor = UIColor.green
                            cell.changeLabel.textColor = UIColor.green
                    }
                    //盘后价格
                    if ( Double(model.afterHours)! > Double(model.close)!){
                        cell.afterHoursLabel.textColor = UIColor.red
                        cell.afterHoursPctLabel.textColor = UIColor.red
                        cell.afterHoursChgLabel.textColor = UIColor.red
                    }else{
                        cell.afterHoursLabel.textColor = UIColor.green
                        cell.afterHoursPctLabel.textColor = UIColor.green
                        cell.afterHoursChgLabel.textColor = UIColor.green
                    }
                    
                    if ( Double(model.high)! > Double(model.open)!){
                        cell.highLabel.textColor = UIColor.red
                    }else{
                        cell.highLabel.textColor = UIColor.green
                    }
                    
                    if ( Double(model.low)! > Double(model.open)!){
                        cell.lowLabel.textColor = UIColor.red
                    }else{
                        cell.lowLabel.textColor = UIColor.green
                    }
                }.disposed(by: self.rx.disposeBag)
            }
        ).disposed(by: rx.disposeBag)
    }
}
