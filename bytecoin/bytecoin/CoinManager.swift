
import Foundation

protocol mydelegate {
    
    //Create the method stubs wihtout implementation in the protocol.
    //It's usually a good idea to also pass along a reference to the current class.
    //e.g. func didUpdatePrice(_ coinManager: CoinManager, price: String, currency: String)
    //Check the Clima module for more info on this.
    func didUpdatePrice(price: String)
    
}

struct CoinManager {
   
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "F5FE9672-4C79-4ADD-954C-AC4E4B5582A6"
     var delegate: mydelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = baseURL+"/\(currency)?apikey=\(apiKey)"
        //print(URL)
       performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String)
    {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){(data,response,error) in
                if error != nil{
                    return
                }
                
               // let dataString = String(bytes: data, encoding: .utf8)
                
                if let safedata = data{
                    if let bitcoinPrice = self.parseData(safedata) {
                        
                        //Optional: round the price down to 2 decimal places.
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        
                        //Call the delegate method in the delegate (ViewController) and
                        //pass along the necessary data.
                        self.delegate?.didUpdatePrice(price: priceString)
                    }
                
            }
            
            
            
        }
            task.resume()
            
        }
    }
        func parseData(_ data : Data)->Double?{
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CoinData.self, from: data)
                print(decodedData.rate)
                return decodedData.rate
            } catch  {
                print(error)
                return 0.00
            }
        }
        
    }
  
    
    

