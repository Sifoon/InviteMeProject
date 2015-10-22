//
//  TagInDetailsViewController.m
//  InviteMe
//
//  Created by Sifon on 19/12/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "TagInDetailsViewController.h"
#import "SingletonClass.h"

@interface TagInDetailsViewController ()

@end

@implementation TagInDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SingletonClass* sharedSingleton = [SingletonClass sharedProg];
    _prog = [sharedSingleton program];
    NSLog(@"%@ ttttttttttt",_prog);
    
    
   
    
    
    
    
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeSatellite;
    self.mapView.showsUserLocation = YES;
    
    
    
 
    
    [self zoomToUser];

    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
