//
//  ProgramDetailsViewController.m
//  InviteMe
//
//  Created by Sifon on 02/12/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "ProgramDetailsViewController.h"
#import "ProgramsViewController.h"
#import "SingletonClass.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreLocation/CoreLocation.h>



@implementation ProgramDetailsViewController
- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    SingletonClass* sharedSingleton = [SingletonClass sharedProg];
    _prog = [sharedSingleton program];
    
    
    
    PFUser *u =[PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"LikeProgramme"];
    //[query orderByDescending:@"createdAt"];
    [query whereKey:@"user" equalTo:u];
    [query whereKey:@"programme" equalTo:_prog];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (! error){
            _ListLike = [[NSArray alloc] initWithArray:objects];
            
            
           // NSLog(@"%d",_ListLike.count);
            NSLog(@"===============%%%%%%%% List likeee %%%%%%==============");
            if([_ListLike count] > 0)
            {
               // [_LikeButton setTitle:@"Unlike" forState:UIControlStateNormal];
                [_LikeButton setEnabled:NO];
            }

       // [_LikeButton setTitle:@"Like" forState:UIControlStateNormal];
        }
        
       
        
        
        
    }];

    
  
    
  
   
 
    NSLog(@"%@ ttttttttttt",_prog);
    NSLog(@"%@ ttttttttttt",_prog[@"objectId"]);
    NSLog(@"%@ ttttttttttt",_prog[@"objectId"]);
    NSDate *dd=_prog[@"date"];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateFormatted = [dateFormatter stringFromDate:dd];
    
    _txtTitle.text=_prog[@"titre"];
    _txtDate.text=dateFormatted;
    _txtdesc.text=_prog[@"description"];

    
    
  
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeSatellite;
    self.mapView.showsUserLocation = YES;
 
    
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
  //  NSDate *datee = [f dateFromString:@"2020-01-10"];
    
   [self zoomToUser];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //check annotation is not user location
    if([annotation isEqual:[mapView userLocation]])
    {
        //bail
        return nil;
    }
    
    static NSString *annotationViewReuseIdentifer = @"map_view_annotation";
    
    //dequeue annotation view
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIdentifer];
    
    if(!annotationView)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIdentifer];
    }
    
    //set annotation view properties
    [annotationView setAnnotation:annotation];
    
    return annotationView;
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    
//    
////    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
////        if (!error) {
////            // do something with the new geoPoint
////            
////            _pt=geoPoint;
////            
////        }
////    }];
////    NSLog(@"%@",_pt);
////    NSLog(@"%@",_pt);
////    NSLog(@"%@",_pt);
////    NSLog(@"%@",_pt);
////    NSLog(@"%@",_pt);
//    NSMutableArray *allocations=[[NSMutableArray alloc]init];
//
//    [super viewDidAppear:animated];
//   //  [ self zoomToUser];
//    
//    PFGeoPoint  *x;
//    x=_prog[@"location"];
//
//    CLLocationCoordinate2D annotationCoord;
//
//    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
//    annotationCoord.latitude = x.latitude;
//    annotationCoord.longitude = x.longitude;
//    
//        NSLog(@"%f",x.latitude);
//        NSLog(@"%f",x.longitude);
//    annotationPoint.coordinate = annotationCoord;
//    annotationPoint.title = _prog[@"titre"];
//
//    
//    
//    [allocations addObject:annotationPoint];
//    
//    
//    MKCoordinateRegion myRegion;
//    MKCoordinateSpan span;
//    
//   
//    
//    myRegion.center=annotationCoord;
//    myRegion.span=span;
//    
//    [self.mapView setRegion:myRegion animated:YES];
//    
//}

- (void)zoomToUser{
    
    PFGeoPoint  *x;
    NSDictionary *pointprog ;
    x=_prog[@"location"];
    NSLog(@"%@",x);
    
    NSLog(@"%@",pointprog);
    float spanX = 0.09;
    float spanY = 0.09;
    MKCoordinateRegion region;
    region.center.latitude = x.latitude;
    region.center.longitude =x.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    
    //self.searchButton.hidden = YES;
    [self.mapView setRegion:region animated:YES];
    
    

}
- (IBAction)BackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)LikeProgramButton:(id)sender {
    PFUser *user = [PFUser currentUser];
    
  
    
    
    PFObject *LikeProg = [PFObject objectWithClassName:@"LikeProgramme"];
    LikeProg[@"user"] = user;
    LikeProg[@"programme"] = _prog;
   
    
    
    
    
    
    [LikeProg saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Couldn't save!");
            NSLog(@"%@", error);
//            [[TWMessageBarManager sharedInstance] showMessageWithTitle:kStringMessageBarErrorTitle
//                                                           description:kStringMessageBarErrorMessage
//                                                                  type:TWMessageBarMessageTypeError
//                                                        statusBarStyle:UIStatusBarStyleLightContent
//                                                              callback:nil];
            
            return;
        }
        if (succeeded) {
            NSLog(@"save Like programme success");
         //   [_LikeButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateHighlighted];

            long nn= _ListLike.count+1;
            NSString* newNum = [NSString stringWithFormat:@"%ld", nn];

            
            PFQuery *query = [PFQuery queryWithClassName:@"Programmes"];
            
            // Retrieve the object by id
            [query getObjectInBackgroundWithId:_prog.objectId block:^(PFObject *gameScore, NSError *error) {
                
                // Now let's update it with some new data. In this case, only cheatMode and score
                // will get sent to the cloud. playerName hasn't changed.
                gameScore[@"LikeNumber"] = newNum;
               
                [gameScore saveInBackground];
                
            }];
            
            
        } else {
            NSLog(@"Failed to save.");
        }
    }];

    
    
}
@end
