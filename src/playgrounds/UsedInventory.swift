
import Foundation
import PlaygroundSupport

struct AddressRequest: Codable {
    let postalCode: String
    let countryCode: String
    let csrfName: String
    let csrfValue: String
    
    private enum CodingKeys: String, CodingKey {
        case postalCode = "postal_code"
        case countryCode = "country_code"
        case csrfName = "csrf_name"
        case csrfValue = "csrf_value"
    }
}

struct AddressModel: Codable {
    let city: String
    let stateProvince: String
    let postalCode: String
    let countryCode: String
    let countryName: String
    let longitude: Double
    let latitude: Double
    let county: String
    let stateCode: String
}

struct AddressResponse: Codable {
    let data: AddressModel
    let code: Int
}

struct InventoryOptionsModel: Codable {
}

struct InventoryQueryModel: Codable {
    let model: String
    let condition: String
    let options: InventoryOptionsModel
    let arrangeby: String
    let order: String
    let market: String
    let language: String
    let superRegion: String
    let lng: Double
    let lat: Double
    let zip: String
    let range: Int
    let region: String
    
    private enum CodingKeys: String, CodingKey {
        case model
        case condition
        case options
        case arrangeby
        case order
        case market
        case language
        case superRegion = "super_region"
        case lng
        case lat
        case zip
        case range
        case region
    }
}

struct InventoryRequest: Codable {
    let query: InventoryQueryModel
    let offset: Int
    let count: Int
    let outsideOffset:Int
    let outsideSearch: Bool
}

enum InventoryModel: String {
    case modelS = "ms"
    case model3 = "m3"
    case modelX = "mx"
    case modelY = "my"
    
    var value: String {
        return self.rawValue
    }
}

enum InventoryPaint: String {
    case black = "BLACK"
    case white = "WHITE"
    case blue = "BLUE"
    case red = "RED"
    
    var value: String {
        return self.rawValue
    }
}

enum InventoryWheel: Int {
    case r18 = 18
    case r19 = 19
    case r20 = 20
    case r21 = 21
    case r22 = 22
    
    var value: Int {
        return self.rawValue
    }
}

struct InventoryItemModel: Sendable, Equatable, Comparable, Codable {
    let model: String
    let odometer: Int
    let monroneyPrice: Int
    let paint: [String]
    let price: Int
    let purchasePrice: Int
    let transportationFee: Int
    let vin: String
    let vehicleHistory: String
    let trimName: String
    let year: Int
    let wheels: [String]
    
    private enum CodingKeys: String, CodingKey, CustomStringConvertible {
        case model = "Model"
        case odometer = "Odometer"
        case monroneyPrice = "MonroneyPrice"
        case paint = "PAINT"
        case price = "Price"
        case purchasePrice = "PurchasePrice"
        case transportationFee = "TransportationFee"
        case vin = "VIN"
        case vehicleHistory = "VehicleHistory"
        case trimName = "TrimName"
        case year = "Year"
        case wheels = "WHEELS"
    }
    
    var finalPrice: Int {
        self.price + self.transportationFee
    }
    
    var color: String {
        self.paint.first ?? "OTHER"
    }
    
    var tire: String {
        self.wheels.first ?? "OTHER"
    }
    
    public static func == (lhs: InventoryItemModel, rhs: InventoryItemModel) -> Bool {
        return
            lhs.vin == rhs.vin
    }
    
    public static func < (lhs: InventoryItemModel, rhs: InventoryItemModel) -> Bool {
        
        if lhs.finalPrice < rhs.finalPrice {
            return true
        } else {
            return lhs.color.compare(rhs.color) == .orderedAscending
        }
    }
    
    var description: String {
        "\(self.finalPrice): \(self.trimName)\n\(self.color) \(self.tire)"
    }
}

struct InventoryResponse: Codable {
    let results: [InventoryItemModel]
    let totalMatchesFound: String
    
    private enum CodingKeys: String, CodingKey {
        case results
        case totalMatchesFound = "total_matches_found"
    }
}

struct MethodValue {
    static let get = "GET"
    static let post = "POST"
}

struct HeadersFields {
    static let userAgent = "User-Agent"
    static let referer = "Referer"
    static let origin = "Origin"
}

struct HeaderValues {
    static let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.1 Safari/605.1.15"
    static func referer(model: InventoryModel, zip: String) -> String {
        "https://www.tesla.com/inventory/used/\(model.rawValue)?arrangeby=plh&zip=\(zip)"
    } 
    static let origin = "https://www.tesla.com"
}

func token(model: InventoryModel, zip: String) async throws -> Void {
    guard var url = URL(string: "https://www.tesla.com/") else {
        print("Error")
        return 
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = MethodValue.get
    request.addValue(HeaderValues.userAgent, forHTTPHeaderField: HeadersFields.userAgent)
    request.addValue(HeaderValues.referer(model: model, zip: zip), forHTTPHeaderField: HeadersFields.referer)
    request.addValue(HeaderValues.origin, forHTTPHeaderField: HeadersFields.origin)
    
    let session = URLSession.shared
    
    let result = try await session.data(for: request, delegate: nil)
    
    return
}

func address(model: InventoryModel, zip: String) async throws -> Void {
    guard let url = URL(string: "https://www.tesla.com/inventory/api/v1/address") else {
        print("Error")
        return 
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = MethodValue.post
    request.addValue(HeaderValues.userAgent, forHTTPHeaderField: HeadersFields.userAgent)
    request.addValue(HeaderValues.referer(model: model, zip: zip), forHTTPHeaderField: HeadersFields.referer)
    request.addValue(HeaderValues.origin, forHTTPHeaderField: HeadersFields.origin)
    
    let body = AddressRequest(postalCode: "27539", countryCode: "US", csrfName: "", csrfValue: "")
    do {
        let data = try JSONEncoder().encode(body)
        request.httpBody = data
        
        let session = URLSession.shared
        
        let result = try await session.data(for: request, delegate: nil)
        
        let json = try JSONDecoder().decode(AddressResponse.self, from: result.0)
        
        let response = result.1 as? HTTPURLResponse
        print(response?.statusCode)
        
    } catch {
        print(error)
    }
}

func inventory(model: InventoryModel, zip: String) async throws -> [InventoryItemModel] {
    let inventoryModel = InventoryQueryModel(
        model: model.value, 
        condition: "used", 
        options: InventoryOptionsModel(), 
        arrangeby: "Price", 
        order: "asc", 
        market: "US", 
        language: "en", 
        superRegion: "north america", 
        lng: -78.7589558, 
        lat: 35.6814022, 
        zip: zip, 
        range: 0, 
        region: "NC"
    )
    let inventoryRequest = InventoryRequest(
        query: inventoryModel, 
        offset: 50, 
        count: 50, 
        outsideOffset: 0, 
        outsideSearch: true
    )
    
    let data = try JSONEncoder().encode(inventoryRequest)
    guard let queryString = String(data: data, encoding: .utf8) else {
        print("Error")
        return []
    }
    guard var escapedString = queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        print("Error")
        return []
    }
    escapedString = escapedString.replacingOccurrences(of: ":", with: "%3A")
    escapedString = escapedString.replacingOccurrences(of: ",", with: "%2C")
    
    guard let url = URL(string: "https://www.tesla.com/inventory/api/v1/inventory-results?query=" + escapedString) else {
        print("Error")
        return []
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = MethodValue.get
    request.addValue(HeaderValues.userAgent, forHTTPHeaderField: HeadersFields.userAgent)
    request.addValue(HeaderValues.referer(model: model, zip: zip), forHTTPHeaderField: HeadersFields.referer)
    request.addValue(HeaderValues.origin, forHTTPHeaderField: HeadersFields.origin)
    let session = URLSession.shared
    
    do {
        let result = try await session.data(for: request, delegate: nil)
        
        let models = try JSONDecoder().decode(InventoryResponse.self, from: result.0)
        
        let response = result.1 as? HTTPURLResponse
        print(response?.statusCode)
        return models.results
    } catch {
        print(error)
        return []
    }
}

let model: InventoryModel = .model3
let zip = "27502"
let maxPrice = 65000

Task {
    try await token(model: model, zip: zip)
    try await address(model: model, zip: zip)
    let cars = try await inventory(model: model, zip: zip)
    let viableCars = cars.sorted()
    viableCars.forEach { car in
        if car.finalPrice > maxPrice {
            return
        }
        print(car)
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
