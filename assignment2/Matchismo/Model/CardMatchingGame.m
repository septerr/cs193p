//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by septerr on 4/14/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "CardMatchingGame.h"
#import "LastPlayStatus.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) int score;
@property (strong, nonatomic) NSMutableArray *cards; //of cards
//@property (nonatomic, strong, readwrite) NSString *lastPlay;
@end

@implementation CardMatchingGame



-(id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck matchCardCount: (NSInteger) matchingCards matchBonus:(NSInteger) bonus penalty:(NSInteger)penalty andFlipCost:(int)flipCost{
    self = [super init];
    if(self){
        for (int i=0; i<cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if(card){
                self.cards[i] = card;
            }else{
                self = nil;
                break;
            }
            
        }
        self.numberOfCardsToMatch = matchingCards;
        self.matchBonus = bonus;
        self.penalty = penalty;
        self.flipCost = flipCost;
        self.lastPlayStatus = nil;
    }
    return self;
}

- (NSMutableArray *) cards{
    if(!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSArray *) getOtherFaceUpCardsToMatch: (Card *) card{
    NSMutableArray *otherCards = [[NSMutableArray alloc]init];
    for(Card *otherCard in self.cards){
        if(otherCard.isFaceUp && !otherCard.isUnplayable && otherCard != card){
            [otherCards addObject:otherCard];
        }
    }
    return [[NSArray alloc] initWithArray:otherCards];
}

- (void) setUnplayableToYes: (NSArray *)cards{
    for(Card *card in cards){
        [card setUnplayable:YES];
    }
}

- (void) setFaceUpToNo: (NSArray *)cards{
    for(Card *card in cards){
        [card setFaceUp:NO];
    }
}

- (void) flipCardAtIndex:(NSUInteger)index{
    if(index < [self.cards count]){
        Card *card = self.cards[index];
        if(!card.isUnplayable){
            card.faceUp = !card.isFaceUp;
            if(card.faceUp){
                //find if it matches another playable card
                NSArray *otherCards = [self getOtherFaceUpCardsToMatch: card];
                if(otherCards && [otherCards count] > 0){
                    int matchScore = [card match:otherCards] * self.matchBonus;
                    int numberOfCardsFaceUp = 1 + [otherCards count];
                    if(matchScore != 0){//all match
                        if(numberOfCardsFaceUp == [self numberOfCardsToMatch]){
                            self.score += matchScore;
                            card.unplayable = YES;
                            [self setUnplayableToYes: otherCards];
                            self.lastPlayStatus = [LastPlayStatus matched:card with:otherCards forScore:matchScore];
                                                    }else
                          self.lastPlayStatus = [LastPlayStatus flippedUp:card forCost:self.flipCost];
                    }else{
                        self.score -= self.penalty;
                        [self setFaceUpToNo: otherCards];
                        self.lastPlayStatus = [LastPlayStatus misMatched:card andOtherCards:otherCards forpenalty:self.penalty];
                    }
                    
                }else{
                    self.lastPlayStatus = [LastPlayStatus flippedUp:card forCost:self.flipCost];
                }
            }else
                self.lastPlayStatus = [LastPlayStatus flippedDown:card];
            self.score -= self.flipCost;
        }else{
            self.lastPlayStatus = [LastPlayStatus noPlay:card];
        }
    }
}

- (Card *) cardAtIndex:(NSUInteger)index{
    return index < [self.cards count]? self.cards[index]:nil;
}
@end

