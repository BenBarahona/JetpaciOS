//
//  GameInfo.h
//  JetpaciOS
//
//  Created by Escolarea on 7/8/13.
//  Copyright (c) 2013 Escolarea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameInfo : NSObject

@property (readwrite, assign) NSUInteger score;
@property (readwrite, assign) NSUInteger lives;
@property (readwrite, assign) NSUInteger bonus;
@property (readwrite, assign) NSUInteger highScore;
@property (readwrite, assign) NSUInteger bonusInterval;

+(GameInfo *)sharedInstance;

@end
