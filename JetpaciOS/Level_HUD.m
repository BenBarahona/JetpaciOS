//
//  Level_HUD.m
//  JetpaciOS
//
//  Created by Escolarea on 7/3/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import "Level_HUD.h"


@implementation Level_HUD
@synthesize scoreLabel, livesLabel, bonusLabel, highScoreLabel;
@synthesize score, lives, bonus, highScore;

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
        CCLabelTTF *firstPlayerTitle = [CCLabelTTF labelWithString:@"1UP" fontName:@"pixelmix.ttf" fontSize:12];
        firstPlayerTitle.position =  ccp(50 ,310);
        [self addChild: firstPlayerTitle];
        
        CCLabelTTF *highScoreTitle = [CCLabelTTF labelWithString:@"HI" fontName:@"pixelmix.ttf" fontSize:12];
        highScoreTitle.position =  ccp(240 ,310);
        [self addChild: highScoreTitle];
        
        scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"00000%d", score] fontName:@"pixelmix.ttf" fontSize:12];
        scoreLabel.color = ccc3(248, 252, 0);
        scoreLabel.position =  ccp(50 ,295);
        [self addChild: scoreLabel];
        
        CCSprite *playerIcon = [CCSprite spriteWithFile:@"livesIcon.png"];
        playerIcon.position = ccp(150, 310);
        playerIcon.scale = 2.5;
        [self addChild:playerIcon];
        
        livesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", lives] fontName:@"pixelmix.ttf" fontSize:12];
        livesLabel.position =  ccp(150 ,295);
        livesLabel.color = ccc3(252, 0, 0);
        [self addChild: livesLabel];
        
        highScoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"00000%d", lives] fontName:@"pixelmix.ttf" fontSize:12];
        highScoreLabel.position =  ccp(highScoreTitle.position.x ,295);
        highScoreLabel.color = ccc3(248, 252, 0);
        [self addChild: highScoreLabel];
        
        bonusLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", bonus] fontName:@"pixelmix.ttf" fontSize:12];
        bonusLabel.position = ccp(390, 300);
        [self addChild:bonusLabel];
        
        CCSprite *bonusBox = [CCSprite spriteWithFile:@"bonusBox.png"];
        bonusBox.position = ccp(390, 300);
        [self addChild:bonusBox];
    }
    
    return self;
}

- (void)onEnter
{
    CCLOG(@"HUD ENTER");
    [self schedule:@selector(update:)];
}

- (void)onExit
{
    CCLOG(@"HUD EXIT");
    [self unschedule:@selector(update:)];
}

- (void)update:(ccTime)delta
{
    [highScoreLabel setString:[Util formatStringForHUD:highScore]];
    [scoreLabel setString:[Util formatStringForHUD:score]];
    [livesLabel setString:[NSString stringWithFormat:@"%d", lives]];
}

@end
