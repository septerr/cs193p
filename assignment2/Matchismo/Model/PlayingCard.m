//
//  PlayingCard.m
//  Matchismo
//
//  Created by septerr on 4/9/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *) contents{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *) validSuits{
    static NSArray *validSuits = nil;
    if(!validSuits) validSuits = @[@"♠", @"♣", @"♥", @"♦"];
    return validSuits;
}

@synthesize suit = _suit;
- (NSString *) suit{
    return _suit?_suit:@"?";
}
- (void) setSuit: (NSString *)suit{
    if([[PlayingCard validSuits] containsObject: suit])
        _suit = suit;
}

+ (NSArray *) rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",
             @"10", @"J", @"Q", @"K"];
}
+ (NSUInteger) maxRank{
    return [PlayingCard rankStrings].count-1;
}
- (void) setRank:(NSUInteger)rank{
    if(rank <= [PlayingCard maxRank]) _rank = rank;
}
- (int) match:(NSArray *)cards{
    //all should have same rank or suit
    
    BOOL sameRank = YES;
    for(PlayingCard *card in cards){
        sameRank = self.rank  == [card rank];
        if(!sameRank)
            break;
    }
    if(sameRank){
        return 4;
    }
    
    
    BOOL sameSuit = YES;
    for(PlayingCard *card in cards){
        sameSuit = [self.suit compare:card.suit] == NSOrderedSame;
        if(!sameSuit)
            break;
    }
    if(sameSuit)
        return 2;
    
    return 0;
}
@end
