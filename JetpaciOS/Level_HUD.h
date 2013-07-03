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
    
}

@property (readwrite, retain) CCLabelTTF *scoreLabel;
@property (readwrite, retain) CCLabelTTF *livesLabel;
@property (readwrite, retain) CCLabelTTF *bonusLabel;
@property (readwrite, retain) CCLabelTTF *highScoreLabel;
@property (readwrite, assign) NSUInteger score;
@property (readwrite, assign) NSUInteger lives;
@property (readwrite, assign) NSUInteger bonus;
@property (readwrite, assign) NSUInteger highScore;

@end
