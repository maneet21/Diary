
//MARK:- Start
import UIKit
import CoreData

class DiaryDetailViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    //MARK:- Variables And Constant Declaration
    var note1: [NSManagedObject] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var day = ""
    var month = ""
    var year = ""

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        dayLabel.text = day
        monthLabel.text = month
        yearLabel.text = year
    }
 
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }

      let managedContext = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")

      do {
        note1 = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
    //MARK:- Button Action
    @IBAction func addText(_ sender: UIButton) {
        let alert = UIAlertController(title: "NEW NOTE", message: "Add a new note.", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                  let noteToSave = textField.text else {
                return
            }
            self.save(text: noteToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    //MARK:- User-Defined Function
    func save(text: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
        note.setValue(text, forKeyPath: "text")
        
        do {
            try managedContext.save()
            note1.append(note)
        } catch let error as NSError {
            print("Could not save,  \(error), \(error.userInfo)" )
        }
    }
}

//MARK:- Table View
extension DiaryDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return note1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text1 = note1[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = text1.value(forKeyPath: "text") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "Note") as! NoteViewController
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            self.context.delete(self.note1[indexPath.row])
            
            do {
                try self.context.save()
            } catch {
                print("Error while saving")
            }
            
            self.note1.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
//MARK:- End
