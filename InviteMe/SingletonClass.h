//
//  SingletonClass.h
//  Share_Car_iOS
//
//  Created by Wissem Rezgui on 01/12/2014.
//  Copyright (c) 2014 Wissem Rezgui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface SingletonClass : NSObject {
    PFObject *program;
    PFObject *tags;
    PFUser *userOfProgramCreator;
    PFUser *userOfProgramCreatorTag;

    
}
@property (nonatomic, retain) PFObject *program;
@property (nonatomic, retain) PFObject *tags;
@property (nonatomic, retain) PFUser *userOfProgramCreator;
@property (nonatomic, retain) PFUser *userOfProgramCreatorTag;


+ (id)sharedProg;
+ (id)sharedTag;
+ (id)sharedUserProgramCreator;
+ (id)sharedUserProgramCreatorTag;

@end
