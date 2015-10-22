//
//  ProgramDetailsViewController.h
//  InviteMe
//
//  Created by Sifon on 02/12/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>


@interface ProgramDetailsViewController : UIViewController<MKMapViewDelegate>


@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property(strong,nonatomic) PFObject *prog;
@property(strong,nonatomic) PFGeoPoint *pt;

@property (strong, nonatomic) IBOutlet UILabel *txtTitle;

@property (strong, nonatomic) IBOutlet UILabel *txtDate;

@property (strong, nonatomic) IBOutlet UILabel *txtdesc;

- (IBAction)BackButton:(id)sender;

- (IBAction)LikeProgramButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *LikeButton;

@property (strong, nonatomic)  NSArray *ListLike;

@end
