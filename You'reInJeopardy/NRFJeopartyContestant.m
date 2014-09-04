//
//  NRFJeopartyContestant.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/11/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFJeopartyContestant.h"

@implementation NRFJeopartyContestant

-(id)initWithName:(NSString *)name
{
    self = [super init];
    if(self){
        self.score = 0;
        self.wager = -1;
        self.name = name;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if(self){
        self.name = [decoder decodeObjectForKey:@"name"];
        self.score = [[decoder decodeObjectForKey:@"score"] intValue];
        self.wager = [[decoder decodeObjectForKey:@"wager"] intValue];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:[NSNumber numberWithInt:self.score] forKey:@"score"];
    [encoder encodeObject:[NSNumber numberWithInt:self.wager] forKey:@"wager"];
}

-(void)addThisAmountToContestantScore:(int)amountToAdd
{
    self.score += amountToAdd;
}

-(void)subtractThisAmountFromContestantScore:(int)amountToSubtract
{
    self.score -= amountToSubtract;
}

-(void)increaseWagerBy:(int)amountToAdd
{
    if(self.wager == -1)
        self.wager = 0;
    self.wager += amountToAdd;
    if(self.wager > self.score)
        self.wager = self.score;
}

-(void)decreaseWagerBy:(int)amountToSubtract
{
    self.wager -= amountToSubtract;
    if(self.wager < 0)
        self.wager = 0;
}

-(void)increaseDailyDoubleWagerBy:(int)amountToAdd
{
    if(self.wager == -1)
        self.wager = 0;
    self.wager += amountToAdd;
    if(self.score < 1000 && self.wager > 1000)
        self.wager = 1000;
    else if(self.wager > self.score && self.score >= 1000)
        self.wager = self.score;
}

-(void)decreaseDailyDoubleWagerBy:(int)amountToSubtract
{
    self.wager -= amountToSubtract;
    if(self.wager < 0)
        self.wager = 0;
}

@end
