//
//  ViewController.swift
//  SystemSolver
//
//  Created by Lance Sigersmith on 3/1/19.
//  Copyright © 2019 Lance Sigersmith. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var solveButton: UIButton?
    @IBOutlet var outputField : UITextView?
    @IBOutlet var sys1 : UILabel?
    @IBOutlet var sys2 : UILabel?
    @IBOutlet var sys3 : UILabel?
    @IBOutlet var toolbar : UIView?
    
    
    var sys1_coeff1 : Double = 0
    var sys1_coeff2 : Double = 0
    var sys1_coeff3 : Double = 0
    
    var sys2_coeff1 : Double = 0
    var sys2_coeff2 : Double = 0
    var sys2_coeff3 : Double = 0
    
    var sys3_coeff1 : Double = 0
    var sys3_coeff2 : Double = 0
    var sys3_coeff3 : Double = 0
    
    var sys1_solution : Double = 0
    var sys2_solution : Double = 0
    var sys3_solution : Double = 0
    
    var activeTextField = UITextField()

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    @IBAction func neg(sender: UIButton) {
        
        let activeTextFieldText = self.activeTextField.text
        activeTextField.text = "\(activeTextFieldText ?? "")-"
        
    }
    
    @IBAction func dec(sender: UIButton) {
    
        let activeTextFieldText = self.activeTextField.text
        activeTextField.text = "\(activeTextFieldText ?? "")."
        
    }
    
    @IBAction func solve(sender: UIButton) {
        sys1_coeff1 = Double((self.view.viewWithTag(1) as? UITextField)?.text ?? "0") ?? 0
        sys1_coeff2 = Double((self.view.viewWithTag(2) as? UITextField)?.text ?? "0") ?? 0
        sys1_coeff3 = Double((self.view.viewWithTag(3) as? UITextField)?.text ?? "0") ?? 0
        
        sys2_coeff1 = Double((self.view.viewWithTag(4) as? UITextField)?.text ?? "0") ?? 0
        sys2_coeff2 = Double((self.view.viewWithTag(5) as? UITextField)?.text ?? "0") ?? 0
        sys2_coeff3 = Double((self.view.viewWithTag(6) as? UITextField)?.text ?? "0") ?? 0
        
        sys3_coeff1 = Double((self.view.viewWithTag(7) as? UITextField)?.text ?? "0") ?? 0
        sys3_coeff2 = Double((self.view.viewWithTag(8) as? UITextField)?.text ?? "0") ?? 0
        sys3_coeff3 = Double((self.view.viewWithTag(9) as? UITextField)?.text ?? "0") ?? 0
        
        sys1_solution = Double((self.view.viewWithTag(10) as? UITextField)?.text ?? "0") ?? 0
        sys2_solution = Double((self.view.viewWithTag(20) as? UITextField)?.text ?? "0") ?? 0
        sys3_solution = Double((self.view.viewWithTag(30) as? UITextField)?.text ?? "0") ?? 0
        
        var abort = false
        var error : String?
        for var i in 1...12 {
            
            var tag = i
            switch (tag) {
            case 11:
                tag = 20
                break;
            case 12:
                tag = 30
            default:
                break;
            }
            if (((self.view.viewWithTag(tag) as? UITextField)?.text)?.isDouble == false) {
                abort = true
                error = ((self.view.viewWithTag(tag) as? UITextField)?.text)
            }
            if (((self.view.viewWithTag(tag) as? UITextField)?.text) == "") {
                abort = true
                error = ""
            }
            i = i + 1
        }
        
        if (abort == true) {
            //Error Mssg
            let alert = UIAlertController(title: "Number Not Recognized", message: "'\(error ?? "")' is not a recognized number. ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
        
        let solutions = solveSystem()
        let x = solutions[0]
        let y = solutions[1]
        let z = solutions[2]
        
        sys1?.text = "\(sys1_coeff1)x + \(sys1_coeff2)y + \(sys1_coeff3)z = \(sys1_solution)"
        sys2?.text = "\(sys2_coeff1)x + \(sys2_coeff2)y + \(sys2_coeff3)z = \(sys2_solution)"
        sys3?.text = "\(sys3_coeff1)x + \(sys3_coeff2)y + \(sys3_coeff3)z = \(sys3_solution)"
        
        outputField?.text = "X = \(x);\n Y = \(y);\n Z = \(z);"
        
        }
        
    }

    func solveSystem() -> Array<Double> {
        
        
        //Determine Determinant
        
        //D = 1.1 |2.2 2.3| - 1.2 |2.1 2.3| + 1.3 |2.1 2.2|
        //        |3.2 3.3|       |3.1 3.3|       |3.1 3.2|
        
        //D =       1.1((2.2*3.3)-(2.3*3.2))- 1.2((2.1*3.3) - (2.3*3.1)) + 1.3((2.1*3.2) - (2.2*3.1))
        
        let d_term1 = sys1_coeff1 * ((sys2_coeff2*sys3_coeff3) - (sys2_coeff3*sys3_coeff2))
        let d_term2 = sys1_coeff2 * ((sys2_coeff1*sys3_coeff3) - (sys2_coeff3*sys3_coeff1))
        let d_term3 = sys1_coeff3 * ((sys2_coeff1*sys3_coeff2) - (sys2_coeff2*sys3_coeff1))
        
        let d = d_term1 - d_term2 + d_term3
        
        //Determine Dx
        
        //Dx =
        let dx_term1 = sys1_solution * ((sys2_coeff2*sys3_coeff3) - (sys2_coeff3*sys3_coeff2))
        let dx_term2 = sys1_coeff2 * ((sys2_solution*sys3_coeff3) - (sys2_coeff3*sys3_solution))
        let dx_term3 = sys1_coeff3 * ((sys2_solution*sys3_coeff2) - (sys2_coeff2*sys3_solution))
        
        let dx = dx_term1 - dx_term2 + dx_term3
        
        //Dy =
        
        let dy_term1 = sys1_coeff1 * ((sys2_solution*sys3_coeff3) - (sys2_coeff3*sys3_solution))
        let dy_term2 = sys1_solution * ((sys2_coeff1*sys3_coeff3) - (sys2_coeff3*sys3_coeff1))
        let dy_term3 = sys1_coeff3 * ((sys2_coeff1*sys3_solution) - (sys2_solution*sys3_coeff1))
        
        let dy = dy_term1 - dy_term2 + dy_term3
        
        //Dz =
        
        let dz_term1 = sys1_coeff1 * ((sys2_coeff2*sys3_solution) - (sys2_solution*sys3_coeff2))
        let dz_term2 = sys1_coeff2 * ((sys2_coeff1*sys3_solution) - (sys2_solution*sys3_coeff1))
        let dz_term3 = sys1_solution * ((sys2_coeff1*sys3_coeff2) - (sys2_coeff2*sys3_coeff1))
        
        let dz = dz_term1 - dz_term2 + dz_term3
        
        //x = Dx/D
        //y = Dy/D
        //z = Dz/D
        
        let x = dx/d
        let y = dy/d
        let z = dz/d
        
        let solutions = [x, y, z]
        return solutions
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        
        toolbar?.backgroundColor = UIColor(red:0.83, green:0.82, blue:0.81, alpha:1.0)
        UITextField.appearance().inputAccessoryView = toolbar
        
        (self.view.viewWithTag(1) as? UITextField)?.delegate = self
        (self.view.viewWithTag(2) as? UITextField)?.delegate = self
        (self.view.viewWithTag(3) as? UITextField)?.delegate = self
        
        (self.view.viewWithTag(4) as? UITextField)?.delegate = self
        (self.view.viewWithTag(5) as? UITextField)?.delegate = self
        (self.view.viewWithTag(6) as? UITextField)?.delegate = self
        
        (self.view.viewWithTag(7) as? UITextField)?.delegate = self
        (self.view.viewWithTag(8) as? UITextField)?.delegate = self
        (self.view.viewWithTag(9) as? UITextField)?.delegate = self
        
        (self.view.viewWithTag(10) as? UITextField)?.delegate = self
        (self.view.viewWithTag(20) as? UITextField)?.delegate = self
        (self.view.viewWithTag(30) as? UITextField)?.delegate = self
        
        let negative = toolbar?.viewWithTag(100)
        let decimal = toolbar?.viewWithTag(200)
        
        
        
        negative?.layer.cornerRadius = 5
        decimal?.layer.cornerRadius = 5
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

