//
//  CardGameViewController.m
//  Matchismo
//
//  Created by septerr on 4/7/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardGameViewController()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation CardGameViewController



- (void) setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) setFlipCount: (int) flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    int index = [self.cardButtons indexOfObject:sender];
    [self.game flipCardAtIndex: index];
    self.flipCount++;
    [self updateUI];
}

- (void) updateUI{
    for(int i=0; i< [self.cardButtons count]; i++){
        UIButton *button = self.cardButtons[i];
        Card *card = [self.game cardAtIndex:i];
        [self updateButton:button forCard:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self updateLastPlay:self.statusLabel forGame:self.game];
}

- (void) updateLastPlay:(UILabel*)label forGame:(CardMatchingGame*)game{
    LastPlayStatus *lastPlayStatus = game.lastPlayStatus;
    if(lastPlayStatus){
        switch(lastPlayStatus.status){
            case match:
                label.text = [NSString stringWithFormat:@"Matched %@ and %@ for %d point(s)!", [self joinCardContents:lastPlayStatus.otherCards], lastPlayStatus.card.contents, lastPlayStatus.score];
                break;
            case nomatch:
                label.text = [NSString stringWithFormat:@"%@ and %@ do not match! %d point penalty!", [self joinCardContents:lastPlayStatus.otherCards], lastPlayStatus.card.contents, lastPlayStatus.score];
                break;
            case flipup:
                label.text = [NSString stringWithFormat:@"Flipped open %@", lastPlayStatus.card.contents];
                break;
            case flipdown:
                label.text = [NSString stringWithFormat:@"Flipped over %@", lastPlayStatus.card.contents];
                break;
            case noplay:
                label.text = [NSString stringWithFormat:@"Unplayable card %@", lastPlayStatus.card.contents];
                break;
        }
    }else{
        label.text = @"Flip a card to begin";
    }
}

- (NSString *) joinCardContents:(NSArray *)cards{
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    for(Card* card in cards){
        [contents addObject:[card contents]];
    }
    return [contents componentsJoinedByString:@" "];
}

- (void) updateButton:(UIButton*)button forCard:(Card*) card{
    button.selected = card.isFaceUp;
    button.enabled  = !card.isUnplayable;
    [button setTitle:[card contents] forState:(UIControlStateSelected)];
    [button setTitle:[card contents] forState:(UIControlStateSelected | UIControlStateDisabled)];
    [button setAlpha:card.isUnplayable?0.3:1.0];
    if(!button.selected){
        UIImage *image = [UIImage imageNamed:@"card"];
        [button setImage:image  forState:UIControlStateNormal];
    }else{
        [button setImage:nil forState:UIControlStateNormal];
    }
}

- (CardMatchingGame *) game{
    if(!_game){
        _game = [self instantiateGameWithCardCount:[self.cardButtons count]];
    }
    return _game;
}

- (CardMatchingGame *) instantiateGameWithCardCount:(NSUInteger)count{
    return [[CardMatchingGame alloc] initWithCardCount: count usingDeck:[[PlayingCardDeck alloc] init] matchCardCount:2 matchBonus:4 penalty:2 andFlipCost:1];
}

- (IBAction)dealButton:(UIButton *)sender {
    self.game = nil;
    self.flipCount=0;
    [self updateUI];
}

@end
