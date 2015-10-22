//
//  ProgramViewController.m
//  InviteMe
//
//  Created by Sifon on 14/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "ProgramViewController.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SCLAlertView.h"
#import <Parse/Parse.h>
#import "Reachability.h"

// Constants
#import "StringConstants.h"

// Messages
#import "TWMessageBarManager.h"

// Numerics
CGFloat const kTWMesssageBarDemoControllerButtonPadding = 10.0f;
CGFloat const kTWMesssageBarDemoControllerButtonHeight = 50.0f;

// Colors
static UIColor *kTWMesssageBarDemoControllerButtonColor = nil;



#define METERS_PER_MILE 1609.344

@interface ProgramViewController ()

@property(strong,nonatomic) NSString *tit;
@property(strong,nonatomic) NSString *desc;
@property(strong,nonatomic) NSString *dat;
@property(strong,nonatomic) PFGeoPoint *point;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property(strong,nonatomic) NSDate *programDate;
@property(strong,nonatomic) NSDate *programtime;
@property(strong,nonatomic) NSDate *programfinalDate;



@property (nonatomic, assign) int mappressed;




@end
CLLocation *loc;

@implementation ProgramViewController
{
    Reachability *internetReachableFoo;
}



- (void)viewDidLoad {
  
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //user needs to press for 2 seconds
    [self.mapView addGestureRecognizer:lpgr];
    
 
    [super viewDidLoad];
 
    _mappressed =0;
    
    
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];

    //self.searchButton.hidden = YES;
    
//    
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate=self;
//    
//    
[ self zoomToUser];
//    
//   self.mapView.showsUserLocation = YES;
    
    
    
}
//
//- (IBAction)setMapType:(UISegmentedControl *)sender {
//    switch (sender.selectedSegmentIndex) {
//        case 0:
//            self.mapView.mapType = MKMapTypeStandard;
//            break;
//        case 1:
//            self.mapView.mapType = MKMapTypeSatellite;
//            break;
//        case 2:
//            self.mapView.mapType = MKMapTypeHybrid;
//            break;
//        default:
//            break;
//    }
//}
//
- (void)zoomToUser{
    
    float spanX = 0.065;
    float spanY = 0.065;
    MKCoordinateRegion region;
    //region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    //region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    //self.searchButton.hidden = YES;
    [self.mapView setRegion:region animated:YES];
}

//

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
   
    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated
{
 
}


//
//-(void) getCurrentLocation
//{
//    
//    NSLog(@"------------------");
//    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//        [self.locationManager requestWhenInUseAuthorization];
//        
//    }
//    
//    
//    
//    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
//             [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authorization Request" message:@"To use this feature you need to turn on Location Service." delegate:self cancelButtonTitle:@"Nope" otherButtonTitles:@"Go to Settings", nil];
//        [alert show];
//    }
//    else {
//        
//        [self.locationManager startUpdatingLocation];
//    }
//}
//
//
//# pragma mark - CLLocationManagerDelegate Methods
//
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    
//    
//    // GETTING LOcation
//    [self.locationManager stopUpdatingLocation];
//    loc = locations.lastObject;
//    
//    
//    
//    NSLog(@"-------------querry Google----------");
//    [self.locationManager stopUpdatingLocation];
//    NSLog(@"-------------------------------");
//    
//    NSLog(@"%@", [locations lastObject]);
//    loc = locations.lastObject;
//    CLLocationCoordinate2D zoomLocation;
//    zoomLocation.latitude = loc.coordinate.latitude;
//    zoomLocation.longitude= loc.coordinate.longitude;
//    NSLog(@"%f",zoomLocation.latitude);
//    NSLog(@"%f",zoomLocation.longitude);
//    
//    
//    // 2
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,15.0*METERS_PER_MILE, 15.0*METERS_PER_MILE);
//    
//    // 3
//    [_mapView setRegion:viewRegion animated:YES];
//    
//
//   }
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"dddddddddddd");
//    
//    NSLog(@"%@", error.localizedDescription);
//}
//
//- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit
//{
//    NSLog(@"%@", visit);
//}
//
//

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    _mappressed=0;
    
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    
    
    //-------  ajouter un pin
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    NSLog(@"%f",touchMapCoordinate.latitude);
    NSLog(@"%f",touchMapCoordinate.longitude);
    

    
    PFGeoPoint *currentPoint = [PFGeoPoint geoPointWithLatitude:touchMapCoordinate.latitude
                                                      longitude:touchMapCoordinate.longitude];
    _point=currentPoint;
    
    
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate *datee = [f dateFromString:@"2020-01-10"];
    
    //---- fin ajout pin
    self.flatDatePicker = [[FlatDatePicker alloc] initWithParentView:self.view];
    self.flatDatePicker.delegate = self;
    self.flatDatePicker.title = @"Program Day:";
    self.flatDatePicker.maximumDate=datee;
    
 
    self.flatDatePicker.minimumDate=[NSDate date];
    self.flatDatePicker.datePickerMode = FlatDatePickerModeDate;
    //self.flatDatePicker.datePickerMode=FlatDatePickerModeDateAndTime;
    [self.flatDatePicker show];
    
    
    
//    //---- alert program begin
//    
//    SCLAlertView *alert = [[SCLAlertView alloc] init];
//    
//    UITextField *title = [alert addTextField:@"title"];
//    title.keyboardType = UIKeyboardTypeNumberPad;
//    
//    UITextField *description = [alert addTextField:@"Description"];
//    description.keyboardType = UIKeyboardTypeNumberPad;
//    
//    
//    UITextField *date = [alert addTextField:@"date"];
//    date.keyboardType = UIKeyboardTypeNumberPad;
//    
//    
//    [alert addButton:@"Test Validation" validationBlock:^BOOL{
//        if (title.text.length == 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"You forgot to add an even number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//            [title becomeFirstResponder];
//            return NO;
//        }
//        
//        if (description.text.length == 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"You forgot to add an odd number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//            [description becomeFirstResponder];
//            return NO;
//        }
//        
//        if (date.text.length == 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"You forgot to add an odd number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//            [date becomeFirstResponder];
//            return NO;
//        }
//       
//       
//     
//        _tit=title.text;
//        _desc=description.text;
//        _dat=date.text;
//        NSLog(@"%@",title.text);
//
//        return YES;
//       
//
//        
//    }
//         actionBlock:^
//    {
//        [[[UIAlertView alloc] initWithTitle:@"Enjoy Your Program!" message:@"get an amazing compani :)" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//        
//        [self actionSuccessAddProg];
//        
//    }];
//    
//    [alert showEdit:self title:@"Validation" subTitle:@"Ensure the data is correct before dismissing!" closeButtonTitle:@"Cancel" duration:0];
//    
//    //--------alert program end
//    
// 
//    
//    //-------  ajouter un pin
//    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
//    CLLocationCoordinate2D touchMapCoordinate =
//    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
//    NSLog(@"%f",touchMapCoordinate.latitude);
//    NSLog(@"%f",touchMapCoordinate.longitude);
//
//    
//   
//    
//    //---- fin ajout pin
//  
//  
//    PFGeoPoint *currentPoint = [PFGeoPoint geoPointWithLatitude:touchMapCoordinate.latitude
//                                                      longitude:touchMapCoordinate.longitude];
//    _point=currentPoint;
   
  
}

-(void) actionSuccessAddProg
{
    
    
    

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didValid:(UIButton*)sender date:(NSDate*)date {
    
    _mappressed=1;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    if (datePicker.datePickerMode == FlatDatePickerModeDate) {
       
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
       
       

//        self.flatTimePicker = [[FlatDatePicker alloc] initWithParentView:self.view];
//        self.flatTimePicker.delegate = self;
//        self.flatTimePicker.title = @"Program Time";
//        self.flatTimePicker.datePickerMode = FlatDatePickerModeTime;
//        [self.flatTimePicker show];
        NSString *valueDate = [dateFormatter stringFromDate:date];
        
        
        //self.labelDateSelected.text = value;
        
        NSLog(@"%@",valueDate);
         _programDate=date;
        
        NSString *message = [NSString stringWithFormat:@"Did valid date : %@", valueDate];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"FlatDatePicker" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        
//        //---- alert program begin
//        
//        SCLAlertView *alert = [[SCLAlertView alloc] init];
//        
//        UITextField *title = [alert addTextField:@"title"];
//        title.keyboardType = UIKeyboardAppearanceLight;
//        
//        UITextField *description = [alert addTextField:@"Description"];
//        description.keyboardType = UIKeyboardAppearanceLight;
//        
//        
//        UITextField *date = [alert addTextField:@"date"];
//        date.keyboardType = UIKeyboardTypeNumberPad;
//        
//        
//        [alert addButton:@"Test Validation" validationBlock:^BOOL{
//            if (title.text.length == 0)
//            {
//                [[[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"You forgot to add an even number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//                [title becomeFirstResponder];
//                return NO;
//            }
//            
//            if (description.text.length == 0)
//            {
//                [[[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"You forgot to add an odd number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//                [description becomeFirstResponder];
//                return NO;
//            }
//            
//            if (date.text.length == 0)
//            {
//                [[[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"You forgot to add an odd number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//                [date becomeFirstResponder];
//                return NO;
//            }
//            
//            
//            
//            _tit=title.text;
//            _desc=description.text;
//            _dat=date.text;
//            NSLog(@"%@",title.text);
//            
//            return YES;
//            
//            
//            
//        }
//             actionBlock:^
//         {
//             [[[UIAlertView alloc] initWithTitle:@"Enjoy Your Program!" message:@"get an amazing compani :)" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//             
//             [self actionSuccessAddProg];
//             
//         }];
//        
//        [alert showEdit:self title:@"Validation" subTitle:@"Ensure the data is correct before dismissing!" closeButtonTitle:@"Cancel" duration:0];
//        
//        //--------alert program end
        

    
    }
    if (datePicker.datePickerMode == FlatDatePickerModeTime) {
        
      
        
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        
       
        
        [self.flatDatePicker dismiss];
        _programtime=date ;
        
        
        NSString *valueTime = [dateFormatter stringFromDate:date];
        
        
        //self.labelDateSelected.text = value;
        
        NSLog(@"%@",valueTime);
        
        NSString *message = [NSString stringWithFormat:@"Did valid date : %@", valueTime];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"FlatDatePicker" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        
        
        
        
        
        
        
    } else {
        
     
        
        [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
        _programfinalDate=date ;
        
        NSLog(@"%@",_programfinalDate);
        
      }
      
    }
  
  
    
   


- (IBAction)Validate:(id)sender {
    if([_txttitle.text isEqualToString:@""] || [_txtDescription.text isEqualToString:@""])
    {
        
        SCLAlertView *alert1 = [[SCLAlertView alloc] init];
        
        [alert1 showNotice:self title:@"Validation error" subTitle:@"title or description not defined" closeButtonTitle:nil duration:3.0f];
        
    }
    else if (_mappressed==0)
    {
        
        SCLAlertView *alert1 = [[SCLAlertView alloc] init];
        
        [alert1 showNotice:self title:@"Validation error" subTitle:@"Long press on the map to add athe palce and the date of your program" closeButtonTitle:nil duration:4.0f];
    }
    else {
    
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
        PFUser *user = [PFUser currentUser];
        
      

        
        PFObject *TagIn = [PFObject objectWithClassName:@"Programmes"];
        TagIn[@"user"] = user;
        TagIn[@"location"] = _point;
        TagIn[@"description"] =_txtDescription.text;
        TagIn[@"titre"] =_txttitle.text;
        TagIn[@"date"] =_programDate;
        
        
        
        
        
        [TagIn saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"Couldn't save!");
                NSLog(@"%@", error);
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:kStringMessageBarErrorTitle
                                                               description:kStringMessageBarErrorMessage
                                                                      type:TWMessageBarMessageTypeError
                                                            statusBarStyle:UIStatusBarStyleLightContent
                                                                  callback:nil];
                
                return;
            }
            if (succeeded) {
                NSLog(@"save program success");
                
                
            } else {
                NSLog(@"Failed to save.");
            }
        }];
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:kStringMessageBarSuccessTitle
                                                       description:kStringMessageBarSuccessMessage
                                                              type:TWMessageBarMessageTypeSuccess
                                                    statusBarStyle:UIStatusBarStyleDefault
                                                          callback:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Network Connection"
            //                                                                message:@"Please check your Internet Connection"
            //                                                               delegate:self
            //                                                      cancelButtonTitle:@"Ok"
            //                                                      otherButtonTitles:nil, nil];
            //            [alertView show];
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            
            [alert showNotice:self title:@"Internet connection" subTitle:@"You need to connect to the internet for loging in" closeButtonTitle:nil duration:2.0f];
        });
    };
    
    [internetReachableFoo startNotifier];

   
    
  
    }
    
    
    //    NSString * storyboardName = @"Main";
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"tabbarControlerId"];
//    
//    [self presentViewController:vc animated:YES completion:nil];


}

- (IBAction)CancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
 
}


@end
