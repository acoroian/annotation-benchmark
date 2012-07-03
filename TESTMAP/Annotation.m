//
//  Annotation.m
//  TESTMAP
//
//  Created by Adrian Coroian on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
@synthesize coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end
