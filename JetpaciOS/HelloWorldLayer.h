//
//  HelloWorldLayer.h
//  JetpaciOS
//
//  Created by Escolarea on 6/29/13.
//  Copyright Escolarea 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
