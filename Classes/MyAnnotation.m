//
//  MyAnnotation.m
//  GooglemapDemo
//
//  Created by Miriam on 2011/10/5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"


@implementation MyAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

-(id) initWithCoordinate:(CLLocationCoordinate2D)theCoordinate title:(NSString *)theTitle subtitle:(NSString *)theSubTitle {
    self = [super init];
    [self setCoordinate:theCoordinate];
    self.title = theTitle;
    self.subtitle = theSubTitle;
    return self;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}

-(void) dealloc
{
	self.title = nil;
	self.subtitle = nil;
	[super dealloc];	
}

@end
