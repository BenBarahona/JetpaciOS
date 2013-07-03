//
//  Laser.m
//  JetpaciOS
//
//  Created by Escolarea on 6/30/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import "Laser.h"


@implementation Laser
@synthesize delegate;

-(id)initInDirection:(NSInteger)dir
{
    if( (self=[super initWithFile:@"fireball.png"]))
    {
    windowSize = [[CCDirector sharedDirector] winSize];
    direction = dir;
    [self schedule:@selector(update:)];
    }
    return self;
}

- (void) update:(ccTime)delta
{
    CGPoint newPosition = self.position;
    newPosition.x += 7.0 * direction;
    self.position = newPosition;
    
    if(self.position.x > windowSize.width || self.position.x < 0)
    {
        //CCLOG(@"Removing Laser");
        [self.delegate didRemoveLaser:self];
        [self removeFromParent];
    }
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
