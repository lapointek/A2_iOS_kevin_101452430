import UIKit
import CoreData

class ProductListViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var products: [Product] = []
    var filteredProducts: [Product] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        tableView.reloadData()
    }
    func fetchProducts(){
        guard let applDelegate = UIApplication.shared.delegate as? AppDelegate else{
            
        return }
        let context = appDelegate.persitnentContrainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do{
            products = try context.fetch(fetchRequest)
        }catch{
            print("Failed to fetch products: \(error)")
        }
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    return isSearching ? filteredProducts.count : prodcuts.count
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProcutCell", for: indexPath)
    let product = isSearching ? filteredProducts[indexPath.row] : products[indexPath.row]
    
    cell.textLabel?.text = product.productName
    cell.detailTextLabel?.text = product.productDescription
    return cell
}

extension ProductListViewController: UISearchBarDelegate{
    
}




