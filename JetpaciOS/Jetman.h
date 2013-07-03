//
//  Jetman.h
//  JetpaciOS
//
//  Created by Escolarea on 6/29/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Jetman : CCSprite {
    CGPoint velocity;
}
@property (readwrite, assign) CGFloat speed;
@property (readwrite, assign) BOOL isFalling;
@property (readwrite, assign) BOOL isFlying;
@property (readwrite, assign) BOOL isTouchingGround;
@property (readwrite, assign) NSInteger direction;

-(CGRect) getBounds;
- (void) updateJetmanImage;
@end
