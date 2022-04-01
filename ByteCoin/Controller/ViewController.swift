
import UIKit

class ViewController: UIViewController ,  UIPickerViewDelegate, UIPickerViewDataSource {
 
    let baseURL = "https://blockchain.info/ticker"
    let currencyArray = ["CHF", "TRY", "HUF", "USD", "PLN", "AUD", "CZK", "BRL", "CAD", "CLP", "INR", "THB", "TWD", "GBP", "HKD", "DKK", "EUR", "SGD", "KRW", "RON", "ARS", "CNY", "ISK", "NZD", "RUB", "HRK", "SEK", "JPY"]
    
    var symbol = ["CHF",  "₺", "Ft", "$", "zł", "$", "Kč", "R$","$","$","₹", "฿", "NT$","£", "$","kr","€", "$", "₩", "lei","$","¥","kr","$","₽","kn","kr","¥"]
    var name: [String] = []
    var price: [Double] = []

    
    
    func didFailwithError(_ error: Error) {
        return
    }
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate=self
        self.picker.dataSource=self
       perform(baseURL)
        if let idx =  name.firstIndex(of: "CHF"){
            money.text=String(price[idx])
    }
        
        if let index=currencyArray.firstIndex(of: "CHF"){
        currency.text=String(symbol[index])
        }
    }
    
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var currency: UILabel!
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let val=currencyArray[row]
        
        if let idx =  name.firstIndex(of: val){
            money.text=String(price[idx])
    }
        
        if let index=currencyArray.firstIndex(of: val){
        currency.text=String(symbol[index])
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }


    func perform(_ urlString: String)  {
        // 1. Create a URL
        let myURL = URL(string: urlString)
        
        if myURL != nil{
            // 2. Create a URL Session
            let urlSession = URLSession(configuration: .default)
            // 3. Give the Session a task
            let givenTask = urlSession.dataTask(with: myURL!, completionHandler: handler(data: urlRes:  myerr:))
            // 4. Start the task
            givenTask.resume() }
    }
    
    func handler(data: Data?, urlRes: URLResponse?, myerr: Error?)  {
        if(myerr != nil){
            print(myerr!)
            return
        }
        
        if let recdata = data{
          parseJSON(recdata)
            
        }}

    func parseJSON(_ myData: Data){
        let decoder=JSONDecoder()
        do{
            
    let decodedData = try decoder.decode( [ String : APIData ].self , from: myData)
            
          let obj = APIOBJ(arr: decodedData)

            for(key, value) in obj.arr{
                self.name.append(key)
                self.price.append(value.buy)
             
            }
            
        }catch{
            return
            
        }
        
    }

    
    
}
    

