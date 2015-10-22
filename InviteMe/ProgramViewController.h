//
//  ProgramViewController.h
//  InviteMe
//
//  Created by Sifon on 14/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
@import CoreLocation;
#import <CoreLocation/CoreLocation.h>
#import "FlatDatePicker.h"


@interface ProgramViewController : UIViewController <MKMapViewDelegate,FlatDatePickerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) FlatDatePicker *flatDatePicker;
@property (nonatomic, strong) FlatDatePicker *flatTimePicker;

@property (strong, nonatomic) IBOutlet UITextField *txttitle;

@property (strong, nonatomic) IBOutlet UITextView *txtDescription;

- (IBAction)Validate:(id)sender;

- (IBAction)CancelButton:(id)sender;


@end
