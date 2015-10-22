//
//  TagInViewController.m
//  InviteMe
//
//  Created by Sifon on 19/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "TagInViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <Parse/Parse.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "SCLAlertView.h"
#import <Social/Social.h>







#define kGOOGLE_API_KEY @"AIzaSyAaj6QQWdX5Oe0LKHl7zbVkEzO0ce8ZQjI"

@interface TagInViewController ()
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property(strong ,nonatomic) CLLocationManager *locationManager;
@property(strong,nonatomic) NSArray *places;
@property(strong,nonatomic) NSString *OfficialGoogleAPIPlaceName;
@property(strong,nonatomic) NSDictionary *OfficialGoogleAPIPlaceLocation;

@property(strong,nonatomic) PFUser *user;


@property(strong,nonatomic) PFObject *tagIn;
@property(strong,nonatomic) PFObject *UserUpdateTag;

@property(strong,nonatomic) PFGeoPoint *FinalTagPoint;
@property(strong,nonatomic) UITextField *AddNewLocationTextField;





@end




@implementation TagInViewController

CLLocationManager *manager;
CLGeocoder *geocoder;
CLPlacemark *placemark;
CLLocation *loc;

- (void)viewDidLoad {
   
    

   
   
    
  
    

    [super viewDidLoad];
    
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            // do something with the new geoPoint
            
            _currentlocationUser=geoPoint;
            
        }
    }];
    NSLog(@"%@",_currentlocationUser);
    NSLog(@"%@",_currentlocationUser);
    NSLog(@"%@",_currentlocationUser);
    NSLog(@"%@",_currentlocationUser);
    NSLog(@"%@",_currentlocationUser);
    
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    [self getCurrentLocation];
    
    _user=[PFUser currentUser];
    _tagIn=[PFObject objectWithClassName:@"TagIn"];
    _UserUpdateTag=[PFObject objectWithClassName:@"User"];

    
    
    self.tableJson.delegate=self;
    self.tableJson.dataSource=self;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void) getCurrentLocation
{
    NSLog(@"dddddddddddd");

    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    
   
  
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied ||
             [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authorization Request" message:@"To use this feature you need to turn on Location Service." delegate:self cancelButtonTitle:@"Nope" otherButtonTitles:@"Go to Settings", nil];
        [alert show];
    }
    else {

        [self.locationManager startUpdatingLocation];
    }
}


# pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    NSLog(@"-------------querry Google----------");

    // GETTING LOcation
    [self.locationManager stopUpdatingLocation];
    loc = locations.lastObject;
    
    NSLog(@"%f",loc.coordinate.latitude);
    
    NSLog(@"%f",loc.coordinate.longitude);

    NSLog(@"-------------querry Google----------");
    
    
    // Google Querry to get places
    // Build the url string to send to Google. NOTE: The kGOOGLE_API_KEY is a constant that should contain your own API key that you obtain from Google. See this link for more info:
    // https://developers.google.com/maps/documentation/places/#Authentication
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&sensor=%d&key=%@",loc.coordinate.latitude,loc.coordinate.longitude,@"50000",true,kGOOGLE_API_KEY];
    
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
       
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    
    // fin querry google
    
    
    _latitude =loc.coordinate.latitude;
    _longitude =loc.coordinate.longitude;
    
    
    
    
 
 
        
       //  fin test save in background
    
    //
    //    // After logging in with Facebook
    //    [FBRequestConnection
    //     startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
    //         if (!error) {
    //             NSString *facebookId = [result objectForKey:@"id"];
    //             NSLog(@"%@", [result objectForKey:@"id"]);
    //             NSLog(@"--------------------");
    //
    //
    //
    //
    //         }
    //     }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"dddddddddddd");

    NSLog(@"%@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit
{
    NSLog(@"dddddddddddd");

    NSLog(@"%@", visit);
}


-(void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    _places = [json objectForKey:@"results"];
    
    
    //mettre le résultat ds un array
   
    //--------
    
    
    //Write out the data to the console.
  //  NSLog(@"Google Data: %@", _places);
    [self plotPositions:_places];
    self.googlePlacesArrayFromAFNetworking =[json objectForKey:@"results"];
    [self.tableJson reloadData];
}
-(void)plotPositions:(NSArray *)data {
    
    // 2 - Loop through the array of places returned from the Google API.
    for (int i=0; i<[data count]; i++) {
        //Retrieve the NSDictionary object in each index of the array.
        NSDictionary* place = [data objectAtIndex:i];
        //        // 3 - There is a specific NSDictionary object that gives us the location info.
        //        NSDictionary *geo = [place objectForKey:@"geometry"];
        //        // Get the lat and long for the location.
        //        NSDictionary *loc = [geo objectForKey:@"location"];
        //        // 4 - Get your name and address info for adding to a pin.
        //        NSString *name=[place objectForKey:@"name"];
        //        NSString *vicinity=[place objectForKey:@"vicinity"];
        //        // Create a special variable to hold this coordinate info.
        //        CLLocationCoordinate2D placeCoord;
        //        // Set the lat and long.
        //        placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
        //        placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
        //        // 5 - Create a new annotation.
        NSLog(@"%@",[place objectForKey:@"geometry"]);
        
        
        NSLog(@"%@",[place objectForKey:@"name"]);
        
        NSLog(@"%@",[place objectForKey:@"vicinity"]);
        
        //MapPoint *placeObject = [[MapPoint alloc] initWithName:name address:vicinity coordinate:placeCoord];
        // [mapView addAnnotation:placeObject];
    }
}



//----------- Table Json work
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   return [self.googlePlacesArrayFromAFNetworking count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
     NSDictionary *tempDictionary= [self.googlePlacesArrayFromAFNetworking objectAtIndex:indexPath.row];
    
    _OfficialGoogleAPIPlaceLocation=tempDictionary;
   // ______
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
  

    
    // Display recipe in the table cell
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    [recipeImageView setImageWithURL:[NSURL URLWithString:[tempDictionary objectForKey:@"icon"]]];
    
    
    
    
    UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:101];
    
    recipeNameLabel.text = [tempDictionary objectForKey:@"name"];
    
    UILabel *recipeDetailLabel = (UILabel *)[cell viewWithTag:102];
    
    if([tempDictionary objectForKey:@"rating"] != NULL)
    {
    recipeDetailLabel.text = [NSString stringWithFormat:@"Rating :%@ / 5",[tempDictionary   objectForKey:@"rating"]];
    }
    else
    {
        recipeDetailLabel.text = [NSString stringWithFormat:@"No rating available"];
    }
    
   // ______
    
   
    
      // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
   // NSDictionary *ptTag= [_OfficialGoogleAPIPlaceLocation objectAtIndex:indexPath.row]
    for (UIView *view in  cell.contentView.subviews){
        
        if ([view isKindOfClass:[UILabel class]]){
            
            UILabel* txtField = (UILabel *)view;
            
           
            if (txtField.tag == 101) {
                 _OfficialGoogleAPIPlaceName=txtField.text;
                NSLog(@"Data ::::::::::%@", txtField.text);
               
            }
            
        } // End of Cell Sub View
    }
    
    
    NSLog(@"_________  _________  ___________");
    
    
    // show info for validate the place
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.shouldDismissOnTapOutside = YES;
    
    
    [alert addButton:@"Validate" target:self selector:@selector(ConfirmPlaceGoogleAPI)];
    
    
    [alert alertIsDismissed:^{
        NSLog(@"SCLAlertView dismissed!");
    }];
    
    [alert showInfo:self title:@"Validate the place" subTitle:_OfficialGoogleAPIPlaceName closeButtonTitle:@"Cancel" duration:0.0f];
    

    
}



-(void) ConfirmPlaceGoogleAPI
{
    _FinalTagPoint = [PFGeoPoint geoPointWithLatitude:_latitude
             
                                            longitude:_longitude];
    
    
    //Updating in UserTable
    
    
    [[PFUser currentUser] setObject:_FinalTagPoint forKey:@"location"];
    
    [[PFUser currentUser] saveInBackground];
    [[PFUser currentUser] setObject:_OfficialGoogleAPIPlaceName forKey:@"locationName"];
    
    [[PFUser currentUser] saveInBackground];

//    _UserUpdateTag[@"location"] = _FinalTagPoint;
//    _UserUpdateTag[@"LocationName"] =_OfficialGoogleAPIPlaceName;
//    [_UserUpdateTag saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (error) {
//            NSLog(@"Couldn't save!");
//            NSLog(@"%@", error);
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
//                                                                message:nil
//                                                               delegate:self
//                                                      cancelButtonTitle:nil
//                                                      otherButtonTitles:@"Ok", nil];
//            [alertView show];
//            return;
//        }
//        if (succeeded) {
//            NSLog(@"latitude %f", loc.coordinate.latitude);
//            
//            NSLog(@"Longitude %f", loc.coordinate.longitude);
//            
//            
//            NSLog(@"Successfully saved!");
//            
//            
//        } else {
//            NSLog(@"Failed to save.");
//        }
//    }];
    //  Inserring in TagIn table
    
    
    
    _tagIn[@"user"] = _user;
    _tagIn[@"locationName"] = _OfficialGoogleAPIPlaceName;
    _tagIn[@"location"] = _FinalTagPoint;
    [_tagIn saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Couldn't save!");
            NSLog(@"%@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Ok", nil];
            [alertView show];
            return;
        }
        if (succeeded) {
            NSLog(@"latitude %f", loc.coordinate.latitude);
            
            NSLog(@"Longitude %f", loc.coordinate.longitude);
            
            
            NSLog(@"Successfully saved!");
           
           //FaceBook partage
          
            NSDictionary *nn= _user[@"profil"];
            NSString *nom =nn[@"name"];
            
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                
                  NSString *new = [NSString stringWithFormat:@"%@ just tagged in @", nom];
               
                
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [controller setInitialText:new];
                [controller addURL:[NSURL URLWithString:_OfficialGoogleAPIPlaceName]];
                [controller addImage:[UIImage imageNamed:@"ShareInviteMe"]];
                
                [self presentViewController:controller animated:YES completion:Nil];
                
            }
           
            
            
            
            
           // [self dismissViewControllerAnimated:YES completion:nil];

        } else {
            NSLog(@"Failed to save.");
        }
    }];

}

- (IBAction)addplace:(id)sender {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.shouldDismissOnTapOutside = YES;
    
   _AddNewLocationTextField = [alert addTextField:@"Enter your Location"];
    
    [alert addButton:@"Validate" target:self selector:@selector(AddNewPlace)];
    
    
    [alert alertIsDismissed:^{
    }];
    
    [alert showEdit:self title:@"Add location"  subTitle:@"Validate the place"  closeButtonTitle:@"Cancel" duration:0.0f];
}
-(void) AddNewPlace
{
    
    _FinalTagPoint = [PFGeoPoint geoPointWithLatitude:loc.coordinate.latitude
                                            longitude:loc.coordinate.longitude];
   
    if(_AddNewLocationTextField.text==nil)
    {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        
        [alert showNotice:self title:@"Nolocation Added" subTitle:@"You have to add a place, that will showed your nearby freinds" closeButtonTitle:nil duration:2.0f];
    }
    else{
        
        [[PFUser currentUser] setObject:_FinalTagPoint forKey:@"location"];
            
        [[PFUser currentUser] saveInBackground];
        [[PFUser currentUser] setObject:_AddNewLocationTextField.text forKey:@"locationName"];
        
        [[PFUser currentUser] saveInBackground];

        
    
    _tagIn[@"user"] = _user;
    _tagIn[@"location"] = _FinalTagPoint;
    _tagIn[@"locationName"] = _AddNewLocationTextField.text;
    [_tagIn saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Couldn't save!");
            NSLog(@"%@", error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Ok", nil];
            [alertView show];
            return;
        }
        if (succeeded) {
            NSLog(@"latitude %f", loc.coordinate.latitude);
            
            NSLog(@"Longitude %f", loc.coordinate.longitude);
            
            
            NSLog(@"Successfully saved!");
            
            [self dismissViewControllerAnimated:YES completion:nil];

        } else {
            NSLog(@"Failed to save.");
        }
    }];
    }

}
// ----------------- autorisation de localisation
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
- (IBAction)CancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
