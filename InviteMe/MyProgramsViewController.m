//
//  MyProgramsViewController.m
//  InviteMe
//
//  Created by Sifon on 16/12/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "MyProgramsViewController.h"

@interface MyProgramsViewController ()

@end

@implementation MyProgramsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table.delegate=self;
    self.table.dataSource=self;
    
    [self retreiveDataFromProgrammeTable];
    // Do any additional setup after loading the view.
}

-(void) retreiveDataFromProgrammeTable{
    PFQuery *query = [PFQuery queryWithClassName:@"Programmes"];
    //[query orderByDescending:@"createdAt"];
    [query orderByAscending:@"date"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query includeKey:@"user"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (! error){
            _listProg = [[NSArray alloc] initWithArray:objects];
            
            
            NSLog(@"%@",_listProg);
            NSLog(@"===============%%%%%%%%%%%%%%==============");
        }
        
        [_table reloadData];
        
        
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell* cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    PFObject *ads = [_listProg objectAtIndex:indexPath.row];
    
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
      PFUser *user=ads[@"user"];
    NSDictionary *profil=user[@"profile"];
    
    NSLog(@"Facebooooooooooookid: %@",profil[@"facebookId"]);
    
    // NSLog(@"retrieved related post: %@", post);
    
    
    
    /* FBProfilePictureView *friendImage = (FBProfilePictureView*) [cell viewWithTag:100];
     
     friendImage.profileID = user[@"profile"];*/
    
    
    
    // Display recipe in the table cell
    // UIImageView *adsImageView = (UIImageView *)[cell viewWithTag:5];
    // adsImageView.image = [UIImage imageNamed:recipe.imageFile];
    // PFUser *userr=ads[@"user"];
    
    NSLog(@"Facebooooooooooookid: %@",profil[@"facebookId"]);
    
    // NSLog(@"retrieved related post: %@", post);
    
   
 
    
    
    
    
    
    
    
    
    NSDate *dd=ads[@"date"];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateFormatted = [dateFormatter stringFromDate:dd];
 
    
    
    //  NSString *newString = [dateFormatted substringToIndex:10];
    
   
    
    UILabel *adsGoingTo = (UILabel *)[cell viewWithTag:101];
    adsGoingTo.text = ads[@"titre"];
    
    
    UILabel *datelabel = (UILabel *)[cell viewWithTag:102];
    datelabel.text = dateFormatted;
    
    UILabel *adsRoadOn1 = (UILabel *)[cell viewWithTag:103];
    adsRoadOn1.text =ads[@"description"];

    
    MKMapView *mapView = (MKMapView *)[cell viewWithTag:100];
    
    mapView.delegate = self;
    mapView.mapType = MKMapTypeSatellite;
    mapView.showsUserLocation = YES;
    
    
    PFGeoPoint  *x;
    NSDictionary *pointprog ;
    x=ads[@"location"];
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
    [mapView setRegion:region animated:YES];
    
    return cell;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return [_listProg count ];
}


- (IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
