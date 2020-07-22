import UIKit

class textFiledplaceholder: UITextField {
    static let font_size : CGFloat = 16
    static let leftPadding : CGFloat = 15
    //static let righPadding : CGFloat = 15
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.comminIt()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.comminIt()
    }
    func comminIt()
    {
        borderStyle             = .none
        backgroundColor         = .white
        // layer.masksToBounds     = true
       
        setLeftPaddingPoints(textFiledplaceholder.leftPadding)
        //setRightPaddingPoints(textFiledplaceholder.righPadding)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

//    func setRightPaddingPoints(_ amount:CGFloat) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
//        self.rightView = paddingView
//        self.rightViewMode = .always
//    }

