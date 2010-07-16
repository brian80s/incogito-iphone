//
//  SectionSessionHandler.m
//  incogito
//
//  Created by Chris Searle on 15.07.10.
//  Copyright 2010 Chris Searle. All rights reserved.
//

#import "SectionSessionHandler.h"

#import "Section.h"
#import "JZSession.h"

@implementation SectionSessionHandler

@synthesize managedObjectContext;

- (NSArray *)getSections {
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Section" inManagedObjectContext:managedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	[request setEntity:entityDescription];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
	
	NSError *error;

	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	[request release];

	NSArray *sections = [NSArray arrayWithArray:mutableFetchResults];
	[mutableFetchResults release];
	
	return sections;
}

- (NSArray *)getSessionsForSection:(Section *)section {
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"JZSession" inManagedObjectContext:managedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	[request setEntity:entityDescription];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"room" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @"(active == %@) AND (startDate >= %@) AND (endDate <= %@)", [NSNumber numberWithBool:true], [section startDate], [section endDate]];
	
	[request setPredicate:predicate];
	
	NSError *error;
	
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	
	NSArray *sessions = [NSArray arrayWithArray:mutableFetchResults];
	
	[mutableFetchResults release];
	[request release];
	
	return sessions;
}

- (NSArray *)getFavouriteSessionsForSection:(Section *)section {
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"JZSession" inManagedObjectContext:managedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	[request setEntity:entityDescription];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"room" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @"(userSession.@count > 0) && (active == %@) AND (startDate >= %@) AND (endDate <= %@)", [NSNumber numberWithBool:true], [section startDate], [section endDate]];

	[request setPredicate:predicate];
	
	NSError *error;
	
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	
	NSArray *sessions = [NSArray arrayWithArray:mutableFetchResults];
	
	[mutableFetchResults release];
	[request release];
	
	return sessions;
}

- (NSDictionary *)getSessions {
	NSArray *sections = [self getSections];
	
	NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:[sections count]];
	NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity:[sections count]];
	
	for (Section *section in sections) {
		[keys addObject:[section title]];
		[objects addObject:[self getSessionsForSection:section]];
	}
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithArray:objects] forKeys:keys];
	[objects release];
	[keys release];
	
	return dictionary;
}

- (Section *)getSectionForDate:(NSDate *)date {
	NSEntityDescription *entityDescription = [NSEntityDescription
											  entityForName:@"Section" inManagedObjectContext:managedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	
	[request setEntity:entityDescription];

	NSPredicate *predicate = [NSPredicate predicateWithFormat:
							  @"(startDate <= %@) AND (endDate >= %@)", date, date];
	
	[request setPredicate:predicate];
	
	NSError *error;
	
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	
	NSArray *sections = [NSArray arrayWithArray:mutableFetchResults];
	
	[mutableFetchResults release];
	[request release];

	if (nil == sections || [sections count] == 0) {
		return nil;
	}
	
	return [sections objectAtIndex:0];
}

- (NSDictionary *)getFavouriteSessions {
	NSArray *sections = [self getSections];
	
	NSMutableArray *keys = [[NSMutableArray alloc] init];
	
	NSMutableArray *objects = [[NSMutableArray alloc] init];
	
	for (Section *section in sections) {
		NSArray *sessions = [self getFavouriteSessionsForSection:section];
		
		if (nil != sessions && [sessions count] > 0) {
			[keys addObject:[section title]];
			[objects addObject:sessions];
		}
	}
	
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithArray:objects] forKeys:keys];
	[objects release];
	[keys release];
	
	return dictionary;	
}

@end