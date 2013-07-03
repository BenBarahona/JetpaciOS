//
//  Explode.m
//  JetpaciOS
//
//  Created by Escolarea on 6/30/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import "Explode.h"


@implementation Explode

-(id)init
{
    if((self = [super initWithFile:@"explode1.png"]))
    {
        currentFrame = 1;
        [self schedule:@selector(update:) interval:0.06f];
    }
    
    return self;
}

-(void)update:(ccTime)delta
{
    currentFrame++;
    CCTexture2D *newImage = nil;
    switch (currentFrame) {
        
        case 2:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"explode2.png"];
            break;
            
        case 3:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"explode3.png"];
            break;
            
        case 4:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"explode4.png"];
            break;
            
        case 5:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"explode5.png"];
            break;
            
        case 6:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"explode6.png"];
            break;
            
        case 7:
            newImage = [[CCTextureCache sharedTextureCache] addImage:@"explode7.png"];
            break;
            
        case 8:
            [self removeFromParent];
            
        default:
            break;
    }
    
    if(newImage)
    {
        [self setTexture:newImage];
    }
}

-(void)dealloc
{
    
    [super dealloc];
}

@end
