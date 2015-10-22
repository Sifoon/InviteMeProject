//
//  ViewController.m
//  InviteMe
//
//  Created by Sifon on 12/11/2014.
//  Copyright (c) 2014 4sim3. All rights reserved.
//

#import "ViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <Parse/Parse.h>
#import "Reachability.h"
#import "SCLAlertView.h"


@interface ViewController ()
@property (nonatomic, strong) NSMutableData *imageData;


@end

@implementation ViewController
{
    Reachability *internetReachableFoo;
}

- (void)viewDidLoad {
 

//
//    UIImage *background = [UIImage imageNamed: @"background.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
//    
//    [self.view addSubview: imageView];
    
   
    
    
    
    [super viewDidLoad];
     [self testInternetConnection];
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated

{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hasPerformedFirstLaunch"]) {
    // On first launch, this block will execute
    // Place code here
    //  self.view.backgroundColor = [UIColor redColor];
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"FirstUse"];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    // Set the "hasPerformedFirstLaunch" key so this block won't execute again
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasPerformedFirstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
else {
    // On subsequent launches, this block will execute
}
    // Do any additional setup after loading the view, typically from a nib.

    
    // Check if user is cached and linked to Facebook, if so, bypass login
    
//    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
//        
//        [self updateUserInformation];
//        
//        NSLog(@"the user is already signed in ");
//        
//        [self performSegueWithIdentifier:@"LoginToFaceBookButton" sender:self];
//        
//    }
    
}
- (IBAction)LogInFaceBookkPressed:(UIButton *)sender {
    
    NSArray *permissionsArray = @[ @"user_about_me", @"user_interests", @"user_relationships", @"user_birthday", @"user_location", @"user_relationship_details"];
    //,@"publish_actions"
    
    /*This method delegates to the Facebook SDK to authenticate
     
     the user, and then automatically logs in (or creates, in the case where it is a new user) a PFUser. */
    
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        
        if (!user) {
            
            if (!error) {
                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"The Facebook login was cancelled." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
//               
//
//                
//                [alert show];
                SCLAlertView *alert1 = [[SCLAlertView alloc] init];
                
                [alert1 showNotice:self title:@"Login cancelled" subTitle:@"You have cancelled the Facebook login" closeButtonTitle:nil duration:2.0f];
                
            } else {
//                 NSLog(@"____________________ ");
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
//                
//                [alert show];
                 [self testInternetConnection];
                
            }
            
        } else {
           
             [self updateUserInformation];
            
     
                // On subsequent launches, this block will execute
                NSString * storyboardName = @"Main";
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
                UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"tabbarControlerId"];
                
                [self presentViewController:vc animated:YES completion:nil];

            

            
            
            
           
           
            
        }
        
    }];
    
    

}

-(void)updateUserInformation

{
    
    // Send request to Facebook
    
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        // handle response
        
        if (!error) {
            
            // Parse the data received
            
            NSDictionary *userDictionary = (NSDictionary *)result;
            
            NSString *facebookID = userDictionary[@"id"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            NSMutableDictionary *userProfile = [[NSMutableDictionary alloc] initWithCapacity:8];
            
            
            if (userDictionary[@"name"]) {
                
                userProfile[@"name"] = userDictionary[@"name"];
                
            }
            
            if (userDictionary[@"first_name"]) {
                
                userProfile[@"first_name"] = userDictionary[@"first_name"];
                
            }
            if (userDictionary[@"id"]) {
                
                userProfile[@"facebookId"] = userDictionary[@"id"];
                
            }
            
            if (userDictionary[@"location"][@"name"]) {
                
                userProfile[@"location"] = userDictionary[@"location"][@"name"];
                
            }
            
            if (userDictionary[@"gender"]) {
                
                userProfile[@"gender"] = userDictionary[@"gender"];
                
            }
            
            if (userDictionary[@"birthday"]) {
                
                userProfile[@"birthday"] = userDictionary[@"birthday"];
                
            }
            
            if (userDictionary[@"interested_in"]) {
                
                userProfile[@"interested_in"] = userDictionary[@"interested_in"];
                
            }
            
            
            if ([pictureURL absoluteString]){
                
                userProfile[@"pictureURL"] = [pictureURL absoluteString];
                
            }
            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            
            [[PFUser currentUser] saveInBackground];
            
            [self requestImage];
            
        }
        
        else {

            NSLog(@"Error in Facebook Request %@", error);
            
        }
        
    }];
    
}
- (void)uploadPFFileToParse:(UIImage *)image

{
    
    NSLog(@"upload called");
    
    // JPEG to decrease file size and enable faster uploads & downloads
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    
    if (!imageData) {
        
        return;
        
    }
    
    PFFile *photoFile = [PFFile fileWithData:imageData];
    
    [photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            NSLog(@"Photo uploaded successfully");
            
            PFObject *photo = [PFObject objectWithClassName:@"Photo"];
            
            [photo setObject:[PFUser currentUser] forKey:@"user"];
            
            [photo setObject:photoFile forKey:@"image"];
            
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            }];
            
        }
        
    }];
    
}
- (void)requestImage

{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    //Use count instead
    
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        
        if (number == 0){
            
            self.imageData = [[NSMutableData alloc] init];
            
            PFUser *user=[PFUser currentUser];
            NSURL *profilePictureURL = [NSURL URLWithString:user[@"profile"][@"pictureURL"]];
            
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0f];
            
            // Run network request asynchronously
            
            NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            
            if (!urlConnection) {
                
                NSLog(@"Failed to download picture");
                
            }
            
        }
        
    }];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    
    // As chuncks of the image are received, we build our data file
    
    [self.imageData appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    
    // All data has been downloaded, now we can set the image in the header image view
    
    UIImage *profileImage = [UIImage imageWithData:self.imageData];
    
    [self uploadPFFileToParse:profileImage];
    
}
//- (IBAction)AnonymousUserLogIn:(UIButton *)sender {
//    
//    [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
//        
//        if (!user) {
//            
//            if (!error) {
//                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"The Facebook login was cancelled." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
//                
//                
//                
//                [alert show];
//                
//            } else {
////                NSLog(@"____________________ ");
////                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
////                
////                [alert show];
//                 [self testInternetConnection];
//                
//            }
//            
//        } else {
//           
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In with Anonymous mode" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
//            
//            [alert show];
//            
//            
//            NSString * storyboardName = @"Main";
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"tabbarControlerId"];
//            
//            [self presentViewController:vc animated:YES completion:nil];
//            
//            
//            
//            
//        }
//        
//    }];
//
//    
//}

- (void)testInternetConnection
{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
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

@end
