
import UIKit
import RxSwift

class SearchTableViewCell: UITableViewCell {
    var nameLabel: UILabel! //名称
    var codeLabel : UILabel! //code
    var addBtn:UIButton! //添加按钮
    private(set) var disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //prepareForReuse()方法，在方法里面，每次重用cell的时候，我们会释放之前的disposeBag, 然后会为cell创建一个新的disposeBag对象，这样可以保证cell被重用的时候不会被多次订阅，造成错误。
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.black
        let defaultHeight:CGFloat = 18
        let defaultMaxWidth:CGFloat = 16 
        nameLabel =         UILabel(text:"",font:16,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        codeLabel =         UILabel(text:"",font:12,textColor:UIColor.lightGray,maxWidth:defaultMaxWidth)
        addBtn = UIButton(frame: CGRect(x: ScreenW - 100, y: 5, width: 80, height: 40))
        addBtn.setTitle("关注", for: .normal)
        addBtn.tintColor = UIColor.white
        nameLabel.frame =           CGRect(x: 10, y: 3, width: ScreenW-120, height: defaultHeight)
        codeLabel.frame =           CGRect(x: 10, y: nameLabel.y+nameLabel.height, width: ScreenW-20, height: defaultHeight)
        
        self.addSubview(addBtn)
        self.addSubview(nameLabel)
        self.addSubview(codeLabel)
       
    }
    
    
    
    
}


