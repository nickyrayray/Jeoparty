//
//  NRFJeopartyContestant.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/11/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRFJeopartyContestant : NSObject <NSCoding>

@property (strong, nonatomic) NSString *name;
@property int score;
@property int wager;

-(id)initWithName:(NSString *)name;
-(void)addThisAmountToContestantScore:(int)amountToAdd;
-(void)subtractThisAmountFromContestantScore:(int)amountToSubtract;
-(void)increaseWagerBy:(int)amountToAdd;
-(void)decreaseWagerBy:(int)amountToSubtract;

@end
