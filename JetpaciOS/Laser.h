//
//  Laser.h
//  JetpaciOS
//
//  Created by Escolarea on 6/30/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Laser;
@protocol laserDelegate <NSObject>

-(void)didRemoveLaser:(Laser *)laser;

@end

@interface Laser : CCSprite {
    CGSize windowSize;
    NSInteger direction;
}

@property (readwrite, assign) id<laserDelegate> delegate;

-(id)initInDirection:(NSInteger)dir;
-(CGRect) getBounds;
@end
