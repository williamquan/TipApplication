//
//  TipViewController.swift
//  TipApplication
//
//  Created by William Quan on 3/6/17.
//  Copyright © 2017 William Quan. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tipView1: UIView!
    @IBOutlet weak var tipView2: UIView!
    @IBOutlet weak var tipView3: UIView!
    
    @IBOutlet weak var tipLabel1: UILabel!
    @IBOutlet weak var tipLabel2: UILabel!
    @IBOutlet weak var tipLabel3: UILabel!
    
    @IBOutlet weak var tipAmountLabel1: UILabel!
    @IBOutlet weak var tipAmountLabel2: UILabel!
    @IBOutlet weak var tipAmountLabel3: UILabel!
    
    @IBOutlet weak var totalLabel1: UILabel!
    @IBOutlet weak var totalLabel2: UILabel!
    @IBOutlet weak var totalLabel3: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    let billColor = UIColor.init(red: 255/255, green: 255/255, blue: 153/255, alpha: 0.2)
    
    let coolColorBlue = UIColor.init(red: 0/255, green: 113/255, blue: 188/255, alpha: 1)
    let coolColorBlack = UIColor.init(red: 5/255, green: 0/255, blue: 0/255, alpha: 1)
    let coolColorGreen = UIColor.init(red: 0/255, green: 252/255, blue: 143/255, alpha: 1)
    
    let warmColorYellow = UIColor.init(red: 247/255, green: 234/255, blue: 0/255, alpha: 1)
    let warmColorPurple = UIColor.init(red: 240/255, green: 0/255, blue: 244/255, alpha: 1)
    let warmColorRed = UIColor.init(red: 249/255, green: 0/255, blue: 4/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let userdefaults = UserDefaults.standard
        tipLabel1.text = "%\(Int(round(userdefaults.double(forKey: TipKeys.tipKey1)*100)))"
        tipLabel2.text = "%\(Int(round(userdefaults.double(forKey: TipKeys.tipKey2)*100)))"
        tipLabel3.text = "%\(Int(round(userdefaults.double(forKey: TipKeys.tipKey3)*100)))"
        
        UIView.animate(withDuration: 1.0, animations: {
            if userdefaults.object(forKey: themeKey) as! String == Theme.warm {
                self.initWarm()
            } else {
                self.initCool()
            }
        }) 
        calculateTip(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var billAmount: Double {
        get {
            return Double(billField.text!) ?? 0
        }
        set {
            billField.text = "$\(String(format: "%.2f", newValue))"
        }
    }

    var total1: Double {
        get {
            return Double(totalLabel1.text!) ?? 0
        }
        set {
            totalLabel1.text = "$\(String(format: "%.2f", newValue))"
        }
    }
    var total2: Double {
        get {
            return Double(totalLabel2.text!) ?? 0
        }
        set {
            totalLabel2.text = "$\(String(format: "%.2f", newValue))"
        }
    }
    var total3: Double {
        get {
            return Double(totalLabel3.text!) ?? 0
        }
        set {
            totalLabel3.text = "$\(String(format: "%.2f", newValue))"
        }
    }
    
    var tipAmount1: Double {
        get {
            return Double(tipLabel1.text!) ?? 0
        }
        set {
            tipAmountLabel1.text = "(\(String(format: "%.2f", newValue)))"
        }
    }
    var tipAmount2: Double {
        get {
            return Double(tipLabel2.text!) ?? 0
        }
        set {
            tipAmountLabel2.text = "(\(String(format: "%.2f", newValue)))"
        }
    }
    var tipAmount3: Double {
        get {
            return Double(tipLabel3.text!) ?? 0
        }
        set {
            tipAmountLabel3.text = "(\(String(format: "%.2f", newValue)))"
        }
    }
   
    @IBAction func calculateTip(_ sender: AnyObject) {
        if billField.text != "" && self.mainView.backgroundColor != billColor {
            UIView.animate(withDuration: 1.0, animations: { [weak self] in
                self?.mainView.backgroundColor = self?.billColor
            }) 
        }
        let userDefaults = UserDefaults.standard
        let tipPercent1 = userDefaults.double(forKey: TipKeys.tipKey1)
        let tipPercent2 = userDefaults.double(forKey: TipKeys.tipKey2)
        let tipPercent3 = userDefaults.double(forKey: TipKeys.tipKey3)
        
        tipAmount1 = billAmount * tipPercent1
        tipAmount2 = billAmount * tipPercent2
        tipAmount3 = billAmount * tipPercent3
        total1 = (billAmount * tipPercent1) + billAmount
        total2 = (billAmount * tipPercent2) + billAmount
        total3 = (billAmount * tipPercent3) + billAmount
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        billField.resignFirstResponder()
    }
    
    fileprivate func initWarm() {
        self.tipView1.backgroundColor = self.warmColorYellow
        self.tipView2.backgroundColor = self.warmColorPurple
        self.tipView3.backgroundColor = self.warmColorRed
        for view in self.stackView.subviews {
            if view.isKind(of: UIView.self) {
                for sub in view.subviews {
                    if sub.isKind(of: UILabel.self) {
                        let label = sub as! UILabel
                        label.textColor = UIColor.black
                    }
                }
            }
        }
    }
    
    fileprivate func initCool() {
        tipView1.backgroundColor = coolColorGreen
        tipView2.backgroundColor = coolColorBlue
        tipView3.backgroundColor = coolColorBlack
        for view in stackView.subviews {
            if view.isKind(of: UIView.self) {
                for sub in view.subviews {
                    if sub.isKind(of: UILabel.self) {
                        let label = sub as! UILabel
                        label.textColor = UIColor.white
                    }
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
