//
//  RocketPart.h
//  JetpaciOS
//
//  Created by Escolarea on 6/30/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PickUpItem : CCSprite {
    CGPoint velocity;
}
@property (readwrite, assign) BOOL playSound;
@property (readwrite, assign) NSUInteger score;
@property (readwrite, assign) BOOL isPartOfRocket;
@property (readwrite, assign) BOOL isBeingHeld;
@property (readwrite, assign) BOOL canPickUp;
@property (readwrite, assign) BOOL isTouchingGround;
@property (readwrite, assign) CGPoint dispatchPoint;
@property (readwrite, assign) BOOL stopUpdating;

-(CGRect) getBounds;
-(id)initWithFile:(NSString *)filename andCanPickUp:(BOOL)pick;
@end
