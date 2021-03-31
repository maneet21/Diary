
//MARK:- Start
import UIKit
import CoreData

class NoteViewController: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var textView: UITextView!
    
    //MARK:- Variable And Constant Declaration
    var note1: [NSManagedObject] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
//MARK:- End
