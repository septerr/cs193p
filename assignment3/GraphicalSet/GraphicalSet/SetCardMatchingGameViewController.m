//
//  SetGameViewController.m
//  GraphicalSet
//
//  Created by septerr on 5/19/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "SetCardMatchingGameViewController.h"
#import "SetCardCollectionViewCell.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardMatchingGameViewController()
@property (weak, nonatomic) IBOutlet UIButton *moreCardsButton;
@property (weak, nonatomic) IBOutlet UICollectionView *selectedCardsUICollectionView;

@end

@implementation SetCardMatchingGameViewController

#define STARTING_CARD_COUNT 12
#define MATCH_COUNT 3
#define MATCH_BONUS 8
#define PENALTY 2
#define FLIP_COST 1

- (Deck *) createDeck{
    self.moreCardsButton.enabled = YES;
    self.moreCardsButton.alpha = 1;
    return [[SetCardDeck alloc]init];
}

- (CardMatchingGame *) createGameWithDeck:(Deck*)deck{
    return  [[CardMatchingGame alloc] initWithCardCount:STARTING_CARD_COUNT usingDeck:deck matchCardCount:MATCH_COUNT matchBonus:MATCH_BONUS penalty:PENALTY andFlipCost:FLIP_COST];
}

- (void) updateCell:(UICollectionViewCell *)cell withCard:(Card *)card{
    if([cell isKindOfClass:[SetCardCollectionViewCell class]]
       && [card isKindOfClass:[SetCard class]]
       ){
        SetCardCollectionViewCell *setCardCell = ((SetCardCollectionViewCell *)cell) ;
        SetCard *setCard = (SetCard *)card;
        [setCardCell updateView:setCard];
    }
}

- (void) updateLastPlay:(UILabel*)label forGame:(CardMatchingGame*)game{
    LastPlayStatus *lastPlayStatus = game.lastPlayStatus;
    if(lastPlayStatus){
        switch(lastPlayStatus.status){
            case match:
                label.text = [NSString stringWithFormat:@"You found a set! %d point(s)!", lastPlayStatus.score];
                break;
            case nomatch:
                label.text = [NSString stringWithFormat:@"Not a set! %d point(s) penalty!!", lastPlayStatus.score];
                break;
            case flipup:
                label.text = @"Selected a card";
                break;
            case flipdown:
                label.text = @"Deselected a card";
                break;
            case noplay:
                label.text = @"Ooops, this card is not playable";
                break;
        }
        
        
        NSArray *selectedCards = [self.game faceUpPlayableCards];
        NSUInteger numberOfSelectedCardCells = [self.selectedCardsUICollectionView numberOfItemsInSection:0];
        if([selectedCards count] > numberOfSelectedCardCells){
            NSMutableArray *insertIndexPaths = [[NSMutableArray alloc]init];
            for(int i = numberOfSelectedCardCells; i<[selectedCards count]; i++){
                [insertIndexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
            }
            [self.selectedCardsUICollectionView insertItemsAtIndexPaths:insertIndexPaths];
        }else if([selectedCards count] < numberOfSelectedCardCells){
            NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];
            int numberOfCellsToDelete = numberOfSelectedCardCells - [selectedCards count];
            for(int i = 1; i <= numberOfCellsToDelete; i++ ){
                int lastIndex = [self.selectedCardsUICollectionView numberOfItemsInSection:0]-i;
                [deleteIndexPaths addObject:[NSIndexPath indexPathForItem:lastIndex inSection:0]];
            }
            [self.selectedCardsUICollectionView deleteItemsAtIndexPaths:deleteIndexPaths];
        }
        
    }else{
        label.text = @"";
    }
}

- (IBAction)addMoreCards:(UIButton *)sender {
        [self addCards:3];
    if([self.deck cardCount] == 0){
        self.moreCardsButton.enabled = NO;
        self.moreCardsButton.alpha = 0.5;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if([collectionView isEqual:self.selectedCardsUICollectionView]){
        UICollectionViewCell *selectedCardCell =  [self.selectedCardsUICollectionView dequeueReusableCellWithReuseIdentifier:@"SelectedCard" forIndexPath:indexPath];
        Card *card = [[self.game faceUpPlayableCards] objectAtIndex:indexPath.item];
        [self updateCell:selectedCardCell withCard:card];
        return selectedCardCell;
    }else{
        return [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([collectionView isEqual:self.selectedCardsUICollectionView]){
        return [[self.game faceUpPlayableCards] count];
    }else{
        return [super collectionView:collectionView numberOfItemsInSection:section];
    }
}

- (void) updateUI{
    [super updateUI];
    [self.selectedCardsUICollectionView reloadData];
}

@end
