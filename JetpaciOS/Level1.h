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
#import "Level_HUD.h"

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
    PickUpItem *currentItem;
    ZJoystick *joystick;
    
    CCSprite *pauseBtn;
    
    CGPoint velocity;
    
    BOOL spawnFuel;
    BOOL spawnEnemy;
    BOOL spawnItem;
    BOOL playerIsDead;
    
    NSUInteger *rocketBonus;
    NSUInteger maxLasers;
    NSUInteger maxEnemies;
    NSInteger currentLasers;
    NSInteger currentEnemies;
    
    NSMutableArray *enemyList;
    NSMutableArray *laserList;
    
    CCLabelTTF *gameOver;
    Level_HUD *hud;
    GameInfo *game;
}

+(CCScene *) scene;

@end
