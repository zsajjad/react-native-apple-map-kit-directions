import MapKit

@objc(AppleMapKitDirections)
class AppleMapKitDirections: NSObject {
    @objc(getRouteDetail:toDestination:byTransitType:withResolver:withRejecter:)
    func getRouteDetail(origin: NSDictionary,
                        destination: NSDictionary,
                        transitType: NSString,
                        resolve:@escaping RCTPromiseResolveBlock,
                        reject:@escaping RCTPromiseRejectBlock) -> Void {
        
        NSLog("%@", origin);
        NSLog("%@", destination);
        let request = MKDirections.Request();
        
        request.source = MKMapItem(placemark:
                                    MKPlacemark(coordinate:
                                                    CLLocationCoordinate2D(latitude: 37.334900, longitude: -122.009020), addressDictionary: nil))
        
        
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.327943, longitude: -121.938195), addressDictionary: nil))
        
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
        
        directions.calculate(completionHandler: {(response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            var resp: Dictionary = [:] as [String : Any];
            
            if response.routes.count > 0 {
                let route = response.routes[0]
                resp["distance"] = route.distance as Double;
                resp["expectedTravelTime"] = route.expectedTravelTime as Double;
                resp["name"] = route.name;
                resp["advisoryNotices"] = route.advisoryNotices;
                print(resp)
                resolve(resp)
            }
        })
    }
}
