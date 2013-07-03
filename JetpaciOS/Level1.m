//
//  Level1.m
//  JetpaciOS
//
//  Created by Escolarea on 6/29/13.
//  Copyright (c) 2013 Escolarea. All rights reserved.
//

#import "Level1.h"
#import "Cutscene.h"

@implementation Level1

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Level1 *layer = [Level1 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)dealloc
{
    [enemyList release];
    [laserList release];
    [super dealloc];
}

-(id)init
{
    if( (self=[super init]))
    {
		// ask director for the window size
        CGSize size = [[CCDirector sharedDirector] winSize];
        laserList = [[NSMutableArray array] retain];
        enemyList = [[NSMutableArray array] retain];
        
        [self addLevelObjects];
        [self addRocket];
        
        jetman = [Jetman node];
        jetman.position = ccp(size.width / 2, size.height / 2);
        [self addChild:jetman];
        
        //Joystick
        joystick	= [ZJoystick joystickNormalSpriteFile:@"JoystickContainer_norm.png" selectedSpriteFile:@"JoystickContainer_trans.png" controllerSpriteFile:@"Joystick_norm.png"];
        joystick.scale = 1.3;
        joystick.position	= ccp(joystick.contentSize.width/2 + 15 , joystick.contentSize.height/2 + 30);
        joystick.delegate	= self;
        joystick.controlledObject  = jetman;     //we set our controlled object which the blue circle
        joystick.speedRatio         = 2.5f;                //we set speed ratio, movement speed of blue circle once controlled to any direction
        joystick.joystickRadius     = 40.0f;               //Added in v1.2
        [self addChild:joystick];
        
        velocity = ccp(0, 0);
        spawnFuel = NO;
        currentLasers = 0;
        maxLasers = 3;
        maxEnemies = 6;
        currentEnemies = 0;
        spawnEnemy = YES;
        playerIsDead = NO;
        spawnItem = YES;
        playerLives = 4;
        totalScore = 0;
        bonusScore = 5000;
        highScore = 0;//[Util loadHighScore];
        
        gameIsPaused = NO;
        
        [self setupHUD];
        [self registerWithTouchDispatcher];
        [self schedule:@selector(update:)];
        [self schedule:@selector(updateBonus:) interval:1.5];
        [self schedule:@selector(spawnItem) interval:1.0];
        
        pauseBtn = [CCSprite spriteWithFile:@"pauseBtn_noborder.png"];
        pauseBtn.position = ccp(460,300);
        /*
        pauseBtn = [CCMenuItemImage itemWithNormalImage:@"pauseBtn_noborder.png" selectedImage:@"pauseBtn_noborder.png" target:self selector:@selector(togglePause)];
        pauseBtn.position = ccp(460,300);
        
        CCMenu *menu = [CCMenu menuWithItems:pauseBtn, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
        */
        [[SimpleAudioEngine sharedEngine] playEffect:@"Start and Item Get.wav"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Jetpac Song.wav" loop:YES];
        
        [self loadHighScore];
	}
	
	return self;
}

- (void)togglePause
{
    NSLog(@"TOGGLE PAUSE");
    if(gameIsPaused)
    {
        gameIsPaused = NO;
    }
    else
    {
        gameIsPaused = YES;
    }
}

- (void) addLevelObjects
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *background = [CCSprite spriteWithFile:@"mainBG.png"];
    background.position = ccp(size.width/2, size.height/2);
    [self addChild: background];
    
    floor = [[Platform alloc] initWithFile:@"platform_long.png"];
    //floor = [CCSprite spriteWithFile:@"platform_long.png"];
    floor.position = ccp(size.width / 2, 5);
    [self addChild:floor];
    
    platform1 = [[Platform alloc] initWithFile:@"platform_medium.png"];
    platform1.position = ccp(90,190);
    [self addChild:platform1];
    
    platform2 = [[Platform alloc] initWithFile:@"platform_medium.png"];
    platform2.position = ccp(400,210);
    [self addChild:platform2];
    
    platform3 = [[Platform alloc] initWithFile:@"platform_small.png"];
    platform3.position = ccp(size.width / 2, size.height / 2 - 20);
    [self addChild:platform3];
}

- (void) addRocket
{
    rocket = [Rocket1 node];
    rocket.position = ccp(330, rocket.boundingBox.size.height / 2 + floor.boundingBox.size.height / 2 + 2);
    [self addChild:rocket];
    
    topRocket = [[PickUpItem alloc] initWithFile:@"rocket_top.png" andCanPickUp:NO];
    topRocket.isPartOfRocket = YES;
    topRocket.score = 10;
    topRocket.position = ccp(platform3.position.x, 300);
    topRocket.dispatchPoint = rocket.position;
    [self addChild:topRocket];
    
    middleRocket = [[PickUpItem alloc] initWithFile:@"rocket_middle.png" andCanPickUp:YES];
    middleRocket.isPartOfRocket = YES;
    middleRocket.score = 10;
    middleRocket.position = ccp(platform1.position.x, 300);
    middleRocket.dispatchPoint = rocket.position;
    [self addChild:middleRocket];
}

- (void) reloadLevel
{
    // ask director for the window size
    if(gameOver)
    {
        playerLives = 4;
        [gameOver removeFromParent];
        gameOver = nil;
    }
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    [rocket resetRocket];
    middleRocket.position = ccp(platform1.position.x, 300);
    middleRocket.canPickUp = YES;
    if(middleRocket.stopUpdating)
    {
        middleRocket.stopUpdating = NO;
        [self addChild:middleRocket];
        [middleRocket schedule:@selector(update:)];
    }
    
    topRocket.position = ccp(platform3.position.x, 300);
    topRocket.canPickUp = NO;
    if(topRocket.stopUpdating)
    {
        topRocket.stopUpdating = NO;
        [topRocket schedule:@selector(update:)];
        [self addChild:topRocket];
    }
    
    jetman.position = ccp(size.width / 2, size.height / 2);
    jetman.isFalling = YES;
    jetman.isFlying = NO;
    jetman.isTouchingGround = NO;
    jetman.direction = 1;
    [jetman schedule:@selector(update:)];
    [self addChild:jetman];
    
    velocity = ccp(0, 0);
    currentLasers = 0;
    currentEnemies = 0;
    bonusScore = 5000;
    [self updateBonus:0];
    
    spawnEnemy = YES;
    playerIsDead = NO;
    spawnFuel = NO;
    spawnItem = YES;
    
    [enemyList removeAllObjects];
    [laserList removeAllObjects];
    
    [self schedule:@selector(update:)];
    [self schedule:@selector(spawnItem) interval:1.0];
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self convertTouchToNodeSpace:touch];
    if(location.x <= 160)
    {
        //joystick.position = location;
    }
    
    if(currentLasers < maxLasers && !playerIsDead)
    {
        Laser *beam = [[[Laser alloc] initInDirection:jetman.direction] autorelease];
        beam.position = jetman.position;
        beam.delegate = self;
        [self addChild:beam];
        beam.tag = currentLasers;
        [laserList addObject:beam];
        currentLasers++;
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"Laser Beam.wav"];
    }
    
    return YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    /*
    NSLog(@"Touch: %@", NSStringFromCGPoint(location));
    [jetman stopAllActions];
    [jetman runAction:[CCMoveTo actionWithDuration:2 position:location]];
    */
}

- (void)joystickControlBegan
{
    
}

-(void)joystickControlDidUpdate:(id)joystick toXSpeedRatio:(CGFloat)xSpeedRatio toYSpeedRatio:(CGFloat)ySpeedRatio
{
    if(xSpeedRatio > 0)
    {
        jetman.direction = 1;
    }
    else
    {
        jetman.direction = -1;
    }
    
    if(ySpeedRatio > 0)
    {
        jetman.isFlying = YES;
        jetman.isFalling = NO;
    }
}

- (void)joystickControlEnded
{
    jetman.isFlying = NO;
    if([jetman isTouchingGround])
    {
        jetman.isFalling = NO;
    }
    else
    {
        jetman.isFalling = YES;
    }
}

- (void) update:(ccTime)delta
{
    if(!gameIsPaused)
    {
        if([self checkCollisionsForPlayer])
        {
            jetman.isTouchingGround = YES;
            jetman.isFalling = NO;
        }
        else
        {
            jetman.isTouchingGround = NO;
        }
        
        if(!middleRocket.stopUpdating)
        {
            [self updateItem:middleRocket];
        }
        
        if(!topRocket.stopUpdating)
        {
            [self updateItem:topRocket];
        }
        
        if(!currentFuelTank.stopUpdating)
        {
            [self updateItem:currentFuelTank];
        }
        
        if(!currentItem.stopUpdating)
        {
            [self updateItem:currentItem];
        }
        [self updateEnemies];
        
        NSUInteger enemyRandom = arc4random() % 600;
        if(enemyRandom % 10 == 0 && currentEnemies < maxEnemies)
        {
            spawnEnemy = YES;
        }
        
        [self spawnThings];
        [self updateHUD];
        
        if([self canFinishLevel])
        {
            [self finishLevel];
        }
    }
}

-(void)updateItem:(PickUpItem *)item
{
    item.isTouchingGround = ([self checkCollisionsForSprite:item]) ? YES : NO;
    item.isBeingHeld = ([self checkCollisionBetweenPlayerAnd:item] && item.canPickUp) ? YES : NO;
    
    if(item.isBeingHeld)
    {
        if(item.playSound)
        {
            item.playSound = NO;
            [[SimpleAudioEngine sharedEngine] playEffect:@"Fuel or Rocket Part Get.wav"];
        }
        if(item.isPartOfRocket)
        {
            joystick.speedRatio = 2.0;
            [self reorderChild:item z:1];
            item.position = jetman.position;
        }
        else
        {
            totalScore += item.score;
            item.score = 0;
            item.isBeingHeld = NO;
            [item removeFromParentAndCleanup:YES];
            item = nil;
            spawnItem = YES;
            return;
        }
    }
    
    if(item.isBeingHeld && item.position.x >= item.dispatchPoint.x - 5 && item.position.x <= item.dispatchPoint.x + 5)
    {
        joystick.speedRatio = 2.5;
    }
    
    if(item.position.y <= item.dispatchPoint.y - 5 && item.position.x >= item.dispatchPoint.x - 5 && item.position.x <= item.dispatchPoint.x + 5)
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Fuel or Rocket Part Set.wav"];
        totalScore += item.score;
        [rocket updateRocket];
        item.stopUpdating = YES;
        
        if(item == middleRocket)
        {
            topRocket.canPickUp = YES;
        }
        else if((item == topRocket || item == currentFuelTank) && !rocket.isReady)
        {
            spawnFuel = YES;
        }
        
        if(rocket.isReady)
        {
            spawnFuel = NO;
        }
        
        [item removeFromParentAndCleanup:YES];
    }
}

- (void)updateLasers
{
    //NSLog(@"LASERS: %@ ENEMIES: %@", laserList, enemyList);
    for(Laser *laser in laserList)
    {
        for(Meteor *meteor in enemyList)
        {
            if([self checkCollisionBetweenLaser:laser andEnemy:meteor])
            {
                [self createExplostionAtPoint:meteor.position];
                currentEnemies--;
                currentLasers--;
                [laser removeFromParent];
                [meteor removeFromParent];
                [laserList removeObject:laser];
                [enemyList removeObject:meteor];
                return;
            }
        }
    }
}

- (void)updateEnemies
{
    for(Meteor *meteor in enemyList)
    {
        if([self checkCollisionBetweenPlayerAndEnemy:meteor])
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"Death.wav"];
            [self createExplostionAtPoint:jetman.position];
            [self jetmanDie];
        }
        else if([self checkCollisionBetweenPlatformsAndEnemy:meteor] && !playerIsDead)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"Death.wav"];
            [self createExplostionAtPoint:meteor.position];
            currentEnemies--;
            [enemyList removeObject:meteor];
            [meteor removeFromParent];
            
            return;
        }
        
        for(Laser *laser in laserList)
        {
                if([self checkCollisionBetweenLaser:laser andEnemy:meteor])
                {
                    [[SimpleAudioEngine sharedEngine] playEffect:@"Death.wav"];
                    totalScore += meteor.score;
                    [self createExplostionAtPoint:meteor.position];
                    currentEnemies--;
                    currentLasers--;
                    [laser removeFromParent];
                    [meteor removeFromParent];
                    [laserList removeObject:laser];
                    [enemyList removeObject:meteor];
                    return;
                }
        }
        
    }
}

-(void)spawnItem
{
    if(spawnItem)
    {
        NSUInteger random = arc4random() % 100 / 100;
        if(random % 10 == 0)
        {
            NSLog(@"SPAWN ITEM");
            spawnItem = NO;
            PickUpItem *item = nil;
            
            NSUInteger itemType = arc4random() % 6;
            switch (itemType) {
                case 0:
                    item = [[PickUpItem alloc] initWithFile:@"item_tri.png" andCanPickUp:YES];
                    item.isPartOfRocket = NO;
                    item.score = 30;                    
                    break;
                    
                case 1:
                    item = [[PickUpItem alloc] initWithFile:@"item_blob.png" andCanPickUp:YES];
                    item.isPartOfRocket = NO;
                    item.score = 20;
                    break;
                    
                case 2:
                    item = [[PickUpItem alloc] initWithFile:@"item_radioactive.png" andCanPickUp:YES];
                    item.isPartOfRocket = NO;
                    item.score = 50;
                    break;
                    
                case 3:
                    item = [[PickUpItem alloc] initWithFile:@"item_gold.png" andCanPickUp:YES];
                    item.isPartOfRocket = NO;
                    item.score = 100;
                    break;
                    
                case 4:
                    item = [[PickUpItem alloc] initWithFile:@"item_diamond.png" andCanPickUp:YES];
                    item.isPartOfRocket = NO;
                    item.score = 200;
                    break;
                    
                case 5:
                    item = [[PickUpItem alloc] initWithFile:@"item_cloack.png" andCanPickUp:YES];
                    item.isPartOfRocket = NO;
                    item.score = 50;
                    break;
                    
                default:
                    break;
            }
            item.scale = 0.75;
            item.position = [self randomizeItemSpawnPosition];
            currentItem = item;
            [self addChild:item];
        }
    }
}

- (void)spawnThings
{
    if(spawnFuel)
    {
        spawnFuel = NO;
        
        PickUpItem *fuel = [[PickUpItem alloc] initWithFile:@"fueltank.png" andCanPickUp:YES];
        fuel.isPartOfRocket = YES;
        fuel.score = 10;
        fuel.position = [self randomizeItemSpawnPosition];
        fuel.dispatchPoint = rocket.position;
        currentFuelTank = fuel;
        [self addChild:fuel];
    }
    
    if(spawnEnemy)
    {
        spawnEnemy = NO;
        
        Meteor *enemy = [Meteor node];
        enemy.direction = arc4random() % 2 ? 1 : -1;
        enemy.position = [self randomizeEnemySpawnPositionForDirection:enemy.direction];
        enemy.delegate = self;
        enemy.tag = currentEnemies;
        [enemyList addObject:enemy];
        [self addChild:enemy];
        
        currentEnemies++;
    }
}

- (CGPoint)randomizeItemSpawnPosition
{
    CGPoint point = ccp(0, 360);
    CGFloat randomX = 20 + arc4random() % 440;
    point.x = randomX;
    return point;
}

- (CGPoint)randomizeEnemySpawnPositionForDirection:(NSInteger)direction
{
    CGPoint point;
    if(direction > 0)
    {
        point = ccp(-30, 0);
    }
    else
    {
        point = ccp(510, 0);
    }
    CGFloat randomY = 60 + arc4random() % 320;
    point.y = randomY;
    
    return point;
}


- (void)didRemoveLaser:(Laser *)laser
{
    [laserList removeObject:laser];
    currentLasers --;
}

- (void)didRemoveEnemy:(Meteor *)meteor
{
    [enemyList removeObject:meteor];
    currentEnemies --;
}

- (void)createExplostionAtPoint:(CGPoint)point
{
    Explode *explosion = [Explode node];
    explosion.position = point;
    [self addChild:explosion];
}

- (void) jetmanDie
{
    playerLives --;
    playerIsDead = YES;
    [self unschedule:@selector(update:)];
    [jetman removeFromParent];
    
    for(Meteor *enemy in enemyList)
    {
        [enemy removeFromParent];
    }
    
    if(currentFuelTank)
    {
        if(currentFuelTank.isBeingHeld)
        {
            currentFuelTank.isBeingHeld = NO;
            currentFuelTank.isTouchingGround = NO;
        }
        [currentFuelTank removeFromParent];
        currentFuelTank = nil;
    }
    
    if (currentItem) {
        [currentItem removeFromParent];
        currentItem = nil;
    }
    

        topRocket.isBeingHeld = NO;
        
        middleRocket.isBeingHeld = NO;
    
    
    if(playerLives != 0)
    {
        [self performSelector:@selector(reloadLevel) withObject:nil afterDelay:2.0];
    }
    else
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        if(totalScore > highScore)
        {
            highScore = totalScore;
        }
        [self saveHighScore];
        
        totalScore = 0;
        gameOver = [CCLabelTTF labelWithString:@"Game Over" fontName:@"pixelmix.ttf" fontSize:30];
        gameOver.position = ccp(size.width / 2, size.height / 2 + 10);
        [self addChild:gameOver];
        [self performSelector:@selector(reloadLevel) withObject:nil afterDelay:5.0];
    }
}

/************************
 ************************
    COLLISION DETECTION
 ************************
 ************************/

- (BOOL) checkCollisionsForPlayer
{
    CGRect playerRect   = [jetman getBounds];
    CGRect platformRect1 = [platform1 getBounds];
    CGRect platformRect2 = [platform2 getBounds];
    CGRect platformRect3 = [platform3 getBounds];
    CGRect floorRect = [floor getBounds];
    
    if(CGRectIntersectsRect(playerRect, platformRect1) ||
       CGRectIntersectsRect(playerRect, platformRect2) ||
       CGRectIntersectsRect(playerRect, platformRect3) ||
       CGRectIntersectsRect(playerRect, floorRect))
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)checkCollisionsForSprite:(PickUpItem *)item
{
    CGRect itemRect   = [item getBounds];
    CGRect platformRect1 = [platform1 getBounds];
    CGRect platformRect2 = [platform2 getBounds];
    CGRect platformRect3 = [platform3 getBounds];
    CGRect floorRect = [floor getBounds];
    
    if(!item.isBeingHeld)
    {
        if(CGRectIntersectsRect(itemRect, platformRect1) ||
           CGRectIntersectsRect(itemRect, platformRect2) ||
           CGRectIntersectsRect(itemRect, platformRect3) ||
           CGRectIntersectsRect(itemRect, floorRect))
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)checkCollisionBetweenPlayerAnd:(PickUpItem *)item
{
    CGRect itemRect   = [item getBounds];
    CGRect playerRect = [jetman getBounds];
    
        if(CGRectIntersectsRect(itemRect, playerRect))
        {
            return YES;
        }
    return NO;
}

-(BOOL)checkCollisionBetweenPlayerAndEnemy:(Meteor *)enemy
{
    CGRect enemyRect   = [enemy getBounds];
    CGRect playerRect = [jetman getBounds];
    
    if(CGRectIntersectsRect(enemyRect, playerRect))
    {
        return YES;
    }
    return NO;
}

- (BOOL) checkCollisionBetweenPlatformsAndEnemy:(Meteor *)enemy
{
    CGRect itemRect   = [enemy getBounds];
    CGRect platformRect1 = [platform1 getBounds];
    CGRect platformRect2 = [platform2 getBounds];
    CGRect platformRect3 = [platform3 getBounds];
    CGRect floorRect = [floor getBounds];
    
        if(CGRectIntersectsRect(itemRect, platformRect1) ||
           CGRectIntersectsRect(itemRect, platformRect2) ||
           CGRectIntersectsRect(itemRect, platformRect3) ||
           CGRectIntersectsRect(itemRect, floorRect))
        {
            return YES;
        }
    return NO;
}

-(BOOL)checkCollisionBetweenLaser:(Laser *)laser andEnemy:(Meteor *)enemy
{
    CGRect laserRect   = [laser getBounds];
    CGRect enemyRect = [enemy getBounds];
    
    if(CGRectIntersectsRect(laserRect, enemyRect))
    {
        return YES;
    }
    return NO;
}

- (BOOL)canFinishLevel
{
    if(rocket.isReady)
    {
        CGRect playerRect = [jetman getBounds];
        CGRect rocketRect = [rocket getBounds];
        
        if(CGRectIntersectsRect(playerRect, rocketRect))
        {
            return YES;
        }
    }
    return NO;
}

/************************
 ************************
          HUD
 ************************
 ************************/

- (void) setupHUD
{
    
    CCLabelTTF *firstPlayerTitle = [CCLabelTTF labelWithString:@"1UP" fontName:@"pixelmix.ttf" fontSize:12];
    firstPlayerTitle.position =  ccp(50 ,310);
    [self addChild: firstPlayerTitle];
    
    CCLabelTTF *highScoreTitle = [CCLabelTTF labelWithString:@"HI" fontName:@"pixelmix.ttf" fontSize:12];
    highScoreTitle.position =  ccp(240 ,310);
    [self addChild: highScoreTitle];
    
    scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"00000%d", totalScore] fontName:@"pixelmix.ttf" fontSize:12];
    scoreLabel.color = ccc3(248, 252, 0);
    scoreLabel.position =  ccp(50 ,295);
    [self addChild: scoreLabel];
    
    CCSprite *playerIcon = [CCSprite spriteWithFile:@"livesIcon.png"];
    playerIcon.position = ccp(150, 310);
    playerIcon.scale = 2.5;
    [self addChild:playerIcon];
    
    livesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", playerLives] fontName:@"pixelmix.ttf" fontSize:12];
    livesLabel.position =  ccp(150 ,295);
    livesLabel.color = ccc3(252, 0, 0);
    [self addChild: livesLabel];
    
    highScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"00000%d", playerLives] fontName:@"pixelmix.ttf" fontSize:12];
    highScoreLabel.position =  ccp(highScoreTitle.position.x ,295);
    highScoreLabel.color = ccc3(248, 252, 0);
    [self addChild: highScoreLabel];
    
    bonusLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", bonusScore] fontName:@"pixelmix.ttf" fontSize:12];
    bonusLabel.position = ccp(390, 300);
    [self addChild:bonusLabel];
    
    CCSprite *bonusBox = [CCSprite spriteWithFile:@"bonusBox.png"];
    bonusBox.position = ccp(390, 300);
    [self addChild:bonusBox];
}

- (void) updateHUD
{
    [highScoreLabel setString:[self formatStringForHUD:highScore]];
    [scoreLabel setString:[self formatStringForHUD:totalScore]];
    [livesLabel setString:[NSString stringWithFormat:@"%d", playerLives]];
}

- (void) updateBonus:(ccTime)delta
{
    if(!playerIsDead)
    {
        bonusScore -= 100;
    }
    [bonusLabel setString:[self formatStringForHUD:bonusScore]];
}

- (void) finishLevel
{
    NSLog(@"LEVEL DONE!");
    totalScore += bonusScore;
    bonusScore = 0;
    
    if(totalScore > highScore)
    {
        highScore = totalScore;
    }
    
    [self saveHighScore];
    [self updateHUD];
    [self unscheduleUpdate];
    [self unscheduleAllSelectors];
    
    [jetman removeFromParent];
    
    [self performSelector:@selector(reloadLevel) withObject:nil afterDelay:2.0];
    //CCTransitionScene *transition = [CCTransitionScene transitionWithDuration:0.5 scene:[Cutscene scene]];
    //[[CCDirector sharedDirector] replaceScene:transition];
}

- (void) saveHighScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:highScore] forKey:@"HIGHSCORE"];
    [defaults synchronize];
}

- (void) loadHighScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:@"HIGHSCORE"])
    {
        highScore = [defaults objectForKey:@"HIGHSCORE"];
    }
    else
    {
        highScore = 0;
    }
}

@end
