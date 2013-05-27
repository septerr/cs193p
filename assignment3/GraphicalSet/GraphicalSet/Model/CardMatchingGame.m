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
@property (nonatomic, readwrite) NSUInteger numberOfFlips;@end

@implementation CardMatchingGame



-(id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck matchCardCount: (NSInteger) matchingCards matchBonus:(NSInteger) bonus penalty:(NSInteger)penalty andFlipCost:(int)flipCost{
    self = [super init];
    if(self){
        self.cards = [[NSMutableArray alloc] init];
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
        self.numberOfFlips = 0;
    }
    return self;
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

- (NSString *) stringCards: (NSArray *) cards{
    NSMutableString *cardContents = [[NSMutableString alloc] init];
    BOOL first = true;
    for(Card *card in cards){
        if(!first)
            [cardContents appendString:@", "];
        [cardContents appendString:card.contents];
        first = false;
    }
    return [NSString stringWithString: cardContents];
}

- (void) flipCard:(Card *)card {
    for (int i = 0; i < [self.cards count]; i++) {
        if (self.cards[i] == card) {
            [self flipCardAtIndex: (NSUInteger) i];
            break;
        }
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
            self.numberOfFlips++;
        }else{
            self.lastPlayStatus = [LastPlayStatus noPlay:card];
        }
    }
}

- (Card *) cardAtIndex:(NSUInteger)index{
    return index < [self.cards count]? self.cards[index]:nil;
}

- (NSInteger) cardCount{
    return [self.cards count];
}

- (void) removeCardAtIndex:(NSUInteger)index{
    if(index < [self.cards count]){
        [self.cards removeObjectAtIndex:index];
    }
}

//Ideally we would implement isEquals in the SetCard and PlayingCard classes to ensure the right card is deleted even if the same object is not passed.
- (void) removeCard:(Card*)card{
    [self.cards removeObject:card];
}

- (void) addCard:(Card *)card{
    [self.cards addObject:card];
}
- (NSArray *) faceUpPlayableCards{
    NSMutableArray *faceUpPlayableCards = [[NSMutableArray alloc] init];
    for(Card *card in self.cards){
        if(card.faceUp && !card.isUnplayable){
            [faceUpPlayableCards addObject:card];
        }
    }
    return faceUpPlayableCards;
}
@end

