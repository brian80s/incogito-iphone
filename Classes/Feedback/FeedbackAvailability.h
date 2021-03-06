//
//  FeedbackAvailability.h
//
//  Copyright 2011 Chris Searle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface FeedbackAvailability : NSObject

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSDictionary *dict;
@property (nonatomic, retain) MBProgressHUD *HUD;


- (FeedbackAvailability *) initWithUrl:(NSURL *)downloadUrl;

- (void)downloadData;
- (BOOL)isFeedbackAvailableForSession:(NSString *)sessionId;
- (NSURL *)feedbackUrlForSession:(NSString *)sessionId;
- (void)populateDict;

@end
