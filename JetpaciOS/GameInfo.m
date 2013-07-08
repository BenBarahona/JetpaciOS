//
//  GameInfo.m
//  JetpaciOS
//
//  Created by Escolarea on 7/8/13.
//  Copyright (c) 2013 Escolarea. All rights reserved.
//

#import "GameInfo.h"

@implementation GameInfo
@synthesize score, lives, bonus, highScore, bonusInterval;

+ (GameInfo *) sharedInstance
{
    static GameInfo *instance = nil;
    if (instance == nil) {
        instance = [[GameInfo alloc] init];
    }
    return instance;
}

@end
