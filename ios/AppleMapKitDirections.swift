import MapKit

@objc(AppleMapKitDirections)
class AppleMapKitDirections: NSObject {
    @objc(getRouteDetail:toDestination:byTransitType:withResolver:withRejecter:)
    func getRouteDetail(origin: Dictionary<String, Double>,
                        destination: Dictionary<String, Double>,
                        transitType: NSString,
                        resolve:@escaping RCTPromiseResolveBlock,
                        reject:@escaping RCTPromiseRejectBlock) -> Void {
        
        let request = MKDirections.Request();
        
        request.source = MKMapItem(placemark:
                                    MKPlacemark(coordinate:
                                                    CLLocationCoordinate2D(
                                                        latitude: origin["latitude"] ?? 0.0,
                                                        longitude: origin["longitude"] ?? 0.0),
                                                addressDictionary: nil))
        
        
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(
                                                                latitude: destination["latitude"] ?? 0.0,
                                                                longitude: destination["longitude"] ?? 0.0),
                                                               addressDictionary: nil))
        
        request.requestsAlternateRoutes = true
        request.transportType = .any
        
        switch transitType {
        case "car":
            request.transportType = .automobile;
            break;
        case "walk":
            request.transportType = .walking;
        case "transit":
            request.transportType = .transit;
            break;
        default:
            request.transportType = .any;
        }
        
        let directions = MKDirections(request: request)
        directions.calculateETA {(response, error) in
            guard let response = response else {
                if let error = error {
                    reject("500", error.localizedDescription, error)
                }
                return
            }
            
            var resp: Dictionary = [:] as [String : Any];
            
            resp["distance"] = response.distance as Double;
            resp["expectedTravelTime"] = response.expectedTravelTime as Double;
            resp["name"] = response.transportType;
            print(resp)
            resolve(resp)
        }
//        directions.calculate(completionHandler: {(response, error) in
//            guard let response = response else {
//                if let error = error {
//                    reject("500", error.localizedDescription, error)
//                }
//                return
//            }
//
//            var resp: Dictionary = [:] as [String : Any];
//
//            if response.routes.count > 0 {
//                let route = response.routes[0]
//                resp["distance"] = route.distance as Double;
//                resp["expectedTravelTime"] = route.expectedTravelTime as Double;
//                resp["name"] = route.name;
//                resp["advisoryNotices"] = route.advisoryNotices;
//                print(resp)
//                resolve(resp)
//            }
//        })
    }
}
