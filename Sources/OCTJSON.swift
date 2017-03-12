//
//  OCTJSON.swift
//  OCTJSON
//
//  Created by yuhan zhang on 7/18/16.
//  Copyright © 2016 octopus. All rights reserved.
//


public typealias JSON = Json



public extension JSON {
    
    public init(_ value: Any) {
        
        if let int = value as? Int {
            self = .number(Double(int))
        } else if let double = value as? Double {
            self = .number(double)
        } else if let float = value as? Float {
            self = .number(Double(float))
        } else if let string = value as? String {
            self = .string(string)
        } else if let bool = value as? Bool {
            self = .bool(bool)
        } else {
            self = .null
        }
        
    }
    
    
    
    public init(_ value: [Any]) {
        var json = [JSON]()
        for any in value {
            if JSON.isAnyArray(any) {
                var anys = [Any]()
                if let any = any as? [String] {
                    for s in any { anys.append(s) }
                } else if let any = any as? [Int] {
                    for s in any { anys.append(s) }
                } else if let any = any as? [Double] {
                    for s in any { anys.append(s) }
                } else if let any = any as? [Float] {
                    for s in any { anys.append(s) }
                } else if let any = any as? [Bool] {
                    for s in any { anys.append(s) }
                } else if let any = any as? [Any] {
                    for s in any { anys.append(s) }
                }
                
                json.append(JSON(anys))
            } else if JSON.isAnyDictionary(any) {
                var dicts = [String: Any]()
                if let dict = any as? [String: String] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                } else if let dict = any as? [String: Int] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                } else if let dict = any as? [String: Double] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                } else if let dict = any as? [String: Float] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                } else if let dict = any as? [String: Bool] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                } else if let dict = any as? [String: Any] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                }
                
                json.append(JSON(dicts))
            } else if let any = any as? JSON {
                json.append(any)
            } else {
                json.append(JSON(any))
            }
        }
        
        self = .array(json)
        
    }
    
    
    
    public init(_ value: [String: Int]) {
        self.init(value as [String: Any])
    }
    
    
    
    
    public init(_ value: [String: Any]) {
        var json = [String: JSON]()
        for (k, v) in value {
            if JSON.isAnyArray(v) {
                let any = v
                var anys = [Any]()
                if let any = any as? [String] {
                    for s in any { anys.append(s) }
                } else if let any = any as? [Int] {
                    for s in any { anys.append(s) }
                } else if let any = any as? [Double] {
                    for s in any { anys.append(s) }
                } else if let any = any as? [Float] {
                    for s in any { anys.append(s) }
                } else if let any = any as? [Bool] {
                    for s in any { anys.append(s) }
                } else if let any = any as? [Any] {
                    for s in any { anys.append(s) }
                }
                
                json.updateValue(JSON(anys), forKey: k)
            } else if JSON.isAnyDictionary(v) {
                let any = v
                var dicts = [String: Any]()
                if let dict = any as? [String: String] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                } else if let dict = any as? [String: Int] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                } else if let dict = any as? [String: Double] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                } else if let dict = any as? [String: Float] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                } else if let dict = any as? [String: Bool] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                } else if let dict = any as? [String: Any] {
                    for (k, v) in dict { dicts.updateValue(v, forKey: k) }
                }
                
                json.updateValue(JSON(dicts), forKey: k)
            } else if let v = v as? JSON {
                json.updateValue(v, forKey: k)
            } else {
                json.updateValue(JSON(v), forKey: k)
            }
        }
        self = .object(json)
    }
    
}






extension JSON {
    
    
    
    var anyDictionary: [String: Any]? {
        guard case let .object(object) = self else { return nil }
        
        var dict = [String: Any]()
        
        object.forEach { (k, v) in
            switch v {
                
            case .number:
                if v.double!.truncatingRemainder(dividingBy: 1) == 0 {
                    dict.updateValue(v.int, forKey: k)
                } else {
                    dict.updateValue(v.double, forKey: k)
                }
            case .bool:
                dict.updateValue(v.bool, forKey: k)
            case .array:
                if let arrayObject = v.anyArray {
                    dict.updateValue(arrayObject, forKey: k)
                }
            case .string:
                dict.updateValue(v.string, forKey: k)
            case .object:
                if let object = v.anyDictionary {
                    dict.updateValue(object, forKey: k)
                }
            default: break
                
            }
        }
        
        
        return dict
    }
    
    
    public var intDictionary: [String: Int]? {
        guard let dict = self.anyDictionary else { return nil }
        return anyToIntDictionary(dict)
    }
    
    public var doubleDictionary: [String: Double]? {
        guard let dict = self.anyDictionary else { return nil }
        return anyToDoubleDictionary(dict)
    }
    
    public var stringDictionary: [String: String]? {
        guard let dict = self.anyDictionary else { return nil }
        return anyToStringDictionary(dict)
    }
    
    public var boolDictionary: [String: Bool]? {
        guard let dict = self.anyDictionary else { return nil }
        return anyToBoolDictionary(dict)
    }
    
    
    
    
    
    var anyArray: [Any]? {
        guard case let .array(array) = self else { return nil }
        
        var ret = [Any]()
        
        for obj in array {
            switch obj {
            case .string:
                ret.append(obj.string!)
            case .number:
                ret.append(obj.double!)
            case .bool:
                ret.append(obj.bool!)
            case .array:
                if let arrayObject = obj.anyArray {
                    ret.append(arrayObject)
                }
            case .object:
                if let object = obj.anyDictionary {
                    ret.append(object)
                }
            default: break
            }
        }
        
        return ret
    }
    
    
    public var intArray: [Int]? {
        guard let array = self.anyArray else { return nil }
        return anyToIntArray(array)
    }
    
    
    public var stringArray: [String]? {
        guard let array = self.anyArray else { return nil }
        return anyToStringArray(array)
    }
    
    public var doubleArray: [Double]? {
        guard let array = self.anyArray else { return nil }
        return anyToDoubleArray(array)
    }
    
    public var boolArray: [Bool]? {
        guard let array = self.anyArray else { return nil }
        return anyToBoolArray(array)
    }
    
    
    
    static func isAnyArray(_ any: Any) -> Bool {
        if any is [String] {
            return true
        } else if any is [Int] {
            return true
        } else if any is [Double] {
            return true
        } else if any is [Float] {
            return true
        } else if any is [Bool] {
            return true
        } else if any is [Any] {
            return true
        }
        
        
        return false
    }
    
    
    static func isAnyDictionary(_ any: Any) -> Bool {
        if any is [String: String] {
            return true
        } else if any is [String: Int] {
            return true
        } else if any is [String: Double] {
            return true
        } else if any is [String: Float] {
            return true
        } else if any is [String: Bool] {
            return true
        } else if any is [String: Any] {
            return true
        }
        
        return false
    }
    
    
}


public extension Sequence where Iterator.Element: Any {
    
    public var stringView: [String] {
        return self.map { $0 as! String}
    }
    
    public var intView: [Int] {
        return self.map { $0 as! Int }
    }
    
    public var doubleView: [Double] {
        return self.map { $0 as! Double }
    }
    
    public var floatView: [Float] {
        return self.map { $0 as! Float }
    }
    
    public var boolView: [Bool] {
        return self.map { $0 as! Bool }
    }
}



public func isAnyArray(_ any: Any) -> Bool {
    if any is [String] {
        return true
    } else if any is [Int] {
        return true
    } else if any is [Double] {
        return true
    } else if any is [Float] {
        return true
    } else if any is [Bool] {
        return true
    } else if any is [Any] {
        return true
    }
    
    return false
}


public func isAnyDictionary(_ any: Any) -> Bool {
    if any is [String: String] {
        return true
    } else if any is [String: Int] {
        return true
    } else if any is [String: Double] {
        return true
    } else if any is [String: Float] {
        return true
    } else if any is [String: Bool] {
        return true
    } else if any is [String: Any] {
        return true
    }
    
    return false
}




public func forEachArray(_ any: Any, block: ((_: Any) -> ())) {
    if let any = any as? [String] {
        for s in any { block(s) }
    } else if let any = any as? [Int] {
        for s in any { block(s) }
    } else if let any = any as? [Double] {
        for s in any { block(s) }
    } else if let any = any as? [Float] {
        for s in any { block(s) }
    } else if let any = any as? [Bool] {
        for s in any { block(s) }
    } else if let any = any as? [Any] {
        for s in any { block(s) }
    }
}



public func forEachDictionary(_ any: Any, block: ((_ key: String, _: Any) -> ())) {
    if let dict = any as? [String: String] {
        for (k, v) in dict { block(k, v) }
    } else if let dict = any as? [String: Int] {
        for (k, v) in dict { block(k, v) }
    } else if let dict = any as? [String: Double] {
        for (k, v) in dict { block(k, v) }
    } else if let dict = any as? [String: Float] {
        for (k, v) in dict { block(k, v) }
    } else if let dict = any as? [String: Bool] {
        for (k, v) in dict { block(k, v) }
    }
}




//MARK:- Private



private func anyToIntArray(_ any: [Any]) -> [Int] {
    if any.count <= 0 { return [] }
    
    if any[0] is Double {
        return any.map { Int($0 as! Double) }
    }
    
    return any.map { $0 as! Int}
}

private func anyToStringArray(_ any: [Any]) -> [String] {
    return any.map { $0 as! String}
}

private func anyToDoubleArray(_ any: [Any]) -> [Double] {
    return any.map { $0 as! Double}
}

private func anyToBoolArray(_ any: [Any]) -> [Bool] {
    return any.map { $0 as! Bool}
}


private func anyToIntDictionary(_ any: [String: Any]) -> [String: Int] {
    var ret = [String: Int]()
    
    any.forEach { (k, v) in
        if v is Double {
            ret.updateValue(Int(v as! Double), forKey: k)
        } else {
            //zyh!!收到String crash
            ret.updateValue(v as! Int, forKey: k)
        }
    }
    
    return ret
}


private func anyToStringDictionary(_ any: [String: Any]) -> [String: String] {
    var ret = [String: String]()
    
    any.forEach { (k, v) in
        ret.updateValue(v as! String, forKey: k)
    }
    
    return ret
}


private func anyToDoubleDictionary(_ any: [String: Any]) -> [String: Double] {
    var ret = [String: Double]()
    
    any.forEach { (k, v) in
        ret.updateValue(v as! Double, forKey: k)
    }
    
    return ret
}


private func anyToBoolDictionary(_ any: [String: Any]) -> [String: Bool] {
    var ret = [String: Bool]()
    
    any.forEach { (k, v) in
        ret.updateValue(v as! Bool, forKey: k)
    }
    
    return ret
}



enum OCTData {
    case Int
    case String
    case Double
    case Bool
    case Null
}

protocol MYP {
    
}





extension String {
    var int: Int? {
        return Int(self)
    }
    
    
    var double: Double? {
        return Double(self)
    }
    
    
    var bool: Bool? {
        switch self {
        case "t", "ture":
            return true
        default:
            return false
        }
    }
}


















