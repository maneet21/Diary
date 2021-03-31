
//MARK:- Start
import UIKit

class DatePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK:- Outlets
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    //MARK:- Variables Declaration
    var Day: [String] = [String] ()
    var Month: [String] = [String] ()
    var Year: [String] = [String] ()
    
    var day1 = ""
    var month1 = ""
    var year1 = ""
    
    //MARK:- Button Action
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        let day = self.day1
        let month = self.month1
        let year = self.year1
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "diaryDetail") as! DiaryDetailViewController
        nextViewController.day = day
        nextViewController.month = month
        nextViewController.year = year
        
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        let homeViewController = self.storyboard?.instantiateViewController(identifier: "viewController1") as? ViewController
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    //MARK:- User-Defined Function
    func convertToDate(datestring: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        let dateFromString = dateFormatter.date(from: datestring)
        return dateFromString!
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.delegate = self
        self.datePicker.dataSource = self
        
        confirmButton.layer.cornerRadius = 7.5
        signOutButton.layer.cornerRadius = 7.5
        
        Day = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30", "31"]
        Month = ["January","February","March","April","May","June","July","August","September","October","November","December"]
        Year = ["1950","1951","1952","1953","1954","1955","1956","1957","1958","1959","1960","1961","1962","1963","1964","1965","1966","1967","1968","1969","1970","1971","1972","1973","1974","1975","1976","1977","1978","1979","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021"]
    }
    
    //MARK:- Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return Day.count
        }
        else if component == 1 {
            return Month.count
        }
        else {
            return Year.count
        }
     }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
           return Day[row]
        }
        else if component == 1 {
           return Month[row]
        }
        else {
           return Year[row]
        }
     }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            day1 = Day[row]
            dayButton.setTitle(day1, for: .normal)

        }
        else if component == 1 {
            month1 = Month[row]
            monthButton.setTitle(month1, for: .normal)
        }
        else {
            year1 = Year[row]
            yearButton.setTitle(year1, for: .normal)
        }
    }
}
//MARK:- End
