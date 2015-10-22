//
//  AcceuilViewController.m
//  InviteMe
//
//  Created by Sifon on 13/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//
#import "SCLAlertView.h"
#import "AcceuilViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <AVFoundation/AVAudioPlayer.h> 
#import <AudioToolbox/AudioToolbox.h>



#import "JTSImageViewController.h"
#import "JTSImageInfo.h"


#import "SingletonClass.h"



#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>




@interface AcceuilViewController ()


//@property (nonatomic, strong) AVAudioPlayer *theAudio;

@property (nonatomic, strong) UIImageView *but;
@property (nonatomic, strong) NSString *useriii;



@end



@implementation AcceuilViewController







- (void)viewDidLoad {
   
//    UIImage *background = [UIImage imageNamed: @"background.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
//    
//    [self.view addSubview: imageView];
    
    

    
    
    
//    // audio play ___________________
//    NSString *soundPath =[[NSBundle mainBundle] pathForResource:@"right_answer" ofType:@"mp3"];
//    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
//    
//    NSError *error = nil;
//    self.theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
//    [self.theAudio play];
//    
//    // _________________________
    
    
      [super viewDidLoad];
  
   


    
    PFUser *user =[PFUser currentUser];
    
    NSDictionary *profil=user[@"profile"];
    _namecurrentUser.text=profil[@"name"];
    _lastTagname.text=user[@"locationName"];
    
    
 
    
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects){
            
            PFObject *photo = objects[0];
            
            PFFile *pictureFile = photo[@"image"];
            
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                
                self.ImagePhotoDeProfile.image = [UIImage imageWithData:data];
                
               self.ImageDeProfilButton.image=[UIImage imageWithData:data];
                
               
            }];
            
        }
        
    }];
    
   
  
    
  
    
    self.tagTable.delegate=self;
    self.tagTable.dataSource=self;
    [self retreiveDataFromTagInTable];

    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapRecognizer addTarget:self action:@selector(bigButtonTapped:)];
    [self.ImageDeProfilButton addGestureRecognizer:tapRecognizer];
    [self.ImageDeProfilButton setAccessibilityLabel:@"Photo of a cat wearing a Bane costume."];
    self.ImageDeProfilButton.layer.cornerRadius = self.ImageDeProfilButton.bounds.size.width/2.0f;
    
  
    

    

    // Do any additional setup after loading the view.
}





-(void) retreiveDataFromTagInTable{
    
    PFQuery *query = [PFUser query];
    [query orderByDescending:@"updatedAt"];
   
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        
        if (! error){
                        _listTag = [[NSArray alloc] initWithArray:objects];
        
            NSLog(@"%@",_listTag);
            NSLog(@"=========================================");
            
            
                 }
        
                  [_tagTable reloadData];

       
               }];
    
    
    
    
    
    
    
    
    
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"User"];
//    //[query orderByDescending:@"createdAt"];
//   
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (! error){
//            _listTag = [[NSArray alloc] initWithArray:objects];
//           
//          
//            
//        }
//       
//        [_tagTable reloadData];
//        
//        
//        
//    }];
   
    
}



- (void)bigButtonTapped:(id)sender {
    
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = self.ImagePhotoDeProfile.image;
    imageInfo.referenceRect = self.ImagePhotoDeProfile.frame;
    imageInfo.referenceView = self.ImagePhotoDeProfile.superview;
    imageInfo.referenceContentMode = self.ImagePhotoDeProfile.contentMode;
    imageInfo.referenceCornerRadius = self.ImagePhotoDeProfile.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}
- (void)bigButtonTappedtwo:(id)sender {
    
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = self.but.image;
    imageInfo.referenceRect = self.but.frame;
    imageInfo.referenceView = self.but.superview;
    imageInfo.referenceContentMode = self.but.contentMode;
    imageInfo.referenceCornerRadius = self.but.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell* cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    PFObject *ads = [_listTag objectAtIndex:indexPath.row];
    
    NSLog(@"%@",_listTag);
    NSLog(@"=========================================");
    NSLog(@"%@",ads);
    NSLog(@"=========================================");
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    UISwipeGestureRecognizer *gestureR = [[UISwipeGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleSwipeLeftFrom:)];
    [gestureR setDirection:(UISwipeGestureRecognizerDirectionRight)];//|UISwipeGestureRecognizerDirectionRight)];
    [ cell addGestureRecognizer:gestureR];
    
    
    UISwipeGestureRecognizer *gestureRR = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(handleSwipeRightFrom:)];
    [gestureRR setDirection:(UISwipeGestureRecognizerDirectionLeft)];//|UISwipeGestureRecognizerDirectionRight)];
    [ cell addGestureRecognizer:gestureRR];
    
    
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
        // This does not require a network access.
      //  PFObject *post = ads[@"user"];
        //--------PFUser *user=ads[@"user"];
        NSDictionary *profil=ads[@"profile"];
        
        NSLog(@"Facebooooooooooookid: %@",profil[@"facebookId"]);
        
        // NSLog(@"retrieved related post: %@", post);
    
//    _fbprofilPicture = (UIImageView *)[cell viewWithTag:100];
//    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
//    
//    [query whereKey:@"user" equalTo:ads[@"user"]];
//    
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        
//        if (objects){
//            
//            PFObject *photo = objects[0];
//            
//            PFFile *pictureFile = photo[@"image"];
//            
//            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                
//                
//                _fbprofilPicture.image = [UIImage imageWithData:data];
//                
//                
//                
//            }];
//            
//        }
//        
//    }];
    

    
    
    // Display recipe in the table cell
    // UIImageView *adsImageView = (UIImageView *)[cell viewWithTag:5];
    // adsImageView.image = [UIImage imageNamed:recipe.imageFile];
    
    
   
    UILabel *adsGoingTo = (UILabel *)[cell viewWithTag:101];
    if( [ads[@"locationName"] length ]==0)
    {
        return cell;
    }
    else{
        adsGoingTo.text = ads[@"locationName"];
        NSLog(@"%@",adsGoingTo.text);
        NSLog(@"==================================");
    }
  

   
        double distanceDouble  = [_currentlocationUser distanceInKilometersTo:ads[@"location"]];
        NSString *myString = [NSString stringWithFormat:@"%f", distanceDouble];
        NSString *distance=[myString substringToIndex:4];
        
        
        
        
        
        UILabel *adsRoadOn = (UILabel *)[cell viewWithTag:102];
    NSString *new = [NSString stringWithFormat:@" '%@'Km", distance];
    adsRoadOn.text =new;

    

    UILabel *name = (UILabel *)[cell viewWithTag:202];
    name.text =profil[@"name"];
    
    
    
    self.but = (UIImageView *)[cell viewWithTag:103];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapRecognizer addTarget:self action:@selector(bigButtonTappedtwo:)];
    [self.but addGestureRecognizer:tapRecognizer];
    [self.but setAccessibilityLabel:@"Photo of a cat wearing a Bane costume."];
    self.but.layer.cornerRadius = self.but.bounds.size.width/2.0f;
    
    
    
//    NSLog(@"__________________");
//   UIImageView *fbImage = (UIImageView *)[cell viewWithTag:5];
    //FBProfilePictureView *fbImage=[[FBProfilePictureView alloc]init];
//
   // NSString *id=profil[@"facebookId"];
 //  _fbprofilPicture =(FBProfilePictureView *)[cell viewWithTag:0];
//    
   // _fbprofilPicture.profileID = id;
    
   
//fbImage =[]
    
   
        
    
    return cell;
    
    
}

- (void)handleSwipeLeftFrom:(UISwipeGestureRecognizer *)recognizer {
    
    
    CGPoint location = [recognizer locationInView:_tagTable];
    NSIndexPath *swipedIndexPath = [_tagTable indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell  = [_tagTable cellForRowAtIndexPath:swipedIndexPath];
    NSLog(@"%@",swipedIndexPath);
    NSLog(@"%@",swipedCell);
    
    
    PFObject *ProgramSelected = [_listTag objectAtIndex:swipedIndexPath.row];
    SingletonClass* sharedProg = [SingletonClass sharedProg];
    [sharedProg setProgram:ProgramSelected];
    
    // Do your work
   // NSLog(@"%d = %d",recognizer.direction,recognizer.state);
         NSString * storyboardName = @"Main";
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
     UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"TagInDetails"];
     [self presentViewController:vc animated:YES completion:nil];
    
    
    NSLog(@"=========================leffftt  programmmmmmmmmmme ========================= ");
    
    
    
    
    
    
    NSLog(@"=========================");
    NSLog(@"%@",ProgramSelected);
    NSLog(@"=========================");
    
    
}
- (void)handleSwipeRightFrom:(UISwipeGestureRecognizer *)recognizer {
    
    
    CGPoint location = [recognizer locationInView:_tagTable];
    NSIndexPath *swipedIndexPath = [_tagTable indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell  = [_tagTable cellForRowAtIndexPath:swipedIndexPath];
    NSLog(@"%@",swipedIndexPath);
    NSLog(@"%@",swipedCell);
    
    NSLog(@"index %@", swipedIndexPath);
    
    PFObject *ads = [_listProfil objectAtIndex:swipedIndexPath.row];
    PFUser *UserProgCreator=ads[@"user"];
    
    
    UserProgCreator = [_listTag objectAtIndex:swipedIndexPath.row];
    SingletonClass* sharedUserCreatorTag = [SingletonClass sharedUserProgramCreatorTag];
    [sharedUserCreatorTag setUserOfProgramCreatorTag:UserProgCreator];
    
    NSLog(@"=========================");
    NSLog(@"%@",UserProgCreator);
    NSLog(@"=========================");
    
    NSLog(@"=========================righttttt  Userrr ========================= ");
    
    
    // Do your work
    //    NSLog(@"%d = %d",recognizer.direction,recognizer.state);
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"ProfileFromTag"];
        [self presentViewController:vc animated:YES completion:nil];
    
    // [self performSegueWithIdentifier:@"test" sender:nil];
    
    
    
    //
    NSLog(@"=========================");
    NSLog(@"%@",UserProgCreator);
    NSLog(@"=========================");
    //
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return [_listTag count];
}


@end

