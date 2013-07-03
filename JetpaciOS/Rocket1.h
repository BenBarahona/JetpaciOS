//
//  Rocket1.h
//  JetpaciOS
//
//  Created by Escolarea on 6/30/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Rocket1 : CCSprite {
}
@property (nonatomic, assign) BOOL isReady;
@property (nonatomic, assign) NSUInteger partCount;
- (void)updateRocket;
- (void)resetRocket;
-(CGRect) getBounds;
@end
