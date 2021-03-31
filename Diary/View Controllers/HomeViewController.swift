
//MARK:- Start
import UIKit

class HomeViewController: UIViewController {

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "datePicker") as! DatePickerViewController
  
            self.view.window?.rootViewController = nextViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
//MARK:- End
