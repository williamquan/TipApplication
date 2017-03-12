//
//  SettingsViewController.swift
//  TipApplication
//
//  Created by William Quan on 3/6/17.
//  Copyright © 2017 William Quan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tip1Field: UITextField!
    @IBOutlet weak var tip2Field: UITextField!
    @IBOutlet weak var tip3Field: UITextField!
    @IBOutlet weak var themeControl: UISegmentedControl!
    
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipValue1 = round(userDefaults.double(forKey: TipKeys.tipKey1) * 100)
        tipValue2 = round(userDefaults.double(forKey: TipKeys.tipKey2) * 100)
        tipValue3 = round(userDefaults.double(forKey: TipKeys.tipKey3) * 100)
        themeControl.selectedSegmentIndex = userDefaults.object(forKey: themeKey) as! String == Theme.cool ? 0 : 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var tipValue1: Double {
        get {
            return Double(tip1Field.text!) ?? 0
        }
        set {
            tip1Field.text = String(Int(newValue))
        }
    }
    
    var tipValue2: Double {
        get {
            return Double(tip2Field.text!) ?? 0
        }
        set {
            tip2Field.text = String(Int(newValue))
        }
    }

    var tipValue3: Double {
        get {
            return Double(tip3Field.text!) ?? 0
        }
        set {
            tip3Field.text = String(Int(newValue))
        }
    }
    
    @IBAction func updateTip1(_ sender: AnyObject) {
        userDefaults.set(tipValue1 / 100, forKey: TipKeys.tipKey1)
    }
    @IBAction func updateTip2(_ sender: AnyObject) {
        userDefaults.set(tipValue2 / 100, forKey: TipKeys.tipKey2)
    }
    @IBAction func updateTip3(_ sender: AnyObject) {
        userDefaults.set(tipValue3 / 100, forKey: TipKeys.tipKey3)
    }
    @IBAction func changeTheme(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            userDefaults.set(Theme.cool, forKey: themeKey)
        } else {
            userDefaults.set(Theme.warm, forKey: themeKey)
        }
        userDefaults.synchronize()
    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        view.endEditing(true)
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
