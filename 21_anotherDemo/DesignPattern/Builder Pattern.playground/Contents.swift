
public struct Hamburger {
    public let meat: Meat
    public let sauce: Sauces
    public let toppings: Toppings
}

extension Hamburger: CustomStringConvertible {
    public var description: String {
        return meat.rawValue + "burger"
    }
}

public enum Meat: String {
    case chicken
    case kitten
    case beef
    case tofu
}


public struct Sauces: OptionSet {
    public static let mayonnaise = Sauces(rawValue: 1<<0)
    public static let mustard = Sauces(rawValue: 1<<1)
    public static let ketchup = Sauces(rawValue: 1<<2)
    public static let secret = Sauces(rawValue: 1<<3)
    
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct Toppings: OptionSet{
    
    public static let cheese = Toppings(rawValue: 1<<0)
    public static let lettuce = Toppings(rawValue: 1<<1)
    public static let pickles = Toppings(rawValue: 1<<2)
    public static let tomatoes = Toppings(rawValue: 1<<3)
    
    public let rawValue: Int
    public init(rawValue: Int){
        self.rawValue = rawValue
    }
}


public class HanburgerBuilder {
    public private(set) var meat: Meat = .beef
    public private(set) var sauces: Sauces = []
    public private(set) var toppings: Toppings = []
    private var soldOutMeats: [Meat] = [.kitten]
    
    public func addSauces(_ sauce: Sauces) {
        sauces.insert(sauce)
    }
    
    public func removeSauces(_ sauce: Sauces) {
        sauces.remove(sauce)
    }
    
    public func addToppings(_ topping: Toppings) {
        toppings.insert(topping)
    }
    
    public func removeToppings(_ topping: Toppings) {
        toppings.remove(topping)
    }
    
    public func setMeat(_ meat: Meat) throws {
        guard isAvailable(meat) else { throw Error.soldOut }
        self.meat = meat
    }
    public func isAvailable(_ meat: Meat) -> Bool {
        return !soldOutMeats.contains(meat)
    }
    
    public func build() -> Hamburger {
        return Hamburger(meat: meat, sauce: sauces, toppings: toppings)
    }
}

public enum Error: Swift.Error {
    case soldOut
}


public class Employee {
    public func createCombo1() throws -> Hamburger {
        let builder = HanburgerBuilder()
        try builder.setMeat(.beef)
        builder.addSauces(.secret)
        builder.addToppings([.lettuce,.tomatoes,.pickles])
        return builder.build()
    }
    
    public func createKittenSpecial() throws -> Hamburger {
        let builder = HanburgerBuilder()
        try builder.setMeat(.kitten)
        builder.addSauces(.mustard)
        builder.addToppings([.lettuce,.tomatoes])
        return builder.build()
    }
}

let burgerFlipper = Employee()

if let combo1 = try? burgerFlipper.createCombo1() {
    print("Nom nom" + combo1.description)
}

if let kittenBurger = try? burgerFlipper.createKittenSpecial() {
    print("Nom nom nom" + kittenBurger.description)
} else {
    print("Sorry, no kitten burgers here")
}