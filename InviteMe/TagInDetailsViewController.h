//
//  TagInDetailsViewController.h
//  InviteMe
//
//  Created by Sifon on 19/12/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface TagInDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property(strong,nonatomic) PFObject *prog;
@property(strong,nonatomic) PFGeoPoint *pt;
- (IBAction)BackButton:(id)sender;

@end
