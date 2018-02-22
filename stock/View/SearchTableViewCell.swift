
import UIKit

class SearchTableViewCell: UITableViewCell {
    var nameLabel: UILabel! //名称
    var codeLabel : UILabel! //code
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.black
        let defaultHeight:CGFloat = 18
        let defaultMaxWidth:CGFloat = 16 
        nameLabel =         UILabel(text:"",font:16,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        codeLabel =         UILabel(text:"",font:12,textColor:UIColor.lightGray,maxWidth:defaultMaxWidth)
      
        
        nameLabel.frame =           CGRect(x: 10, y: 3, width: ScreenW-20, height: defaultHeight)
        codeLabel.frame =           CGRect(x: 10, y: nameLabel.y+nameLabel.height, width: ScreenW-20, height: defaultHeight)
        
    
        self.addSubview(nameLabel)
        self.addSubview(codeLabel)
       
    }
    
    
    
    
}


