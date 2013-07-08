//
//  Level_HUD.h
//  JetpaciOS
//
//  Created by Escolarea on 7/3/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Level_HUD : CCLayer {
    GameInfo *game;
}

- (void) saveHighScore;

@property (readwrite, retain) CCLabelTTF *scoreLabel;
@property (readwrite, retain) CCLabelTTF *livesLabel;
@property (readwrite, retain) CCLabelTTF *bonusLabel;
@property (readwrite, retain) CCLabelTTF *highScoreLabel;
@property (readwrite, assign) BOOL discountBonus;
@end
