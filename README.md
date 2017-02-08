# AnnotationETA

[![CI Status](http://img.shields.io/travis/fortmarek/AnnotationETA.svg?style=flat)](https://travis-ci.org/fortmarek/AnnotationETA)
[![Version](https://img.shields.io/cocoapods/v/AnnotationETA.svg?style=flat)](http://cocoapods.org/pods/AnnotationETA)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/AnnotationETA.svg?style=flat)](http://cocoapods.org/pods/AnnotationETA)
[![Platform](https://img.shields.io/cocoapods/p/AnnotationETA.svg?style=flat)](http://cocoapods.org/pods/AnnotationETA)


## AnnotationETA

AnnotationETA will easily let you implement MapKit annotations with slick pins, custom colors and cool calloutView showing ETA out of the box!

![demo](https://github.com/fortmarek/AnnotationETA/blob/master/screens/annotationEta.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### CocoaPods

AnnotationETA is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AnnotationETA"
```

### Carthage

To integrate AnnotationETA into your Xcode project using Carthage, specify it in your Cartfile:

```ruby
github "fortmarek/AnnotationETA"
```

### Manually

Include all the files under AnnotationETA/Classes into your project.


## Set Up

In `func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation)` set your `MKAnnotationView` to `AnnotationEtaView`:
```swift 
let annotationEtaView = EtaAnnotationView(annotation: annotation, reuseIdentifier: "etaAnnotationIdentifier")
annotationView = annotationEtaView
```

To display ETA when the annotation is selected:

```swift
func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
guard let annotation = view.annotation else {return}
if annotation is MKUserLocation {return}

view.leftCalloutAccessoryView = DirectionButton(destinationCoordinate: annotation.coordinate, locationManager: self.locationManager, transportType: .automobile, destinationName: annotation.title ?? "")
}
```

## Detail Button

With detail button you can point to another view controller where you can display additional information about the annotation. Right under initializing etaAnnotationView write this:

```swift 
annotationEtaView.setDetailShowButton()
annotationEtaView.rightButton?.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
```

The action then should trigger function showing the detailViewController and also passing the information from the selected annotation, for example like this:

```swift
func detailButtonTapped() {
guard
mapView.selectedAnnotations.count == 1,
let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailVC") as? DetailViewController
else {return}

detailViewController.annotation = mapView.selectedAnnotations[0]

self.present(detailViewController, animated: true, completion: nil)
}
```

## Customization

### Pin Color

Pin color not only sets the color of the pin, but left and rightCalloutAccessoryView as well

```swift 
annotationEtaView.pinColor = UIColor.blue
```

## More

For more detailed implementation take a look at the example or contact me.

## Author

fortmarek, marekfort@me.com

## License

AnnotationETA is available under the MIT license. See the LICENSE file for more info.


