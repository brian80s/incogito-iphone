//
//  ClubZoneViewController.m
//
//  Copyright 2010 Chris Searle. All rights reserved.
//

#import "ClubZoneViewController.h"
#import "MapViewController.h"

@implementation ClubZoneViewController

- (void)viewWillAppear:(BOOL)animated {
	[FlurryAnalytics logEvent:@"Showing Clubzone"];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction)openMap:(id)sender {
	MapViewController *controller = [[MapViewController alloc] initWithNibName:@"Map" bundle:[NSBundle mainBundle]];
	
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

@end
