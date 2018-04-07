//
//  Configrations.swift
//  APIManager
//
//  Created by Amjad Tubasi-Ureed on 12/3/17.
//  Copyright © 2017 Amjad Tubasi-Ureed. All rights reserved.
//

import Foundation


public let defaultTimeout : TimeInterval = 120
public let kKeySignature  = "signature"
let signatureHashKey = "368e0eb94120ac54cf9bf3efbfccbb49"

public enum HttpMethod : String {
    case GET = "GET"
    case POST =  "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public enum LogLevel {
    case verbose
    case none
}

public enum APIVersion : String {
    case version1 = "v1"
    case version2 = "v2"
    
    var useSingutre : Bool {
        switch self {
        case .version2:
            return true
        default:
            return false
        }
    }
}


public enum HTTPStatusCodes: Int {
    
    public static func from(int:Int)-> HTTPStatusCodes {
        return HTTPStatusCodes(rawValue: int) ?? .InternalServerError
    }
    
    // 100 Informational
    case Continue = 100
    case SwitchingProtocols
    case Processing
    // 200 Success
    case OK = 200
    case Created
    case Accepted
    case NonAuthoritativeInformation
    case NoContent
    case ResetContent
    case PartialContent
    case MultiStatus
    case AlreadyReported
    case IMUsed = 226
    // 300 Redirection
    case MultipleChoices = 300
    case MovedPermanently
    case Found
    case SeeOther
    case NotModified
    case UseProxy
    case SwitchProxy
    case TemporaryRedirect
    case PermanentRedirect
    // 400 Client Error
    case BadRequest = 400
    case Unauthorized
    case PaymentRequired
    case Forbidden
    case NotFound
    case MethodNotAllowed
    case NotAcceptable
    case ProxyAuthenticationRequired
    case RequestTimeout
    case Conflict
    case Gone
    case LengthRequired
    case PreconditionFailed
    case PayloadTooLarge
    case URITooLong
    case UnsupportedMediaType
    case RangeNotSatisfiable
    case ExpectationFailed
    case ImATeapot
    case MisdirectedRequest = 421
    case UnprocessableEntity
    case Locked
    case FailedDependency
    case UpgradeRequired = 426
    case PreconditionRequired = 428
    case TooManyRequests
    case RequestHeaderFieldsTooLarge = 431
    case UnavailableForLegalReasons = 451
    // 500 Server Error
    case InternalServerError = 500
    case NotImplemented
    case BadGateway
    case ServiceUnavailable
    case GatewayTimeout
    case HTTPVersionNotSupported
    case VariantAlsoNegotiates
    case InsufficientStorage
    case LoopDetected
    case NotExtended = 510
    case NetworkAuthenticationRequired
}
