//
//  GooglemapDemoViewController.h
//  GooglemapDemo
//
//  Created by Eric Lin on 2010/7/22.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class DetailView;

@interface GooglemapDemoViewController : UIViewController <MKMapViewDelegate>{
	CLLocationManager *locManager;	
	IBOutlet MKMapView *mapView;
	UIActivityIndicatorView *busy;
	BOOL setup;
    DetailView *detailView;
}

@property (nonatomic, retain) IBOutlet DetailView *detailView;

- (IBAction)centerToCurrentLocation:(id)sender;
- (void) updateRegionForLocation:(CLLocation *) newLocation keepSpan:(BOOL) keepSpan;
- (void) addPOI;
- (UIImage *)reSizeImageInPath:(NSString *)path withWidth:(CGFloat)width andHeight:(CGFloat)height;
@end

