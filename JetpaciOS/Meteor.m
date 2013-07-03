//
//  Meteor.m
//  JetpaciOS
//
//  Created by Escolarea on 6/30/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import "Meteor.h"
#define SCALE 2.5


@implementation Meteor
@synthesize delegate, direction, score;

-(id)init
{
    if( (self=[super initWithFile:@"meteor.png"]))
    {
        self.scale = SCALE;
        self.score = 100;
        speed = (arc4random() % 100 + 100) / 100.0f;
        yVelocity = arc4random() % 2;
        windowSize = [[CCDirector sharedDirector] winSize];
        [self schedule:@selector(update:)];
    }
    return self;
}

-(void)update:(ccTime)delta
{
    CGPoint newPosition = self.position;
    newPosition.x += speed * self.direction;
    newPosition.y -= yVelocity;
    self.position = newPosition;
    
    if(self.direction == 1 && self.position.x > windowSize.width + self.boundingBox.size.width)
    {
        [self.delegate didRemoveEnemy:self];
        [self removeFromParent];
    }
    else if(self.direction == -1 && self.position.x < -self.boundingBox.size.width)
    {
        [self.delegate didRemoveEnemy:self];
        [self removeFromParent];
    }
    
    [self setScaleX:SCALE*self.direction];
    [self setScaleY:SCALE];
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

-(void)destroyed
{
    
}

-(void)dealloc
{
    
    [super dealloc];
}
@end
