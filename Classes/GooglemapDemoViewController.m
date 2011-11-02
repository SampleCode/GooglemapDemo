//
//  GooglemapDemoViewController.m
//  GooglemapDemo
//
//  Created by Eric Lin on 2010/7/22.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "GooglemapDemoViewController.h"
#import "MyAnnotation.h"
#import "DetailView.h"

@implementation GooglemapDemoViewController

@synthesize detailView;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void) centerPosition {
		// 若現在的地點在地圖上已經看不到，則將地圖的中心點設定為目前位置 
	if( mapView.userLocation.coordinate.latitude>0 && mapView.userLocation.coordinate.longitude>0 && ![mapView isUserLocationVisible] ) {
		[mapView setCenterCoordinate:mapView.userLocation.coordinate animated:YES];
	}
}

- (IBAction)centerToCurrentLocation:(id)sender {
	[self centerPosition];
}

////////////////////////////
// MKMapViewDelegate events
////////////////////////////

// 開始載入地圖時顯示等待的動畫
- (void)mapViewWillStartLoadingMap:(MKMapView *) theMapView {
	if( busy==nil ){
		busy = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		busy.frame = CGRectMake(120, 180, 80, 80);
		[self.view addSubview:busy];
	}
	busy.hidesWhenStopped = YES;
	[busy startAnimating];
}
// 完全載入地圖後停止等待動畫
- (void)mapViewDidFinishLoadingMap:(MKMapView *) theMapView {
	[busy stopAnimating];
}
// 使用者位置更新後，讓現在位置置中
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
	if( !setup ){
		setup = YES;
	   [self updateRegionForLocation:userLocation.location keepSpan:NO];
	} else {
		[self updateRegionForLocation:userLocation.location keepSpan:YES];
	}
    
	// 移動位置時，讓現在位置置中
	[self centerPosition];
}
////////////////////////////

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	locManager = [[CLLocationManager alloc] init];
	[locManager startUpdatingLocation];
	
	mapView.delegate = self;
    
}

// 更新顯示的視野
- (void) updateRegionForLocation:(CLLocation *) newLocation keepSpan:(BOOL) keepSpan{
    //指定中心點
    CLLocationCoordinate2D theCenter;
    theCenter.latitude = 25.054606;
    theCenter.longitude = 121.548437;

	MKCoordinateRegion theRegion;
    //移動地圖中心
    theRegion.center=theCenter;
//	theRegion.center = newLocation.coordinate;
	
	if( !keepSpan ){
		MKCoordinateSpan theSpan;
		theSpan.latitudeDelta = 0.02;
		theSpan.longitudeDelta = 0.02;
		theRegion.span = theSpan;
	}else {
		theRegion.span = mapView.region.span;
	}
	[mapView setRegion:theRegion animated:YES];
    [self addPOI];
}

-(MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString* MyAnnotationIdentifier = @"myAnnotation";
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [theMapView dequeueReusableAnnotationViewWithIdentifier:MyAnnotationIdentifier];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:MyAnnotationIdentifier];
        pin.canShowCallout = YES;
        
        UIButton* detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [detailButton addTarget:self
                    action:@selector(showDetails:)
                    forControlEvents:UIControlEventTouchUpInside];
        
        [pin setImage:[self reSizeImageInPath:@"Location.png" withWidth:35 andHeight:40]];
        pin.rightCalloutAccessoryView = detailButton;
        
        
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
}


-(void)addPOI {
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    // 建立一個CLLocationCoordinate2D
    CLLocationCoordinate2D coord;
    coord.latitude = 25.054606;
    coord.longitude = 121.548437;
    
    // 準備一個annotation   
    MyAnnotation *anno = [[[MyAnnotation alloc] initWithCoordinate:coord title:@"敦化店" subtitle:@"台北市敦化北路150號"] autorelease];
    
    // 把annotation加進MapView裡
    [annotations addObject:anno];
    
    coord.latitude = 25.045792;
    coord.longitude = 121.546383;
    anno = [[[MyAnnotation alloc] initWithCoordinate:coord title:@"忠孝店" subtitle:@"台北市忠孝東路四段49巷2號"] autorelease];
    
    [annotations addObject:anno];
      
    [mapView addAnnotations:annotations];
    
    [anno release];
    [annotations release];
    
}

- (void)showDetails:(id)sender
{
        // the detail view does not want a toolbar so hide it

    
    [self.navigationController pushViewController:self.detailView animated:YES];
}

- (UIImage *)reSizeImageInPath:(NSString *)path withWidth:(CGFloat)width andHeight:(CGFloat)height {
    UIImage *image = [UIImage imageNamed:path];
    CGSize newSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[locManager release];
	[busy release];
}

@end
