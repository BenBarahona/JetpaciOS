//
//  Level_HUD.m
//  JetpaciOS
//
//  Created by Escolarea on 7/3/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import "Level_HUD.h"


@implementation Level_HUD
@synthesize scoreLabel, livesLabel, bonusLabel, highScoreLabel, discountBonus;

-(void)dealloc
{
    CCLOG(@"HUD DEALLOC");
    [scoreLabel release];
    [livesLabel release];
    [bonusLabel release];
    [highScoreLabel release];
    [super dealloc];
}

- (id) init
{
    if((self = [super init]))
    {
        game = [GameInfo sharedInstance];
        discountBonus = YES;
        game.bonusInterval = 2;
        
        CCLabelTTF *firstPlayerTitle = [CCLabelTTF labelWithString:@"1UP" fontName:@"pixelmix.ttf" fontSize:12];
        firstPlayerTitle.position =  ccp(50 ,310);
        [self addChild: firstPlayerTitle];
        
        CCLabelTTF *highScoreTitle = [CCLabelTTF labelWithString:@"HI" fontName:@"pixelmix.ttf" fontSize:12];
        highScoreTitle.position =  ccp(240 ,310);
        [self addChild: highScoreTitle];
        
        scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"00000%d", game.score] fontName:@"pixelmix.ttf" fontSize:12];
        scoreLabel.color = ccc3(248, 252, 0);
        scoreLabel.position =  ccp(50 ,295);
        [self addChild: scoreLabel];
        
        CCSprite *playerIcon = [CCSprite spriteWithFile:@"livesIcon.png"];
        playerIcon.position = ccp(150, 310);
        playerIcon.scale = 2.5;
        [self addChild:playerIcon];
        
        livesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", game.lives] fontName:@"pixelmix.ttf" fontSize:12];
        livesLabel.position =  ccp(150 ,295);
        livesLabel.color = ccc3(252, 0, 0);
        [self addChild: livesLabel];
        
        highScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"00000%d", game.highScore] fontName:@"pixelmix.ttf" fontSize:12];
        highScoreLabel.position =  ccp(highScoreTitle.position.x ,295);
        highScoreLabel.color = ccc3(248, 252, 0);
        [self addChild: highScoreLabel];
        
        bonusLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", game.bonus] fontName:@"pixelmix.ttf" fontSize:12];
        bonusLabel.position = ccp(390, 297);
        [self addChild:bonusLabel];
        
        CCSprite *bonusBox = [CCSprite spriteWithFile:@"bonusBox.png"];
        bonusBox.position = ccp(390, 300);
        [self addChild:bonusBox];
    }
    
    return self;
}

- (void)onEnter
{
    [self scheduleUpdate];
    [self schedule:@selector(updateBonus:) interval:game.bonusInterval];
    
    //Don´t know why selectors won't fire unless this line is used :S
    [self resumeSchedulerAndActions];
}

- (void)onExit
{
    CCLOG(@"HUD EXIT");
    [self unscheduleAllSelectors];
}

- (void)update:(ccTime)delta
{
    [highScoreLabel setString:[Util formatStringForHUD:game.highScore]];
    [scoreLabel setString:[Util formatStringForHUD:game.score]];
    [livesLabel setString:[NSString stringWithFormat:@"%d", game.lives]];
    [bonusLabel setString:[Util formatStringForHUD:game.bonus]];
}

- (void) updateBonus:(ccTime)delta
{
    game.bonus -= 100;
}

- (void) saveHighScore
{
    if(game.score > game.highScore)
    {
        game.highScore = game.score;
    }
    [Util saveHighScore:game.highScore];
}

@end
