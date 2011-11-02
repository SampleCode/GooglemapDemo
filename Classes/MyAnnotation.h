//
//  MyAnnotation.h
//  GooglemapDemo
//
//  Created by Miriam on 2011/10/5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
}

-(id) initWithCoordinate:(CLLocationCoordinate2D)theCoordinate title:(NSString *)theTitle subtitle:(NSString *)theSubtitle;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *subtitle;
@property(nonatomic) CLLocationCoordinate2D coordinate;

@end
