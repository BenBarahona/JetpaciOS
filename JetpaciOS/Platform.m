//
//  Platform.m
//  JetpaciOS
//
//  Created by Escolarea on 6/29/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import "Platform.h"


@implementation Platform

-(id) initForPlatform:(NSString *)file
{
    if( (self=[super initWithFile:file]))
    {
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

@end
