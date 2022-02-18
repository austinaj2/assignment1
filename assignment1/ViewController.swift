//
//  ViewController.swift
//  assignment1
//
//  Created by Macky Cisse on 2/15/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var courseTitle: UITextField!
    @IBOutlet weak var assignPoints: UITextField!
    @IBOutlet weak var midtermPoints: UITextField!
    @IBOutlet weak var finalPoints: UITextField!
    @IBOutlet weak var assignMax: UITextField!
    @IBOutlet weak var midtermMax: UITextField!
    @IBOutlet weak var finalMax: UITextField!
    @IBOutlet weak var assignPct: UITextField!
    @IBOutlet weak var midtermPct: UITextField!
    @IBOutlet weak var finalPct: UITextField!
    @IBOutlet weak var creditsField: UITextField!
    @IBOutlet weak var courseID: UITextField!

    @IBOutlet weak var addCourseBtn: UIButton!
    @IBOutlet weak var deleteCourseBtn: UIButton!
    
    @IBOutlet weak var boardView: UITextView!
    
    var workings:String = ""
    var coursesArr: Array<Course> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //
    // boardView.text += name+"\n"

    @IBAction func addCourseClicked(_ sender: Any) {
        let c = Course()
        var s = scaledScore()
        var aTotal = 0.0
        var mTotal = 0.0
        var fTotal = 0.0

        if courseTitle.hasText, let name = courseTitle.text {
            c.cName = name
        }
        else {
            print("*Course title!")
        }
        for i in coursesArr {
            if i.cName == c.cName {
                print("*Name already in use")
            }
        }
        if assignPoints.hasText, let aP = assignPoints.text {
            if let num = Double(aP) {
                s.points = num
            }
            else {
                print("*Valid number")
            }
        }
        if assignMax.hasText, let aM = assignMax.text {
            if let num = Double(aM) {
                s.max = num
            }
            else {
                print("*Valid number")
            }
        }
        if assignPct.hasText, let aPercent = assignPct.text {
            if let num = Double(aPercent) {
                s.percent = num
            }
            else {
                print("*Valid number")
            }
        }
        
        if s.points > s.max || s.points < 0 {
            print("*Points greater than max")
        }
        s.total = (s.points/s.max)*(s.percent)
        c.assignScore = s.total
        aTotal = s.percent
        s = scaledScore(points: 0, max: 0, percent: 0, total: 0)
        
        if midtermPoints.hasText, let mP = midtermPoints.text {
            if let num = Double(mP) {
                s.points = num
            }
            else {
                print("*Valid number")
            }
        }
        if midtermMax.hasText, let mM = midtermMax.text {
            if let num = Double(mM) {
                s.max = num
            }
            else {
                print("*Valid number")
            }
        }
        if midtermPct.hasText, let mPercent = midtermPct.text {
            if let num = Double(mPercent) {
                s.percent = num
            }
            else {
                print("*Valid number")
            }
        }
        
        if s.points > s.max || s.points < 0 {
            print("*Points greater than max")
        }
        s.total = (s.points/s.max)*(s.percent)
        c.midtermScore = s.total
        mTotal = s.percent
        s = scaledScore(points: 0, max: 0, percent: 0, total: 0)
        
        if finalPoints.hasText, let fP = finalPoints.text {
            if let num = Double(fP) {
                s.points = num
            }
            else {
                print("*Valid number")
            }
        }
        if finalMax.hasText, let fM = finalMax.text {
            if let num = Double(fM) {
                s.max = num
            }
            else {
                print("*Valid number")
            }
        }
        if finalPct.hasText, let fPercent = finalPct.text {
            if let num = Double(fPercent) {
                s.percent = num
            }
            else {
                print("*Valid number")
            }
        }
        
        if s.points > s.max || s.points < 0 {
            print("*Points greater than max")
        }
        s.total = (s.points/s.max)*(s.percent)
        c.finalScore = s.total
        fTotal = s.percent
        s = scaledScore(points: 0, max: 0, percent: 0, total: 0)
        
        if creditsField.hasText, let cred = creditsField.text {
            if let num = Int(cred), num <= 4 {
                c.credits = num
            }
            else {
                print("*Valid credit number")
            }
        }
        if !creditsField.hasText {
            print("*Provide a credit number")
        }
        
        let percentCheck = aTotal + mTotal + fTotal
        
        if percentCheck != 100.0 {
            print("*Percents don't add to 100")
        }
        
        let grandTotal = c.assignScore + c.midtermScore + c.finalScore
        
        print("grandTotal \(grandTotal)")
        if grandTotal < 60.0 {
            c.grade = "F"
            c.letterScore = 0.0
        }
        else if grandTotal < 70.0 && grandTotal >= 60.0 {
            c.grade = "D"
            c.letterScore = 1.0
        }
        else if grandTotal < 80.0 && grandTotal >= 70.0 {
            c.grade = "C"
            c.letterScore = 2.0
        }
        else if grandTotal < 90.0 && grandTotal >= 80.0 {
            c.grade = "B"
            c.letterScore = 3.0
        }
        else {
            c.grade = "A"
            c.letterScore = 4.0
        }
        
        if coursesArr.count < 4 {
            coursesArr.append(c)
            var index = 1
            var str = ""
            var score = 0.0
            var creditTotal = 0
            for course in coursesArr {
                creditTotal += course.credits
                str += "\(index)) "+course.cName+" | "+"\(course.credits) - "+course.grade+"\n"
                index += 1
                score += course.letterScore*Double(course.credits)
            }
            print(score)
            print(creditTotal)
            let gpa = score/Double(creditTotal)
            str += "\nGPA: \(gpa)"
            boardView.text = str
            //GPA calculation here
        }
        assignPoints.text = ""
        assignPct.text = ""
        assignMax.text = ""
        midtermPct.text = ""
        midtermMax.text = ""
        midtermPoints.text = ""
        finalPct.text = ""
        finalMax.text = ""
        finalPoints.text = ""
        courseTitle.text = ""
        creditsField.text = ""



        
    }

}

struct scaledScore {
    var points:Double = 0.0
    var max:Double = 0.0
    var percent:Double = 0.0
    var total:Double = 0.0
}
class Course {
    var cName = ""
    var assignScore:Double = 0.0
    var midtermScore:Double = 0.0
    var finalScore:Double = 0.0
    var credits:Int = 0
    var grade:String = ""
    var letterScore:Double = 0.0
}
