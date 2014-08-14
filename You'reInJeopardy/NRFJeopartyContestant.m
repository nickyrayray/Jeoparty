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
        self.finalJeopartyWager = 0;
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
        self.finalJeopartyWager = [[decoder decodeObjectForKey:@"wager"] intValue];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:[NSNumber numberWithInt:self.score] forKey:@"score"];
    [encoder encodeObject:[NSNumber numberWithInt:self.finalJeopartyWager] forKey:@"wager"];
}

-(int)addThisAmountToContestantScore:(int)amountToAdd
{
    self.score += amountToAdd;
    return self.score;
}

-(int)subtractThisAmoutnFromContestantScore:(int)amountToSubtract
{
    self.score -=amountToSubtract;
    return self.score;
}

@end
