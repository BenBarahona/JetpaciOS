//
//  Jetman.m
//  JetpaciOS
//
//  Created by Escolarea on 6/29/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import "Jetman.h"
#define SCALE 2.0

@implementation Jetman
@synthesize isFalling = _isFalling;
@synthesize isFlying = _isFlying;
@synthesize isTouchingGround = _isTouchingGround;
@synthesize direction = _direction;

-(id) init
{
    if( (self=[super initWithFile:@"jetman_flying.png"]))
    {
    self.isFalling = YES;
    self.isFlying = NO;
    self.isTouchingGround = NO;
    self.direction = 1;
    [self schedule:@selector(update:)];
    }
    return self;
}

- (void) update:(ccTime)delta
{
    if(!self.isFlying && self.isFalling)
    {
         CGPoint gravity = CGPointMake(0, -0.05);
         velocity.y += gravity.y;
         
         if(velocity.y <= -2.5)
         {
             velocity.y = -2.5;
         }
         
         CGPoint pos = self.position;
         pos.y += velocity.y;
         
         self.position = pos;
        
    }
    [self updateJetmanImage];
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

-(void)updateJetmanImage
{
    //NSLog(@"Updating Image Fly:%d Fall:%d", self.isFlying, self.isFalling);
    CCTexture2D *newImage = nil;
    if(self.isTouchingGround)
    {
        newImage = [[CCTextureCache sharedTextureCache] addImage:@"jetman_stand.png"];
        [self setTexture:newImage];
    }
    else
    {
        newImage = [[CCTextureCache sharedTextureCache] addImage:@"jetman_flying.png"];
        [self setTexture:newImage];
    }
    
    [self setScaleX:SCALE*self.direction];
    [self setScaleY:SCALE];
}
@end
