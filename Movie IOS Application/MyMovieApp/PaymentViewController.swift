//
//  VisaViewController.swift
//  MyMovieApp
//
//  Created by Yan Rips on 29/04/2019.
//  Copyright © 2019 Yan Rips. All rights reserved.
//

import UIKit
import CreditCardForm
import Stripe

class PaymentViewController: UIViewController, STPPaymentCardTextFieldDelegate{
    private var movie:Movie!
    private var event:Event!
    private var totalSeatChoosen = 0
    private var buyButton:UIButton!
    private var whiteView:UIView!
    private var nameTextField: UITextField!
    private var movieInformation: UILabel!
    private var numberOfSeatsLabel: UILabel!
    private var totalPriceLabel: UILabel!
    private var keyboardHeight:CGFloat!
    private var buyButtonYPosition: CGFloat!
    private var creditCard:CreditCardFormView!
    private var keyboardLifted:Bool = false
    private var buyClicked:Bool = false
    private var paymentTextField:STPPaymentCardTextField!
    func setMovie(movie:Movie){
        self.movie = movie
    }
    func setEvent(event: Event){
        self.event = event
    }
    func setTotalSeats(_ totalSeatChoosen:Int){
        self.totalSeatChoosen = totalSeatChoosen
    }
    func createNameTextField(){
        nameTextField = UITextField()
        nameTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.layer.cornerRadius = 5.0
        let border = CALayer()
        let width = CGFloat(1.0)
        
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: nameTextField.frame.size.height - width, width:  nameTextField.frame.size.width, height: nameTextField.frame.size.height)
        border.borderWidth = width
        nameTextField.layer.addSublayer(border)
        nameTextField.layer.masksToBounds = true
        nameTextField.backgroundColor = UIColor.white
        nameTextField.placeholder = "Full Name"
        nameTextField.addTarget(self, action: #selector(nameTextFieldChanged(_:)), for: .editingChanged)

        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always
        nameTextField.autocorrectionType = .no
        nameTextField.autocapitalizationType = .allCharacters
        view.addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: creditCard.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            nameTextField.heightAnchor.constraint(equalToConstant: 44)
            ])
    }
    @objc func nameTextFieldChanged(_ textField: UITextField){
        if let text = textField.text{
            if !text.isEmpty{
                creditCard.cardHolderString = text.uppercased()
                textField.text = text.uppercased()
            }else{
                creditCard.cardHolderString = "ISRAEL ISRAELI"
            }
        }else{
            creditCard.cardHolderString = "ISRAEL ISRAELI"
        }
        
    }
    func createTextField() {
        paymentTextField = STPPaymentCardTextField()
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 30, height: 44)
        paymentTextField.delegate = self
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true
        paymentTextField.backgroundColor = UIColor.white
        view.addSubview(paymentTextField)
        
        NSLayoutConstraint.activate([
            paymentTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
            paymentTextField.heightAnchor.constraint(equalToConstant: 44)
            ])
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if !keyboardLifted{
                keyboardLifted = true
                keyboardHeight = keyboardSize.height
                //self.view.frame.origin.y -= keyboardSize.height
                whiteView.frame.origin.y -= keyboardHeight
                movieInformation.frame.origin.y -= keyboardHeight
                totalPriceLabel.frame.origin.y -= keyboardHeight
                numberOfSeatsLabel.frame.origin.y -= keyboardHeight
                
                creditCard.frame.origin.y -= 90
                nameTextField.frame.origin.y -= 90
                paymentTextField.frame.origin.y -= 90
                
                buyButtonYPosition = buyButton.frame.origin.y
                buyButton.frame.origin.y = paymentTextField.frame.maxY + 20
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardLifted{
            keyboardLifted = false
            whiteView.frame.origin.y += keyboardHeight
            movieInformation.frame.origin.y += keyboardHeight
            totalPriceLabel.frame.origin.y += keyboardHeight
            numberOfSeatsLabel.frame.origin.y += keyboardHeight
            
            creditCard.frame.origin.y += 90
            paymentTextField.frame.origin.y += 90
            nameTextField.frame.origin.y += 90
            
            buyButton.frame.origin.y = buyButtonYPosition
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        
        hideKeyboardWhenTappedAround()
        creditCard = CreditCardFormView(frame: CGRect(x: 10, y: 100, width: view.frame.width - 30, height: view.frame.height/3.5))
        view.addSubview(creditCard)
        creditCard.cardHolderString = "ISRAEL ISRAELI"

        createNameTextField()
        createTextField()
        whiteView = UIView(frame: CGRect(x: 10, y: 20, width: view.frame.width - 30, height: 60))
        whiteView.backgroundColor = UIColor.white
        whiteView.layer.cornerRadius = 5.0
        buyButton = UIButton(type: .system)
        buyButton.frame = CGRect(x: 10, y: view.frame.height-190, width: view.frame.width-30, height: 50)
        buyButton.layer.cornerRadius = 5.0
        buyButton.backgroundColor = UIColor.green
        buyButton.setTitle("המשך לרכישה", for: .normal)
        buyButton.setTitleColor(UIColor.white, for: .normal)
        buyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buyButton.addTarget(self, action: #selector(onNextClicked), for: .touchUpInside)
        view.addSubview(buyButton)
        view.addSubview(whiteView)
        movieInformation = UILabel(frame: CGRect(x: 20, y: 20, width: view.frame.width - 50, height: 20))
        movieInformation.textAlignment = .right
        movieInformation.text = "סרט: \(movie.name)"
        movieInformation.font = UIFont.boldSystemFont(ofSize: 18)
        movieInformation.textColor = UIColor.black
        view.addSubview(movieInformation)
        numberOfSeatsLabel = UILabel(frame: CGRect(x: 20, y: 40, width: view.frame.width - 50, height: 20))
        if totalSeatChoosen == 1{
            numberOfSeatsLabel.text = "שעה: \(event.Date) - סה\"כ כיסא אחד"
        }else{
            numberOfSeatsLabel.text = "שעה: \(event.Date) - סה\"כ \(totalSeatChoosen) כיסאות"
        }
        
        numberOfSeatsLabel.textAlignment = .right
        numberOfSeatsLabel.textColor = UIColor.black
        numberOfSeatsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(numberOfSeatsLabel)
        
        totalPriceLabel = UILabel(frame: CGRect(x: 20, y: 60, width: view.frame.width - 50, height: 20))
        totalPriceLabel.text = "מחיר \(totalSeatChoosen * 30) ש\"ח"
        totalPriceLabel.textAlignment = .right
        totalPriceLabel.textColor = UIColor.black
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(totalPriceLabel)
        
    }
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        creditCard.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationMonth, cvc: textField.cvc)
    }
    
    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        creditCard.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCard.paymentCardTextFieldDidBeginEditingCVC()
    }
    
    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        creditCard.paymentCardTextFieldDidEndEditingCVC()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "אישור פרטים"
        view.backgroundColor = UIColor.black
        
        
    }
    @objc func onNextClicked(){
        print("שולם")
        if !buyClicked{
            let loader = Loader(frame: CGRect(x: view.frame.width/2 - 40, y: 100, width: 80, height: 80))
            loader.beginAnimate()
            view.addSubview(loader)
            let alert = UIAlertController(title: "תשלום עבר בהצלחה", message: "תודה על הרכישה, התשלום עבר בהצלחה, הכרטיסים יחכו לכם באולם הקולנוע", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "סגור", style: .cancel, handler: nil))
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: DispatchTime.now().rawValue +  NSEC_PER_SEC * 4)) {
                loader.isHidden = true
                loader.stopAnimate()
                loader.removeFromSuperview()
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.popToRootViewController(animated: true)
                self.present(alert, animated: true)
            }
        }
        
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

