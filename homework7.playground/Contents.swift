import Foundation
//1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
//2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

//MARK:- Задание 1

enum VacuumCleanerError: Error {
    case notEnoughBatteryPower    //недостаточно заряда
    case notEnoughSpaceForGarbage //недостаточно места для мусора
    case caughtInATrap            //попал в ловушку
    case notEnoughWater           //недостаточно воды
    
    var description: String {
        switch self {
        case .notEnoughBatteryPower:
            return "Недостаточно заряда"
        case .notEnoughSpaceForGarbage:
            return "Недостаточно места для мусора"
        case .caughtInATrap:
            return "Попал в ловушку"
        case .notEnoughWater:
            return "Недостаточно воды"
        }
    }
}

class RobotVacuumCleaner: CustomStringConvertible {
    var description: String {
        return "Заряд: \(charge)% Заполненность мусором: \(garbageOccupancy)% Количество воды: \(water)%"
    }
    
    var charge = 100
    var garbageOccupancy = 0
    var water = 100
    
    private func isFellIntoTrap() -> Bool {
        return Int.random(in: 1...10) < 3
    }
    
    func cleaning() -> (result: String?, error: VacuumCleanerError?) {
        guard charge >= 30 else {
            return (nil, .notEnoughBatteryPower)
        }
       
        guard garbageOccupancy <= 60 else {
            return (nil, .notEnoughSpaceForGarbage)
        }
        //убирает
        charge -= 30
        garbageOccupancy += 40
        
        if isFellIntoTrap() {
            return (nil, .caughtInATrap)
        }
        return ("Успешно", nil)
    }
    //MARK:- Задание 2
    
    func dailyСleaning() throws {
        guard charge >= 30 else {
            throw (VacuumCleanerError.notEnoughBatteryPower)
        }
        
        guard garbageOccupancy <= 60 else {
            throw (VacuumCleanerError.notEnoughSpaceForGarbage)
        }
        //убирает
        charge -= 30
        garbageOccupancy += 40
        
        if isFellIntoTrap() {
            throw (VacuumCleanerError.caughtInATrap)
        }
    }
    
    func wetСleaning() throws {
        guard charge >= 40 else {
            throw (VacuumCleanerError.notEnoughBatteryPower)
        }
        guard garbageOccupancy <= 50 else {
            throw (VacuumCleanerError.notEnoughSpaceForGarbage)
        }
        guard water >= 45 else {
            throw (VacuumCleanerError.notEnoughWater)
        }
        //убирает
        charge -= 40
        garbageOccupancy += 50
        water -= 45
    }
}

//MARK:- Пробуем применить

var robot1 = RobotVacuumCleaner()
var (result, error) = robot1.cleaning()
if let result = result {
    print(result)
} else if let error = error{
    print(error.description)
}
print(robot1)

let robot2 = RobotVacuumCleaner()
do {
    try robot2.dailyСleaning()
} catch let error {
    if let vacuumCleanerError = error as? VacuumCleanerError {
        print(vacuumCleanerError.description)
    }
}
print(robot2)

var robot3 = RobotVacuumCleaner()
do {
    try robot3.wetСleaning()
} catch let error {
    if let vacuumCleanerError = error as? VacuumCleanerError {
        print(vacuumCleanerError.description)
    }
}
print(robot3)
