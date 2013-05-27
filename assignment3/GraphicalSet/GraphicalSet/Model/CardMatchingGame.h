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
- (void) flipCard: (Card *)card;
- (void) flipCardAtIndex:(NSUInteger)index;
- (Card *) cardAtIndex:(NSUInteger)index;
- (void) removeCardAtIndex:(NSUInteger)index;
- (void) removeCard:(Card*)card;
- (NSInteger) cardCount;
- (void) addCard:(Card *)card;
- (NSArray *) faceUpPlayableCards;
@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSUInteger numberOfFlips;
@property (strong, nonatomic) LastPlayStatus *lastPlayStatus;
@property (nonatomic, readwrite) int numberOfCardsToMatch;
@property (nonatomic) NSInteger matchBonus;
@property (nonatomic) NSInteger penalty;
@property (nonatomic) NSInteger flipCost;
@end
