//
//  SingletonClass.m
//  Share_Car_iOS
//
//  Created by Wissem Rezgui on 01/12/2014.
//  Copyright (c) 2014 Wissem Rezgui. All rights reserved.
//

#import "SingletonClass.h"

@implementation SingletonClass
@synthesize program;
@synthesize tags;
@synthesize userOfProgramCreator;
@synthesize userOfProgramCreatorTag;


#pragma mark Singleton Methods

+ (id)sharedProg {
    static SingletonClass *sharedProg = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProg = [[self alloc] init];
    });
    return sharedProg;
}

+ (id)sharedTag {
    static SingletonClass *sharedProg = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProg = [[self alloc] init];
    });
    return sharedProg;
}

+ (id)sharedUserProgramCreator {
    static SingletonClass *sharedUserProgramCreator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserProgramCreator = [[self alloc] init];
    });
    return sharedUserProgramCreator;
}

+ (id)sharedUserProgramCreatorTag {
    static SingletonClass *sharedUserProgramCreatorTag = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserProgramCreatorTag = [[self alloc] init];
    });
    return sharedUserProgramCreatorTag;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
