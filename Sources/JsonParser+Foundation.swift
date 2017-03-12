////
////  JsonSerializer+Foundation.swift
////  JsonSerializer
////
////  Created by Fuji Goro on 2014/09/15.
////  Copyright (c) 2014 Fuji Goro. All rights reserved.
////
//
//import Foundation
//
//public extension Json {
//    var anyValue: Any {
//        switch self {
//        case .object(let ob):
//            var mapped: [String : Any] = [:]
//            ob.forEach { key, val in
//                mapped[key] = val.anyValue
//            }
//            return mapped
//        case .array(let array):
//            return array.map { $0.anyValue }
//        case .bool(let bool):
//            return bool
//        case .number(let number):
//            return number
//        case .string(let string):
//            return string
//        case .null:
//            return NSNull()
//        }
//    }
//    
//    var foundationDictionary: [String : Any]? {
//        return anyValue as? [String : Any]
//    }
//    
//    var foundationArray: [Any]? {
//        return anyValue as? [Any]
//    }
//}
//
//extension Json {
//    public static func from(_ any: Any) -> Json {
//        switch any {
//            // If we're coming from foundation, it will be an `NSNumber`.
//            //This represents double, integer, and boolean.
//        case let number as Double:
//            return .number(number)
//        case let string as String:
//            return .string(string)
//        case let object as [String : Any]:
//            return from(object)
//        case let array as [Any]:
//            return .array(array.map(from))
//        case _ as NSNull:
//            return .null
//        default:
//            fatalError("Unsupported foundation type")
//        }
//        return .null
//    }
//    
//    public static func from(_ any: [String : Any]) -> Json {
//        var mutable: [String : Json] = [:]
//        any.forEach { key, val in
//            mutable[key] = .from(val)
//        }
//        return .from(mutable)
//    }
//}
//
////extension Json {
////    public static func deserialize(_ data: Data) throws -> Json {
////        let startPointer = UnsafePointer<UInt8>((data as NSData).bytes)
////        let bufferPointer = UnsafeBufferPointer(start: startPointer, count: data.count)
////        return try deserialize(bufferPointer)
////    }
////}
