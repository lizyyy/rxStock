import Foundation
import RxSwift
import Moya
import ObjectMapper

class ListViewModel {
    var bag:DisposeBag! = DisposeBag()
    
    /**
        这里我们使用moya来做网络请求，moya的具体使用方法参见：https://github.com/Moya/Moya
        我们把moya从网络api返回的结果当做一个stream，使用rxswift的create把返回结果变成一个可订阅的信息流
     
        create的方法可以参见手册：
        create(_ subscribe: @escaping (RxSwift.AnyObserver<Self.E>) -> Disposable)
     
        Observable.create { observer in
            observer.onNext(10)
            observer.onCompleted()
            return  Disposables.create()
        }
    */
    func getFromApi(repositoryName: String) -> Observable<[ListModel]> {
        return Observable.create { observer in
                netToolProvider.rx.request(.GetStocks(code:"FB,WB,WMT,AMZN,SZ002415,NVDA,SINA,TSLA,AAPL,DIS"))
                .mapJSON() //Moya RxSwift的扩展方法，可以把返回的数据解析成 JSON 格式
                .subscribe( //订阅返回的结果
                    onSuccess:{json in
                        let info = self.parseResponse(response: json as AnyObject) // 把返回解析成一个listmodel对象
                        observer.on(.next(info)) //发送next 内容是listmodel
                        observer.on(.completed)  //发送成功
                    },
                    onError:{error in
                        observer.on(.error(error)) //发送错误
                }).disposed(by: self.bag)//自动内存处理机制
            
            return  Disposables.create()
        }
    }
    
    private func parseResponse(response: AnyObject) -> [ListModel] {
        var ret: [ListModel] = []
        for (_, subJson ) in response as! [String:[String:AnyObject]] {
            ret.append(ListModel(JSON: subJson)!)
        }
        return ret
    }
    
    func searchFromApi(repositoryName: String) -> Observable<[SearchModel]> {
        return Observable.create { observer in
            netToolProvider.rx.request(.SearchStocks(code:repositoryName))
                .mapJSON() //Moya RxSwift的扩展方法，可以把返回的数据解析成 JSON 格式
                .subscribe( //订阅返回的结果
                    onSuccess:{json in
                        let info = self.parseSearchResponse(response: json as AnyObject) // 把返回解析成一个listmodel对象
                        observer.on(.next(info)) //发送next 内容是listmodel
                        observer.on(.completed)  //发送成功
                },
                    onError:{error in
                        observer.on(.error(error)) //发送错误
                }).disposed(by: self.bag)//自动内存处理机制
            
            return  Disposables.create()
        }
    }
    
    private func parseSearchResponse(response: AnyObject) -> [SearchModel] {
        var info: [SearchModel] = []
        let items = response["stocks"] as! [[String:AnyObject]]
        let _ = items.filter{
                return $0["stock_id"] as! Int != 0 //把退市的去掉
            }.map{
                info.append(SearchModel(JSON: $0)!)
            }
        return info;
    }
}


/*
 00365,01727,02318,00700,03968,02319,NQ,KODK,VIPS,SH603868,SH601933,
 SH603711,RYB,XNET,SZ000001,SZ000725,JT,JNJ,ATVI,TTWO,SZ002310,SOGO,
 SZ000538,SZ000799,SZ002230,SZ002271,OC833209,AMD,SZ002236,SZ002508,
 SZ000423,MOMO,SH600887,BIDU,TCEHY,SZ000333,SH600036,NTES,TWTR,SZ000651,
 */
