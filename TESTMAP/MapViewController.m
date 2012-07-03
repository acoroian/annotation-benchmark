//
//  MapViewController.m
//  TESTMAP
//
//  Created by Adrian Coroian on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property NSTimeInterval benchmark;
@end

@implementation MapViewController
@synthesize mapView;
@synthesize benchmark;

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
    NSMutableArray* annotations = [[NSMutableArray alloc] init ];
}

- (void)addAnnotationsIndividually {
    
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
