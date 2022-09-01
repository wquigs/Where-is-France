//
//  ColorChangerViewController.swift
//  Where Is France
//
//  Created by will quigley on 4/21/22.
// Corey Briscoe corbrisc
// Blythe Hammett blhamm
// William Quigley wquigley

import UIKit

class ColorChangerViewController: UIViewController {
    
    @IBOutlet weak var colorPicked: UILabel!
    
    var quiver:[PointArrow] = []
    
    var appDelegate: AppDelegate?
    var myModel: Model?

    //creating an array to hold the arrow item so it is accesible with the button pressed functions
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //if there is no arrow make an arrow
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        reload()
        if quiver.isEmpty{
            let arrow = PointArrow(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
            quiver.append(arrow)
        }
        colorPicked.text = quiver[0].aColor
    }
    
    //let arrow = Arrow(context: context)
    
    func reload(){
        do{
            quiver = try context.fetch(PointArrow.fetchRequest())
        }catch{
            print("error")
        }
    }
    
    @IBAction func RedButtonPressed(_ sender: Any) {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        quiver[0].aColor = "red"
        colorPicked.text = quiver[0].aColor
        do{
            try context.save()
        }catch{
            print("error saving")
        }
    }
    
    @IBAction func blueButtonPressed(_ sender: Any) {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.myModel = self.appDelegate?.myModel
        quiver[0].aColor = "blue"
        colorPicked.text = quiver[0].aColor
        do{
            try context.save()
        }catch{
            print("error saving")
        }
    }
    
    @IBAction func yellowButtonPressed(_ sender: Any) {
        quiver[0].aColor = "yellow"
        colorPicked.text = quiver[0].aColor
        do{
            try context.save()
        }catch{
            print("error saving")
        }
    }
    
    @IBAction func greenButtonPressed(_ sender: Any) {
        quiver[0].aColor = "green"
        colorPicked.text = quiver[0].aColor
        do{
            try context.save()
        }catch{
            print("error saving")
        }
    }
    
    @IBAction func orangeButtonPressed(_ sender: Any) {
        quiver[0].aColor = "orange"
        colorPicked.text = quiver[0].aColor
        do{
            try context.save()
        }catch{
            print("error saving")
        }
    }
    
    @IBAction func pinkButtonPressed(_ sender: Any) {
        quiver[0].aColor = "pink"
        colorPicked.text = quiver[0].aColor
        do{
            try context.save()
        }catch{
            print("error saving")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
