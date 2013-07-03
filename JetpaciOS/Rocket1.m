//
//  Rocket1.m
//  JetpaciOS
//
//  Created by Escolarea on 6/30/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import "Rocket1.h"
#define SCALE 2.5

@implementation Rocket1
@synthesize partCount, isReady;

- (id)init
{
    if( (self=[super initWithFile:@"rocket1.png"]))
    {
        partCount = 0;
        self.scale = SCALE;
        self.isReady = NO;
    }
    return self;
}

- (void)updateRocket
{
    partCount++;
    CCTexture2D *newImage = nil;
    NSLog(@"UPDATING ROCKET: %d", partCount);
    switch (partCount) {
        case 1:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"rocket2.png"];
            break;
            
        case 2:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"rocket3.png"];
            break;
            
        case 3:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"rocket4.png"];
            break;
            
        case 4:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"rocket5.png"];
            break;
            
        case 5:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"rocket6.png"];
            break;
            
        case 6:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"rocket7.png"];
            break;
            
        case 7:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"rocket8.png"];
            break;
        
        default:
            break;
    }
    
    if(newImage)
    {
        [self setTexture:newImage];
    }
    
    [self checkIfRocketIsReady];
}

- (void)checkIfRocketIsReady
{
    if(partCount >= 7)
    {
        self.isReady = YES;
        [self unschedule:@selector(updateRocket)];
        partCount = 8;
        [self schedule:@selector(blinkRocket) interval:0.5];
    }
}

- (void)blinkRocket
{
    if(partCount == 8)
    {
        CCTexture2D *newImage = [[CCTextureCache sharedTextureCache] addImage:@"rocket3.png"];
        [self setTexture:newImage];
        partCount = 9;
    }
    else
    {
        CCTexture2D *newImage = [[CCTextureCache sharedTextureCache] addImage:@"rocket8.png"];
        [self setTexture:newImage];
        partCount = 8;
    }
}

- (void)resetRocket
{
    CCTexture2D *newImage = [[CCTextureCache sharedTextureCache] addImage:@"rocket1.png"];
    [self setTexture:newImage];
    partCount = 0;
    [self unscheduleAllSelectors];
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

@end
