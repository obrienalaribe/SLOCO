//
//  LoginViewController.swift
//  SLOCO
//
//  Created by mac on 5/24/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit
import Material
import SwiftHEXColors

class LoginViewController: UIViewController, UITextFieldDelegate {
    private var viewComponents: [UIView] = []
    private var header: UILabel!
    private var emailField: ErrorTextField!
    private var passwordField: TextField!
    private var submitButton: RaisedButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        prepareHeaderText()
        prepareEmailField()
        preparePasswordField()
        prepareSubmitButton()
        prepareView()
    }

    /// Programmatic update for the textField as it rotates.
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        emailField.width = view.bounds.height - 80
    }
    
    private func prepareHeaderText(){
        header = UILabel()
        header.text = "Login/Register"
        header.textAlignment = .Center
        view.addSubview(header)

        MaterialLayout.alignFromTop(view, child: header, top: 40)
        MaterialLayout.alignToParentHorizontally(view, child: header, left: 40, right: 40)
    }
    
    private func prepareEmailField() {
        emailField = ErrorTextField(frame: CGRectMake(40, 120, view.bounds.width - 80, 32))
        emailField.placeholder = "University Email"
        emailField.detail = "Error, invalid university email"
//        emailField.keyboardType = .EmailAddress
//        emailField.returnKeyType = UIReturnKeyType.Done
//        emailField.autocorrectionType = UITextAutocorrectionType.No

        emailField.enableClearIconButton = true
        emailField.delegate = self
        
        emailField.placeholderColor = MaterialColor.amber.darken4
        emailField.placeholderActiveColor = MaterialColor.pink.base
        emailField.dividerColor = MaterialColor.cyan.base
        
        view.addSubview(emailField)

    }
    
    private func preparePasswordField(){
        passwordField = TextField()
        passwordField.placeholder = "Password"
        passwordField.detail = "At least 8 characters"
        passwordField.clearButtonMode = .WhileEditing
        passwordField.enableVisibilityIconButton = true
        
        // Setting the visibilityFlatButton color.
        passwordField.visibilityIconButton?.tintColor = MaterialColor.green.base.colorWithAlphaComponent(passwordField.secureTextEntry ? 0.38 : 0.54)
        
        view.addSubview(passwordField)
        
        MaterialLayout.alignFromTop(view, child: passwordField, top: 200)
        MaterialLayout.alignToParentHorizontally(view, child: passwordField, left: 40, right: 40)
    }
    
    private func prepareSubmitButton() {
        submitButton = RaisedButton()
        submitButton.addTarget(self, action: #selector(handleSubmission), forControlEvents: .TouchUpInside)
        submitButton.setTitle("Submit", forState: .Normal)
        submitButton.setTitleColor(MaterialColor.blue.base, forState: .Normal)
        submitButton.setTitleColor(MaterialColor.blue.base, forState: .Highlighted)
        view.addSubview(submitButton)
        
        MaterialLayout.alignFromTop(view, child: submitButton, top: 290)
        MaterialLayout.alignToParentHorizontally(view, child: submitButton, left: 40, right: 40)
        

    }
    
    
    /// Handle submission.
    internal func handleSubmission() {
        emailField?.resignFirstResponder()
        passwordField?.resignFirstResponder()
        self.presentViewController(RegisterViewController(), animated: true, completion: nil)

        
    }
    
    private func prepareView() {
        view.backgroundColor = MaterialColor.white
            
    }


    
    /// Executed when the 'return' key is pressed when using the emailField.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.revealError = true
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("started editing")
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("ended editing")
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        (textField as? ErrorTextField)?.revealError = false
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.revealError = false
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        (textField as? ErrorTextField)?.revealError = false
        return true
    }

}

