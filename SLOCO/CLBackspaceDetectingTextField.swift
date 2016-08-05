import Foundation
import UIKit

protocol CLBackspaceDetectingTextFieldDelegate: UITextFieldDelegate {
    func textFieldDidDeleteBackwards(textField:UITextField)
}

class CLBackspaceDetectingTextField: UITextField {
    
    var myDelegate: CLBackspaceDetectingTextFieldDelegate? {
        get { return self.delegate as? CLBackspaceDetectingTextFieldDelegate }
        set { self.delegate = newValue }
    }
    
    override func deleteBackward() {
        
        if (self.text?.isEmpty ?? false){
            self.textFieldDidDeleteBackwards(self)
        }
        super.deleteBackward()
    }
    
    func textFieldDidDeleteBackwards(textField:UITextField) {
        
        myDelegate?.textFieldDidDeleteBackwards(textField)
        
    }
    
}