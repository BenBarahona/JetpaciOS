//
//  Level1.h
//  JetpaciOS
//
//  Created by Escolarea on 6/29/13.
//  Copyright (c) 2013 Escolarea. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Jetman.h"
#import "CCTouchDispatcher.h"
#import "ZJoystick.h"
#import "Platform.h"
#import "Rocket1.h"
#import "PickUpItem.h"
#import "Laser.h"
#import "Meteor.h"
#import "Explode.h"
#import "SimpleAudioEngine.h"

@interface Level1 : CCLayer <ZJoystickDelegate, laserDelegate, enemyDelegate>
{
    Platform *floor;
    Platform *platform1;
    Platform *platform2;
    Platform *platform3;
    
    Jetman *jetman;
    
    Rocket1 *rocket;
    PickUpItem *topRocket;
    PickUpItem *middleRocket;
    
    PickUpItem *currentFuelTank;
    
    ZJoystick *joystick;
    
    CGPoint velocity;
    
    BOOL spawnFuel;
    
    NSUInteger maxLasers;
    NSInteger currentLasers;
    
    BOOL spawnEnemy;
    NSUInteger maxEnemies;
    NSInteger currentEnemies;
    
    NSMutableArray *enemyList;
    NSMutableArray *laserList;
    
    BOOL playerIsDead;
    
    NSUInteger playerLives;
    NSUInteger totalScore;
    NSUInteger highScore;
    NSUInteger bonusScore;
    
    CCLabelTTF *scoreLabel;
    CCLabelTTF *livesLabel;
    CCLabelTTF *bonusLabel;
    CCLabelTTF *highScoreLabel;
    CCLabelTTF *gameOver;
    
    BOOL gameIsPaused;
    CCSprite *pauseBtn;
    
    BOOL spawnItem;
    PickUpItem *currentItem;
    
    NSUInteger *rocketBonus;
}

+(CCScene *) scene;
@end
