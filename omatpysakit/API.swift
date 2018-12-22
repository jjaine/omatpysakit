//  This file was automatically generated and should not be edited.

import Apollo

public enum RealtimeState: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// The trip information comes from the GTFS feed, i.e. no real-time update has been applied.
  case scheduled
  /// The trip information has been updated, but the trip pattern stayed the same as the trip pattern of the scheduled trip.
  case updated
  /// The trip has been canceled by a real-time update.
  case canceled
  /// The trip has been added using a real-time update, i.e. the trip was not present in the GTFS feed.
  case added
  /// The trip information has been updated and resulted in a different trip pattern compared to the trip pattern of the scheduled trip.
  case modified
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "SCHEDULED": self = .scheduled
      case "UPDATED": self = .updated
      case "CANCELED": self = .canceled
      case "ADDED": self = .added
      case "MODIFIED": self = .modified
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .scheduled: return "SCHEDULED"
      case .updated: return "UPDATED"
      case .canceled: return "CANCELED"
      case .added: return "ADDED"
      case .modified: return "MODIFIED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: RealtimeState, rhs: RealtimeState) -> Bool {
    switch (lhs, rhs) {
      case (.scheduled, .scheduled): return true
      case (.updated, .updated): return true
      case (.canceled, .canceled): return true
      case (.added, .added): return true
      case (.modified, .modified): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public final class StopInfoQuery: GraphQLQuery {
  public let operationDefinition =
    "query stopInfo($id: String!) {\n  stop(id: $id) {\n    __typename\n    name\n    stoptimesWithoutPatterns {\n      __typename\n      scheduledArrival\n      realtimeArrival\n      arrivalDelay\n      scheduledDeparture\n      realtimeDeparture\n      departureDelay\n      realtime\n      realtimeState\n      serviceDay\n      trip {\n        __typename\n        tripHeadsign\n        routeShortName\n      }\n    }\n  }\n}"

  public var id: String

  public init(id: String) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["QueryType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("stop", arguments: ["id": GraphQLVariable("id")], type: .object(Stop.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(stop: Stop? = nil) {
      self.init(unsafeResultMap: ["__typename": "QueryType", "stop": stop.flatMap { (value: Stop) -> ResultMap in value.resultMap }])
    }

    /// Get a single stop based on its ID, i.e. value of field `gtfsId` (ID format is `FeedId:StopId`)
    public var stop: Stop? {
      get {
        return (resultMap["stop"] as? ResultMap).flatMap { Stop(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "stop")
      }
    }

    public struct Stop: GraphQLSelectionSet {
      public static let possibleTypes = ["Stop"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("stoptimesWithoutPatterns", type: .list(.object(StoptimesWithoutPattern.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, stoptimesWithoutPatterns: [StoptimesWithoutPattern?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Stop", "name": name, "stoptimesWithoutPatterns": stoptimesWithoutPatterns.flatMap { (value: [StoptimesWithoutPattern?]) -> [ResultMap?] in value.map { (value: StoptimesWithoutPattern?) -> ResultMap? in value.flatMap { (value: StoptimesWithoutPattern) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Name of the stop, e.g. Pasilan asema
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// Returns list of stoptimes (arrivals and departures) at this stop
      public var stoptimesWithoutPatterns: [StoptimesWithoutPattern?]? {
        get {
          return (resultMap["stoptimesWithoutPatterns"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [StoptimesWithoutPattern?] in value.map { (value: ResultMap?) -> StoptimesWithoutPattern? in value.flatMap { (value: ResultMap) -> StoptimesWithoutPattern in StoptimesWithoutPattern(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [StoptimesWithoutPattern?]) -> [ResultMap?] in value.map { (value: StoptimesWithoutPattern?) -> ResultMap? in value.flatMap { (value: StoptimesWithoutPattern) -> ResultMap in value.resultMap } } }, forKey: "stoptimesWithoutPatterns")
        }
      }

      public struct StoptimesWithoutPattern: GraphQLSelectionSet {
        public static let possibleTypes = ["Stoptime"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("scheduledArrival", type: .scalar(Int.self)),
          GraphQLField("realtimeArrival", type: .scalar(Int.self)),
          GraphQLField("arrivalDelay", type: .scalar(Int.self)),
          GraphQLField("scheduledDeparture", type: .scalar(Int.self)),
          GraphQLField("realtimeDeparture", type: .scalar(Int.self)),
          GraphQLField("departureDelay", type: .scalar(Int.self)),
          GraphQLField("realtime", type: .scalar(Bool.self)),
          GraphQLField("realtimeState", type: .scalar(RealtimeState.self)),
          GraphQLField("serviceDay", type: .scalar(Long.self)),
          GraphQLField("trip", type: .object(Trip.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(scheduledArrival: Int? = nil, realtimeArrival: Int? = nil, arrivalDelay: Int? = nil, scheduledDeparture: Int? = nil, realtimeDeparture: Int? = nil, departureDelay: Int? = nil, realtime: Bool? = nil, realtimeState: RealtimeState? = nil, serviceDay: Long? = nil, trip: Trip? = nil) {
          self.init(unsafeResultMap: ["__typename": "Stoptime", "scheduledArrival": scheduledArrival, "realtimeArrival": realtimeArrival, "arrivalDelay": arrivalDelay, "scheduledDeparture": scheduledDeparture, "realtimeDeparture": realtimeDeparture, "departureDelay": departureDelay, "realtime": realtime, "realtimeState": realtimeState, "serviceDay": serviceDay, "trip": trip.flatMap { (value: Trip) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Scheduled arrival time. Format: seconds since midnight of the departure date
        public var scheduledArrival: Int? {
          get {
            return resultMap["scheduledArrival"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "scheduledArrival")
          }
        }

        /// Realtime prediction of arrival time. Format: seconds since midnight of the departure date
        public var realtimeArrival: Int? {
          get {
            return resultMap["realtimeArrival"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "realtimeArrival")
          }
        }

        /// The offset from the scheduled arrival time in seconds. Negative values indicate that the trip is running ahead of schedule.
        public var arrivalDelay: Int? {
          get {
            return resultMap["arrivalDelay"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "arrivalDelay")
          }
        }

        /// Scheduled departure time. Format: seconds since midnight of the departure date
        public var scheduledDeparture: Int? {
          get {
            return resultMap["scheduledDeparture"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "scheduledDeparture")
          }
        }

        /// Realtime prediction of departure time. Format: seconds since midnight of the departure date
        public var realtimeDeparture: Int? {
          get {
            return resultMap["realtimeDeparture"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "realtimeDeparture")
          }
        }

        /// The offset from the scheduled departure time in seconds. Negative values indicate that the trip is running ahead of schedule
        public var departureDelay: Int? {
          get {
            return resultMap["departureDelay"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "departureDelay")
          }
        }

        /// true, if this stoptime has real-time data available
        public var realtime: Bool? {
          get {
            return resultMap["realtime"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "realtime")
          }
        }

        /// State of real-time data
        public var realtimeState: RealtimeState? {
          get {
            return resultMap["realtimeState"] as? RealtimeState
          }
          set {
            resultMap.updateValue(newValue, forKey: "realtimeState")
          }
        }

        /// Departure date of the trip. Format: Unix timestamp (local time) in seconds.
        public var serviceDay: Long? {
          get {
            return resultMap["serviceDay"] as? Long
          }
          set {
            resultMap.updateValue(newValue, forKey: "serviceDay")
          }
        }

        /// Trip which this stoptime is for
        public var trip: Trip? {
          get {
            return (resultMap["trip"] as? ResultMap).flatMap { Trip(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "trip")
          }
        }

        public struct Trip: GraphQLSelectionSet {
          public static let possibleTypes = ["Trip"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("tripHeadsign", type: .scalar(String.self)),
            GraphQLField("routeShortName", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(tripHeadsign: String? = nil, routeShortName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Trip", "tripHeadsign": tripHeadsign, "routeShortName": routeShortName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Headsign of the vehicle when running on this trip
          public var tripHeadsign: String? {
            get {
              return resultMap["tripHeadsign"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "tripHeadsign")
            }
          }

          /// Short name of the route this trip is running. See field `shortName` of Route.
          public var routeShortName: String? {
            get {
              return resultMap["routeShortName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "routeShortName")
            }
          }
        }
      }
    }
  }
}