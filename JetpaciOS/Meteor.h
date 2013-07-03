//
//  Meteor.h
//  JetpaciOS
//
//  Created by Escolarea on 6/30/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Meteor;

@protocol enemyDelegate
-(void)didRemoveEnemy:(Meteor *)enemy;
@end

@interface Meteor : CCSprite {
    CGSize windowSize;
    CGFloat speed;
    CGFloat yVelocity;
}

@property (readwrite, assign) NSUInteger score;
@property (readwrite, assign) NSInteger direction;
@property (readwrite, assign) id<enemyDelegate>delegate;

-(CGRect) getBounds;
@end
