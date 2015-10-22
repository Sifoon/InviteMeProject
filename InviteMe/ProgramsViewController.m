//
//  ProgramsViewController.m
//  InviteMe
//
//  Created by Sifon on 21/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "ProgramsViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <Parse/Parse.h>
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ProgramDetailsViewController.h"
#import "SingletonClass.h"

@interface ProgramsViewController ()<FBFriendPickerDelegate,FBGraphObjectPickerDelegate>
@property(strong,nonatomic) UIImageView *but;
@property(strong,nonatomic) UIImageView *imglist;
@property(strong,nonatomic) PFObject *progg;


@end
NSInteger userToknow;
NSInteger tablenumber=0;
@implementation ProgramsViewController

- (void)viewDidLoad {
//    
//    UIImage *background = [UIImage imageNamed: @"background.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
//    
//    [self.view addSubview: imageView];
    
    
[super viewDidLoad];
    
    if([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]])
                               {
                                   userToknow=0;
                                   
                               }
    
    else{
        userToknow=1;
    }
                               
    

    
 

  
    self.table.delegate=self;
    self.table.dataSource=self;
    
    
    //    // audio play ___________________
    //    NSString *soundPath =[[NSBundle mainBundle] pathForResource:@"right_answer" ofType:@"mp3"];
    //    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    //
    //    NSError *error = nil;
    //    self.theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    //    [self.theAudio play];
    //
    //    // _________________________
    
    PFUser *user =[PFUser currentUser];
    
    NSDictionary *profil=user[@"profile"];
    _nameCurrentUser.text=profil[@"name"];
    _locationCurrentUser.text=user[@"locationName"];
    
    NSLog(@"%@",_nameCurrentUser);
    NSLog(@"%@",_locationCurrentUser);
    NSLog(@"-------------------------");


    
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (objects){
            
            PFObject *photo = objects[0];
            
            PFFile *pictureFile = photo[@"image"];
            
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                
                self.imagePhotoDeProfil.image = [UIImage imageWithData:data];
                
                self.ButonPhotoDeProfil.image=[UIImage imageWithData:data];
                
                
            }];
            
        }
       // else
          //  NSLog(@"@%",error);
        
    }];
    
    
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapRecognizer addTarget:self action:@selector(bigButtonTapped:)];
    [self.ButonPhotoDeProfil addGestureRecognizer:tapRecognizer];
    [self.ButonPhotoDeProfil setAccessibilityLabel:@"Photo of a cat wearing a Bane costume."];
    self.ButonPhotoDeProfil.layer.cornerRadius = self.ButonPhotoDeProfil.bounds.size.width/2.0f;

    
    
    
    [self retreiveDataFromProgrammeTable];
    
    
//    
//    NSArray *imageList = @[[UIImage imageNamed:@"menuChat.png"], [UIImage imageNamed:@"menuUsers.png"], [UIImage imageNamed:@"menuMap.png"], [UIImage imageNamed:@"menuClose.png"]];
//    sideBar = [[CDSideBarController alloc] initWithImages:imageList];
//    sideBar.delegate = self;
    

    // Do any additional setup after loading the view.
}

-(void) viewDidLoad:(BOOL)animated
{
    if(userToknow==0)
    {
    //_addProgramButton.enabled = NO;
        

    }

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    
//    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 20, 30)];
}
#pragma mark -
#pragma mark - CDSideBarController delegate

- (void)menuButtonClicked:(int)index
{
    NSLog(@"%d", index);
    // Execute what ever you want
}

-(void) retreiveDataFromProgrammeTable{
    PFQuery *query = [PFQuery queryWithClassName:@"Programmes"];
    //[query orderByDescending:@"createdAt"];
    [query orderByAscending:@"date"];
    [query whereKey:@"date" greaterThanOrEqualTo:[NSDate date]];
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

- (void)bigButtonTapped:(id)sender {
    
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = self.imagePhotoDeProfil.image;
    imageInfo.referenceRect = self.imagePhotoDeProfil.frame;
    imageInfo.referenceView = self.imagePhotoDeProfil.superview;
    imageInfo.referenceContentMode = self.imagePhotoDeProfil.contentMode;
    imageInfo.referenceCornerRadius = self.imagePhotoDeProfil.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];
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
    _progg= ads;
    
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
    
   /* UISwipeGestureRecognizer* swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightFrom:)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [cell addGestureRecognizer:gestureR];*/
    
    
    // This does not require a network access.
    //  PFObject *post = ads[@"user"];
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
    
    _fbPicView = (FBProfilePictureView *)[cell viewWithTag:200];
    self.fbPicView.profileID = @"904381316261831";

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
//                _fbPicView.image = [UIImage imageWithData:data];
//                
//                
//                
//            }];
//            
//        }
//        
//    }];
    
    

    
    
 /*   PFFile *pictureFile = ads[@"image"];
    
    [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
      _imglist= (UIImageView *)[cell viewWithTag:100];

        _imglist.image = [UIImage imageWithData:data];
      
    }];*/
    
    
    
    
    
    
    
    
    
    NSDate *dd=ads[@"date"];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateFormatted = [dateFormatter stringFromDate:dd];
    
//    NSDateFormatter * dateee = [[NSDateFormatter alloc]init];
//    [dateee setDateFormat:@"yyyyMMdd"];
//    
//    
//    NSString * datedeb = [dateee stringFromDate:dd];
//    NSInteger value = [datedeb intValue];
//    
//    
//    NSString * curentDay = [dateee stringFromDate:[NSDate date]];
//    NSInteger valueCurrentDay = [curentDay intValue];
//    
//    
//  
//    NSLog(@"%d",value);
//     NSLog(@"%d",value);
//     NSLog(@"%d",value);
//     NSLog(@"%d",value);
    
    
  //  NSString *newString = [dateFormatted substringToIndex:10];

        UILabel *adsRoadOn1 = (UILabel *)[cell viewWithTag:103];
        adsRoadOn1.text =profil[@"name"];
        
        UILabel *adsGoingTo = (UILabel *)[cell viewWithTag:101];
        adsGoingTo.text = ads[@"titre"];
        
        
        UILabel *datelabel = (UILabel *)[cell viewWithTag:222];
        datelabel.text = dateFormatted;
        
    
  
    if(ads[@"LikeNumber"]==0)
    {
        UILabel *likelabel = (UILabel *)[cell viewWithTag:333];
        likelabel.text = @"0";
        
    }
    else
    {
        UILabel *likelabel = (UILabel *)[cell viewWithTag:333];
        likelabel.text = ads[@"LikeNumber"];
        
    }

    
//    
//    
//    self.but = (UIImageView *)[cell viewWithTag:200];
//  
//    [self.but setAccessibilityLabel:@"Photo of a cat wearing a Bane costume."];
//    self.but.layer.cornerRadius = self.but.bounds.size.width/2.0f;
    
    //    NSLog(@"__________________");
    //   _fbImage=[[FBProfilePictureView alloc]init];
    //
    //    _fbImage =(FBProfilePictureView *)[cell viewWithTag:0];
    //
    //	   _fbImage.profileID = profil[@"facebookId"];
    //_fbPicView=(FBProfilePictureView *)[cell viewWithTag:200];
   // self.fbPicView.profileID = profil[@"facebookId"];
    

    
    return cell;
    
    
}
- (void)handleSwipeLeftFrom:(UISwipeGestureRecognizer *)recognizer {
   
    
    CGPoint location = [recognizer locationInView:_table];
    NSIndexPath *swipedIndexPath = [_table indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell  = [_table cellForRowAtIndexPath:swipedIndexPath];
    NSLog(@"%@",swipedIndexPath);
    NSLog(@"%@",swipedCell);
   
    
    PFObject *ProgramSelected = [_listProg objectAtIndex:swipedIndexPath.row];
    SingletonClass* sharedProg = [SingletonClass sharedProg];
    [sharedProg setProgram:ProgramSelected];
    
        // Do your work
       // NSLog(@"%lu = %d",recognizer.direction,recognizer.state);
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailsProgram"];
        [self presentViewController:vc animated:YES completion:nil];
    
     NSLog(@"=========================leffftt  programmmmmmmmmmme ========================= ");
    
    
    
        
    
    
    NSLog(@"=========================");
    NSLog(@"%@",ProgramSelected);
    NSLog(@"=========================");
   
    
}
- (void)handleSwipeRightFrom:(UISwipeGestureRecognizer *)recognizer {
    
    
    CGPoint location = [recognizer locationInView:_table];
    NSIndexPath *swipedIndexPath = [_table indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell  = [_table cellForRowAtIndexPath:swipedIndexPath];
    NSLog(@"%@",swipedIndexPath);
    NSLog(@"%@",swipedCell);
    
    NSLog(@"index %@", swipedIndexPath);
    
    PFObject *ads = [_listProg objectAtIndex:swipedIndexPath.row];
    PFUser *UserProgCreator=ads[@"user"];
    
    
    UserProgCreator = [_listProg objectAtIndex:swipedIndexPath.row];
    SingletonClass* sharedUserCreator = [SingletonClass sharedUserProgramCreator];
    [sharedUserCreator setUserOfProgramCreator:UserProgCreator];
    
    NSLog(@"=========================");
    NSLog(@"%@",UserProgCreator);
    NSLog(@"=========================");
    
    NSLog(@"=========================righttttt  Userrr ========================= ");


    // Do your work
//    NSLog(@"%d = %d",recognizer.direction,recognizer.state);
    NSString * storyboardName = @"Main";
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"profilFreinds"];
    [self presentViewController:vc animated:YES completion:nil];
    
   // [self performSegueWithIdentifier:@"test" sender:nil];
    
    
   
    //

    //
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return [_listProg count ];
}




@end
