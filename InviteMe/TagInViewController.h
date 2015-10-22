//
//  TagInViewController.h
//  InviteMe
//
//  Created by Sifon on 19/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface TagInViewController : UIViewController <CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableJson;
@property (strong, nonatomic) NSArray *googlePlacesArrayFromAFNetworking;
@property (strong, nonatomic) NSArray *finishedGooglePlacesArray;


@property(strong,nonatomic) PFGeoPoint  *cur;

@property(strong,nonatomic) PFGeoPoint  *currentlocationUser;
- (IBAction)CancelButton:(id)sender;





@end
