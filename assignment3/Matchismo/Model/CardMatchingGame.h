//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by septerr on 4/14/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
#import "LastPlayStatus.h"

@interface CardMatchingGame : NSObject
/*Designated Initializer*/
 
-(id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck matchCardCount: (NSInteger) matchingCards matchBonus:(NSInteger) bonus penalty:(NSInteger)penalty andFlipCost:(int)flipCost;
- (void) flipCardAtIndex:(NSUInteger)index;
- (Card *) cardAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) int score;
@property (nonatomic, readwrite) int numberOfCardsToMatch;
@property (strong, nonatomic) LastPlayStatus *lastPlayStatus;
@property (nonatomic) NSInteger matchBonus;
@property (nonatomic) NSInteger penalty;
@property (nonatomic) NSInteger flipCost;
@end
