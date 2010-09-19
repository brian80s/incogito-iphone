//
//  JavaZone2011Controller.m
//
//  Copyright 2010 Chris Searle. All rights reserved.
//

#import "JavaZone2011Controller.h"
#import "FlurryAPI.h"

@implementation JavaZone2011Controller

- (void)viewWillAppear:(BOOL)animated {
	[FlurryAPI logEvent:@"Showing 2011"];
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


@end