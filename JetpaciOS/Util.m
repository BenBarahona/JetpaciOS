//
//  Util.m
//  JetpaciOS
//
//  Created by Escolarea on 7/3/13.
//  Copyright (c) 2013 Escolarea. All rights reserved.
//

#import "Util.h"

#define HIGHSCORE_KEY @"HIGH_SCORES"

@implementation Util

+ (NSString *)formatStringForHUD:(NSInteger)number
{
    if (number < 10)
	{
        return [NSString stringWithFormat:@"00000%d", number];
	}
	else if (number < 100)
	{
        return [NSString stringWithFormat:@"0000%d", number];
	}
	else if (number < 1000)
	{
        return [NSString stringWithFormat:@"000%d", number];
	}
	else if (number < 10000)
	{
        return [NSString stringWithFormat:@"00%d", number];
	}
	else if (number < 100000)
	{
        return [NSString stringWithFormat:@"0%d", number];
	}
	else
	{
		return [NSString stringWithFormat:@"%d", number];
	}
}

+ (void) saveHighScore:(NSUInteger)highScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:highScore] forKey:HIGHSCORE_KEY];
    [defaults synchronize];
}

+ (NSUInteger) loadHighScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:HIGHSCORE_KEY])
    {
        return [[defaults objectForKey:HIGHSCORE_KEY] intValue];
    }
    else
    {
        return 0;
    }
}

@end
