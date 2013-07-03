//
//  RocketPart.m
//  JetpaciOS
//
//  Created by Escolarea on 6/30/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import "PickUpItem.h"
#import "SimpleAudioEngine.h"

@implementation PickUpItem
@synthesize isBeingHeld, isTouchingGround, canPickUp, dispatchPoint, stopUpdating;
@synthesize score, isPartOfRocket, playSound;

-(id)initWithFile:(NSString *)filename andCanPickUp:(BOOL)pick
{
    if( (self=[super initWithFile:filename]))
    {
        self.scale = 2.5;
        self.isTouchingGround = NO;
        self.isBeingHeld = NO;
        self.canPickUp = pick;
        self.playSound = YES;
        [self schedule:@selector(update:)];
    }
    return self;
}

-(CGRect) getBounds
{
    CGSize s  = [self contentSize];
    s.width  *= _scaleX;
    s.height *= _scaleY;
    return CGRectMake(
                      _position.x - s.width * _anchorPoint.x,
                      _position.y - s.height * _anchorPoint.y,
                      s.width,
                      s.height);
}

-(void)update:(ccTime)delta
{
    if(!self.isTouchingGround && !self.isBeingHeld)
    {
        CGPoint pos = self.position;
        CGPoint gravity = CGPointMake(0, -0.05);
        velocity.y += gravity.y;
        
        if(velocity.y <= -1.3)
        {
            velocity.y = -1.3;
        }
        
        pos.y += velocity.y;
        
        self.position = pos;
    }
    
    if((self.position.x >= self.dispatchPoint.x - 5 && self.position.x <= self.dispatchPoint.x + 5) && self.isPartOfRocket)
    {
        self.canPickUp = NO;
        self.isBeingHeld = NO;
        self.isTouchingGround = NO;
    }
}
@end
