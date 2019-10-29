import UIKit

extension UserDefaults {

func set<T: Encodable>(encodable: T, forKey key: String) {
	if let data = try? JSONEncoder().encode(encodable) {
		set(data, forKey: key)
	}
}

func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
	if let data = object(forKey: key) as? Data,
		let value = try? JSONDecoder().decode(type, from: data) {
		return value
	}
	return nil
}

}

class City: Codable {
var name: String?
var latitude: Double?
var longitude: Double?
var currentTime: String?
var currentTemperature: String?
}

var cityTest = City()
cityTest.name = "first city"
cityTest.latitude = 1111
cityTest.longitude = 2222

// Save
UserDefaults.standard.set(encodable: City(), forKey: "CityTest")

print(cityTest.name)
print(cityTest.latitude)
print(cityTest.longitude)
print(cityTest.currentTime)
print(cityTest.currentTemperature)

UserDefaults.standard.synchronize()

// Load
let city = UserDefaults.standard.value(City.self, forKey: "CityTest")

print(city!.name)
print(city!.latitude)
print(city!.longitude)
print(city!.currentTime)
print(city!.currentTemperature)





struct CellPhone : Codable {
	//String, Double confirm to Codable types.
	var name : String?
	var price : Double?
	//OsType are also Codable types
	var operatingSystem : OsType?
	enum CodingKeys : String,CodingKey{
		case name
		case price
		case operatingSystem
	}
}
//String confirm to Codable.
enum OsType  : String, Codable
{
	case android
	case ios
	case windows
	case blackberry
}

class User : NSObject, Codable {
	var name: String?
	var phoneNumber: Int?
	
	//	required init?(coder aDecoder: NSCoder) {
	//		//Returns an object initialized from data in a provided unarchiver.
	//		self.name = aDecoder.decodeObject(forKey: "name") as? String
	//		self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? Int
	//	}
	//
	//	func encode(with aCoder: NSCoder) {
	//		//Encodes the given object using provided archiver.
	//		aCoder.encode(self.name, forKey: "name")
	//		aCoder.encode(self.phoneNumber, forKey: "phoneNumber")
	//	}
}

//create the cellPhoneObject
let cellPhoneObject = CellPhone(name : "IphoneX",price : 100000,operatingSystem : .ios)
let user = User()
user.name = "test"
user.phoneNumber = 12345
var test: [User] = []
test.append(user)

let encodedData = try? JSONEncoder().encode(test)
if let data = encodedData{
	let cellPhoneObject = try? JSONDecoder().decode([User].self,from: data)
}

func save(){
	UserDefaults.standard.set(try? PropertyListEncoder().encode(test), forKey: "test")
}

var test2: [User] = []

func load(){
	if let data = UserDefaults.standard.object(forKey: "test") as? Data {
		test2 = try! PropertyListDecoder().decode([User].self, from: data)
	}
}

save()
load()

print(test)
print(test2)

////encode the object with the help of JSONEncoder.
//let encodedData = try? JSONEncoder().encode(cellPhoneObject)
//
////use the JSONDecoder to decode the encoded data
//if let data = encodedData{
//	let cellPhoneObject = try? JSONDecoder().decode(CellPhone.self,from: data)
//}
