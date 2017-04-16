//: Playground - noun: a place where people can play

import UIKit
/*************使用可选链代替强制解包**************/
class Player {
    var name:String = "player name"
}

class Game {
    var player : Player?
}

let game = Game()

//强制解包，将会引发运行时错误
//let name = game.player!.name

if let name = game.player?.name {
    print("Player name : \(name).")
} else {
    print("Unable get Player name.")
}
//打印：Unable get Player name.

game.player = Player()

if let name = game.player?.name {
    print("Player name : \(name).")
} else {
    print("Unable get Player name.")
}
//打印：Player name : player name


/***************可选链应用在类上*************/
class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(String(describing: buildingNumber)) \(String(describing: street))"
        } else {
            return nil
        }
    }
}

//访问属性
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// 打印：Unable to retrieve the number of rooms.

//设定属性的值
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress //赋值不会被执行

//访问方法
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// 打印：It was not possible to print the number of rooms.

//访问下标
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// 打印：Unable to retrieve the first room name.

//下标赋值
john.residence?[0] = Room(name: "Bathroom")

//下标和属性组合使用
let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// 打印：The first room name is Living Room.


//john.residence?.address?.street的返回值也依然是String?，
//即使已经使用了两层可选链式调用。
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// 打印 “Unable to retrieve the address.”


if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
// 打印：John's building identifier begins with "The".