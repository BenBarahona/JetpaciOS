//
//  Menu.m
//  JetpaciOS
//
//  Created by Escolarea on 7/10/13.
//  Copyright 2013 Escolarea. All rights reserved.
//

#import "Menu.h"
#import "Level1.h"


@implementation Menu

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Menu *layer = [Menu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) dealloc
{
    [super dealloc];
}

- (id) init
{
    if(self = [super init])
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background = [CCSprite spriteWithFile:@"starfield.png"];
        background.position = ccp(size.width / 2, size.height / 2);
        background.scale = 2.0;
        //[self addChild:background];
        
        CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"Jetpac" fontName:@"space age.ttf" fontSize:65];
        titleLabel.position = ccp(size.width / 2, size.height / 1.2 );
        [self addChild:titleLabel];
        
        [CCMenuItemFont setFontSize:24];
        [CCMenuItemFont setFontName:@"pixelmix.ttf"];
        
        CCMenuItem *playBtn = [CCMenuItemFont itemWithString:@"Play" block:^(id sender){
            [[CCDirector sharedDirector] replaceScene:[Level1 scene]];
        }];
        
        CCMenuItem *leaderboard = [CCMenuItemFont itemWithString:@"Highscores" block:^(id sender) {
            
        }];
        
        CCMenuItem *tutorial = [CCMenuItemFont itemWithString:@"Tutorial" block:^(id sender) {
            
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:playBtn, leaderboard, tutorial, nil];
        [menu alignItemsVerticallyWithPadding:30];
        [menu setPosition:ccp(size.width / 2, size.height / 2.5)];
        
        [self addChild:menu];
    }
    return self;
}

@end
