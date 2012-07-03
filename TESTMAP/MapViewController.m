//
//  MapViewController.m
//  TESTMAP
//
//  Created by Adrian Coroian on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "Annotation.h"
#import <CoreLocation/CoreLocation.h>

#define ANNOTATIONS_TO_ADD 6000

@interface MapViewController ()
@property NSTimeInterval benchmark;
@property (strong) NSMutableArray* annotations;
@end

@implementation MapViewController
@synthesize mapView;
@synthesize benchmark;
@synthesize annotations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set region to africa
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(4.302591, 24.433594);
    MKCoordinateSpan span = MKCoordinateSpanMake(74.723901, 56.250000);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region];
    // Do any additional setup after loading the view from its nib.
    benchmark = [[NSDate date] timeIntervalSince1970];
    [self addAnnotationsAtOnce];
    benchmark = [[NSDate date] timeIntervalSince1970] - benchmark;
    NSLog(@"RESULTS AT ONCE: %f", benchmark);
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    benchmark = [[NSDate date] timeIntervalSince1970];
    [self addAnnotationsIndividually];
    benchmark = [[NSDate date] timeIntervalSince1970] - benchmark;
    NSLog(@"RESULTS INDIVIDUALLY: %f", benchmark);
}

- (void)addAnnotationsAtOnce {
    self.annotations = [[NSMutableArray alloc] init ];
    for(int i = 0; i < ANNOTATIONS_TO_ADD; i++) {
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, i%50);
        Annotation* annotation = [[Annotation alloc] initWithCoordinate:coord];
        [self.annotations addObject:annotation];
    }
    [self.mapView addAnnotations:annotations];
}


- (void)addAnnotationsIndividually {
    for(int i = 0; i < ANNOTATIONS_TO_ADD; i++) {
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, i%50);
        Annotation* annotation = [[Annotation alloc] initWithCoordinate:coord];
        [self.mapView addAnnotation:annotation];
    }
}

-(void) mapView:(MKMapView *)mapsView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"%f %f %f %f", mapsView.region.center.latitude,mapsView.region.center.longitude,
          mapsView.region.span.latitudeDelta, mapsView.region.span.longitudeDelta);
}

- (MKAnnotationView*)mapView:(MKMapView*)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;     // Use default system user-location view.
    }
    else
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView* pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"stashMarkerID"];
        if(!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                       reuseIdentifier:@"stashMarkerID"];
            pinView.pinColor = MKPinAnnotationColorPurple;
            pinView.animatesDrop = NO;
            pinView.canShowCallout = NO;
        }
        else
        {
            pinView.annotation = annotation;
        }
        
        return pinView;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
