//
//  RegisterViewController.swift
//  SLOCO
//
//  Created by mac on 5/31/16.
//  Copyright © 2016 sloco. All rights reserved.
//

import UIKit
import Material


class RegisterViewController: UIViewController, UITextFieldDelegate {
    // MARK: Text fields
    
    private var textFields: [TextField]! = []
    
    private var header: UILabel!
    private var firstNameField: TextField!
    private var lastNameField: TextField!
    private var courseField: TextField!
    private var yearField: TextField!
    private var registerButton: RaisedButton!
    
    var course: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareHeader()
        prepareFirstNameField()
        prepareLastNameField()
        prepareCourseField()
        prepareYearField()

        prepareRegisterButton()
        
        prepareView()
        
        if let courseName = course {
            courseField.text = courseName
            
        }
    }
   
    
    private func prepareHeader(){
        header = UILabel()
        header.text = "Register for student account"
        header.textAlignment = .Center
        view.addSubview(header)
        
        MaterialLayout.alignFromTop(view, child: header, top: 80)
        MaterialLayout.alignToParentHorizontally(view, child: header, left: 40, right: 40)
    }
    
    private func prepareFirstNameField() {
        firstNameField = TextField()
        firstNameField.placeholder = "Firstname"
        firstNameField.textAlignment = .Center
        firstNameField.clearButtonMode = .WhileEditing
        
        firstNameField.delegate = self
        
        view.addSubview(firstNameField)
        
        textFields.append(firstNameField)
   
        MaterialLayout.alignFromTop(view, child: firstNameField, top: 150)
        MaterialLayout.alignToParentHorizontally(view, child: firstNameField, left: 40, right: 40)
    }
    
    
    private func prepareLastNameField() {
        lastNameField = TextField()
        lastNameField.placeholder = "Lastname"
        lastNameField.textAlignment = .Center
        lastNameField.clearButtonMode = .WhileEditing
        lastNameField.delegate = self

        view.addSubview(lastNameField)
        
        textFields.append(lastNameField)

        
        MaterialLayout.alignFromTop(view, child: lastNameField, top: 220)
        MaterialLayout.alignToParentHorizontally(view, child: lastNameField, left: 40, right: 40)
    }
    
    private func prepareCourseField(){
        courseField = TextField()
        courseField.placeholder = "Course of study"
        courseField.textAlignment = .Center
        courseField.clearButtonMode = .WhileEditing
        
        
        view.addSubview(courseField)
        courseField.delegate = self

        courseField.addTarget(self, action: #selector(handleCourseAutocompletion), forControlEvents: .TouchDown)
        textFields.append(courseField)
        
        MaterialLayout.alignFromTop(view, child: courseField, top: 290)
        MaterialLayout.alignToParentHorizontally(view, child: courseField, left: 40, right: 40)
    }
    
    private func prepareYearField() {
        yearField = TextField()
        yearField.placeholder = "Year of study"
        yearField.textAlignment = .Center
        yearField.clearButtonMode = .WhileEditing
        
        view.addSubview(yearField)
        textFields.append(yearField)

        MaterialLayout.alignFromTop(view, child: yearField, top: 360)
        MaterialLayout.alignToParentHorizontally(view, child: yearField, left: 40, right: 40)

    }
    
    private func prepareRegisterButton() {
        registerButton = RaisedButton()
        registerButton.addTarget(self, action: #selector(handleRegistration), forControlEvents: .TouchUpInside)
        registerButton.setTitle("Register", forState: .Normal)
        registerButton.setTitleColor(MaterialColor.blue.base, forState: .Normal)
        registerButton.setTitleColor(MaterialColor.blue.base, forState: .Highlighted)
        view.addSubview(registerButton)
        
        MaterialLayout.alignFromTop(view, child: registerButton, top: 430)
        MaterialLayout.alignToParentHorizontally(view, child: registerButton, left: 40, right: 40)
    }
    
    internal func handleRegistration() {
        self.presentViewController(CustomTabBarController(), animated: true, completion: nil)
    }
    
    internal func handleCourseAutocompletion() {
        print("navigating to course selection")
        
        self.presentViewController(TokenViewController(), animated: true, completion: nil)
    }
    
    private func prepareView() {
        view.backgroundColor = MaterialColor.white
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let index = textFields.indexOf(textField as! TextField) {
            if index < textFields.count - 1 {
                let nextTextField = textFields[index + 1]
                nextTextField.becomeFirstResponder()
            }
        }
        return true
    }
}

struct RegisterViewModel {
    var firstname: String!
    var lastname: String!
    var course: String!
    var year: Int!
    
    init(firstname: String, lastname: String, course: String, year: Int) {
        self.firstname = firstname
        self.lastname = lastname
        self.course = course
        self.year = year
    }
}
