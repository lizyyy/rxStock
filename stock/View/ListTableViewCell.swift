
import UIKit
 
class ListTableViewCell: UITableViewCell {
    var nameLabel: UILabel! //名称
    var codeLabel : UILabel! //code
    
    var currentLabel: UILabel! //当前价格
    var percentageLabel: UILabel! //百分比
    var changeLabel: UILabel! //波动价格
    
    var afterHoursLabel: UILabel! //盘后价格
    var afterHoursPctLabel: UILabel! //盘后百分比
    var afterHoursChgLabel: UILabel! //盘后波动
    
    var openLabel: UILabel! //开盘价
    var highLabel: UILabel! //最高价
    var lowLabel: UILabel!  //最低价
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        //defaults.set([], forKey: "stockSelected")
     
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.black
        let defaultHeight:CGFloat = 18
        let defaultMaxWidth:CGFloat = 16
        let defaultLabelW:CGFloat = 80
        let defaultFontSize:CGFloat = 12
        nameLabel =         UILabel(text:"",font:16,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        codeLabel =         UILabel(text:"",font:12,textColor:UIColor.lightGray,maxWidth:defaultMaxWidth)
        currentLabel =      UILabel(text:"",font:defaultFontSize,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        percentageLabel =   UILabel(text:"",font:defaultFontSize,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        changeLabel =       UILabel(text:"",font:defaultFontSize,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        afterHoursLabel =   UILabel(text:"",font:defaultFontSize,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        afterHoursPctLabel = UILabel(text:"",font:defaultFontSize,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        afterHoursChgLabel = UILabel(text:"",font:defaultFontSize,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        openLabel =         UILabel(text:"",font:defaultFontSize,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        highLabel =         UILabel(text:"",font:defaultFontSize,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        lowLabel =          UILabel(text:"",font:defaultFontSize,textColor:UIColor.white,maxWidth:defaultMaxWidth)
        
        nameLabel.frame =           CGRect(x: 10, y: 3, width: 100, height: defaultHeight)
        codeLabel.frame =           CGRect(x: 10, y: nameLabel.y+nameLabel.height, width: 100, height: defaultHeight)
        
        currentLabel.frame =        CGRect(x: 120, y: 3, width: defaultLabelW, height: defaultHeight)
        percentageLabel.frame =     CGRect(x: currentLabel.x+currentLabel.width+10, y: 3, width: defaultLabelW, height: defaultHeight)
        changeLabel.frame =         CGRect(x: percentageLabel.x+percentageLabel.width+10, y: 3, width: defaultLabelW, height: defaultHeight)
        
        afterHoursLabel.frame =     CGRect(x: 120, y: currentLabel.y+currentLabel.height, width: defaultLabelW, height: defaultHeight)
        afterHoursPctLabel.frame =  CGRect(x: afterHoursLabel.x+afterHoursLabel.width+10, y: currentLabel.y+currentLabel.height, width: defaultLabelW, height: defaultHeight)
        afterHoursChgLabel.frame =  CGRect(x: afterHoursPctLabel.x+afterHoursPctLabel.width+10, y: currentLabel.y+currentLabel.height, width: defaultLabelW, height: defaultHeight)
        
        openLabel.frame =           CGRect(x: 120, y: afterHoursLabel.y+afterHoursLabel.height, width: defaultLabelW, height: defaultHeight)
        highLabel.frame =           CGRect(x: openLabel.x+openLabel.width+10, y: afterHoursLabel.y+afterHoursLabel.height, width: defaultLabelW, height: defaultHeight)
        lowLabel.frame =            CGRect(x: highLabel.x+highLabel.width+10, y: afterHoursLabel.y+afterHoursLabel.height, width: defaultLabelW, height: defaultHeight)
        
        self.addSubview(nameLabel)
        self.addSubview(codeLabel)
        self.addSubview(currentLabel)
        self.addSubview(percentageLabel)
        self.addSubview(changeLabel)
        self.addSubview(afterHoursLabel)
        self.addSubview(afterHoursPctLabel)
        self.addSubview(afterHoursChgLabel)
        self.addSubview(openLabel)
        self.addSubview(highLabel)
        self.addSubview(lowLabel)
    }
    
 
    
    
}
 
