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
    
    @IBAction func addProduct(_ sender: Any){
        let alert = UIAlertController(title: "Add Product", message: nil, preferredStyle: .alert)
        alert.addTextField{$0.placeholder = "Product Name"}
        alert.addTextField{$0.placeholder = "Produt Description"}
        alert.addTextField{$0.placeholder = "Product Price"}
        alert.addTextField{$0.placeholder = "Product Provider"}
        
        do{
            try context.save()
            self.fetchProducts()
            self.tableView.reloadData()
        }catch{
            print("Faile to save product: \(error)")
        }
        
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
        present(alert, animated: true)
        
    }
    
extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    return isSearching ? filteredProducts.count : products.count
    
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty{
            isSearching = false
        }else{
            isSearching = true
            filteredProducts = products.filter {
                product in
                return product.productName !.lowercased().contains(searchText.lowercased()) ||
                product.productDescription!.lowercased().contains(searchText.lowercased())            }
        }
        tableView.reloadData()
    }
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


