//
//  SMSVerifyView.swift
//  SMSVerifyView
//
//  Created by Amjad Tubasi on 8/31/16.
//  Copyright © 2016 Amjad Tubasi. All rights reserved.
//

import UIKit

class SMSVerifyView: BaseView {
	
    // MARK: - OUTLETS
    
	@IBOutlet weak var errorLabelHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak  var errorMessageLabel: UILabel!
	@IBOutlet  var fields: [UITextField]!
	@IBOutlet weak var resendCodeButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageLabelTopConstraint: NSLayoutConstraint!
	
    // MARK: - DATA
    
    fileprivate var timer:Timer?
    fileprivate var counter = 0

    var secoandsToEnableResendCode = 10
    var delegate:VerifySMSCodeDelegate?
    var code : String {
        get{
            var code:String = ""
            self.fields.forEach({textField in
                code.append(textField.text ?? "")
            })
            return code
        }
    }
    
    let sentColor = UIColor.green
    var onChangeText : OnChangeTextCompletion?
    
    // MARK: - IBActions
    
    @IBAction func resnedCode(_ sender: AnyObject) {
        endEditing(true)
        delegate?.didTapResendCode()
    }
    
    // MARK: - Timer

    func startResendTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateResendTimer), userInfo: nil, repeats: true)
        counter = 0
        disableResendButton()
    }

    @objc func updateResendTimer(){
        counter += 1
        if counter >= secoandsToEnableResendCode {
            self.enableResendButton()
            timer?.invalidate()
        }else {
            let value = secoandsToEnableResendCode - counter
            if value > 9 {
                self.resendCodeButton.setTitle("00:\(value)", for: .normal)
            }else {
                self.resendCodeButton.setTitle("00:0\(value)", for: .normal)
            }
        }
    }
    
    
    // MARK: - Life Cycle
    
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
        setup()
	}
    
    deinit{
        timer?.invalidate()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup(){
        clearError()
        startResendTimer()
        self.fields.forEach({textField in
            textField.addTarget(self, action: #selector(textFieldDidChangeText(_:)), for: .editingChanged)
            textField.delegate = self
            textField.isEnabled = textField == self.fields.first
            textField.backgroundColor = UIColor.clear
            textField.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 1)
        })
    }
    
    // MARK: - Fields Methods
    
    @objc func textFieldDidChangeText(_ textField: UITextField) {
        self.clearError()
        self.onChangeText?(textField.text ?? "")
        if textField.text?.isEmpty == false {
            
            if textField.text?.count ?? 0 > 1 {
                textField.text = textField.text?.last?.toString
            }
            
            if textField == self.fields.last{
                textField.resignFirstResponder()
                delegate?.didFinishVerifyingCode(code: code)
                return
            }
            
            let nextFieldIndex = min((self.fields.index(where: {$0 == textField}) ?? 0) + 1,self.fields.count - 1)
            self.fields[nextFieldIndex].isEnabled = true
            self.fields[nextFieldIndex].becomeFirstResponder()
        }else{
            let previousFieldIndex = max((self.fields.index(where: {$0 == textField}) ?? 0)  - 1,0)
            self.fields[previousFieldIndex].becomeFirstResponder()
        }

    }
    
   
    // MARK:- UI
    
	var fieldsTextColor : UIColor = UIColor.black{
		
		didSet{
            self.fields.forEach({textField in
                textField.textColor = fieldsTextColor
            })
		}
	}
    var fieldsBacgroundColor : UIColor = UIColor.clear{
        
        didSet{
            
            self.fields.forEach({textField in
                textField.backgroundColor = fieldsBacgroundColor
            })
        }
    }
    
	var errorTextColor : UIColor = UIColor.black{
		
		didSet{
			errorMessageLabel.textColor = errorTextColor
		}
	}
	
	var sendCodeButtonTextColor : UIColor = UIColor.white{
		
		didSet{
			resendCodeButton.setTitleColor(sendCodeButtonTextColor, for: .normal)
		}
	}
	
	var fieldsBorderColor : UIColor = UIColor.black {
		
		didSet{
            self.fields.forEach({textField in
                textField.layer.masksToBounds = true
                textField.layer.borderColor = fieldsBorderColor.cgColor
            })
		}
	}
	
	var fieldsBorderWidth : CGFloat = 1{
		
		didSet{
            self.fields.forEach({textField in
                textField.layer.masksToBounds = true
                textField.layer.borderWidth = fieldsBorderWidth
            })
		}
	}
    
    var fieldsBorderStyle : UITextBorderStyle = .line {
        didSet{
            self.fields.forEach({textField in
                textField.borderStyle = fieldsBorderStyle
            })
        }
    }
    
    var fieldsFont : UIFont = UIFont.systemFont(ofSize: 20) {
        didSet{
            self.fields.forEach({textField in
                textField.font = fieldsFont
            })
        }
    }
    
    var fieldsCornerRaduis: CGFloat = 0 {
        
        didSet{
            self.fields.forEach({textField in
                textField.layer.cornerRadius = fieldsCornerRaduis
            })
        }
    }
    
    var messageAttributedString : NSMutableAttributedString? = nil {
        didSet{
            self.messageLabel.attributedText = messageAttributedString
        }
    }

    func hideMessage(){
        self.messageLabel.isHidden = true
        self.messageLabelTopConstraint.constant = 0
        self.messageLabelHeightConstraint.constant = 0
    }

}
