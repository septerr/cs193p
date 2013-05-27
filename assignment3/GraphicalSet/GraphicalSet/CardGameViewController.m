//
//  CardGameViewController.m
//  GraphicalSet
//
//  Created by septerr on 5/19/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "CardCollectionViewCell.h"
#import "PlayingCardView.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic, readwrite) CardMatchingGame *game;
@property (strong, nonatomic, readwrite) Deck* deck;
@end

@implementation CardGameViewController

//initialization

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deck = [self createDeck];
    self.game = [self createGameWithDeck:self.deck];
    [self.cardCollectionView addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cardSwipe:)]];
}


//abstract methods:
- (void) updateCell:(UICollectionViewCell *)cell withCard:(Card *)card{
    //abstract
    [NSException raise:@"Abstract method called." format:@"This method is abstract. It should be implemented by a subclass."];
}

- (CardMatchingGame *) createGameWithDeck:(Deck*)deck{
    //abstract
    [NSException raise:@"Abstract method called." format:@"This method is abstract. It should be implemented by a subclass."];
    return nil;
}

- (Deck *) createDeck{
    //abstract
    [NSException raise:@"Abstract method called." format:@"This method is abstract. It should be implemented by a subclass."];
    return nil;
}


//UICollectionViewDataSource methods:
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.game cardCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.cardCollectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell withCard:card];
    return cell;
}

//handler methods
- (IBAction)handleTap:(UITapGestureRecognizer *)sender {
    CGPoint location =  [sender locationInView:self.cardCollectionView];
    NSIndexPath *cellIndex = [self.cardCollectionView indexPathForItemAtPoint:location];
    if(cellIndex){
        [self flipCardAtIndexPath:cellIndex];
        [self updateUI];
    }
}

- (IBAction)cardSwipe:(UISwipeGestureRecognizer *)sender {
    CGPoint location =  [sender locationInView:self.cardCollectionView];
    NSIndexPath *cellIndex = [self.cardCollectionView indexPathForItemAtPoint:location];
    if(cellIndex){
        [self flipCardAtIndexPath:cellIndex];
        [self updateUI];
    }
}

- (IBAction)dealAction:(id)sender {
    self.deck = [self createDeck];
    self.game = [self createGameWithDeck:self.deck];
    [self updateUI];
}


- (void) flipCardAtIndexPath:(NSIndexPath *)indexPath{
    [self.game flipCardAtIndex:indexPath.item];
    Card *card = [self.game cardAtIndex:indexPath.item];
    CardCollectionViewCell *cell = (CardCollectionViewCell *)[self.cardCollectionView cellForItemAtIndexPath:indexPath];
    [self updateCell:cell withCard:card];
    [self removeUnplayableCells];
}

- (void) updateUI{
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.game.numberOfFlips];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self updateLastPlay:self.statusLabel forGame:self.game];
    [self.cardCollectionView reloadData];
    
}

- (void) removeUnplayableCells{
    NSMutableArray *unplayableIndexes = [[NSMutableArray alloc] init];
    for(int i=0; i<self.game.cardCount; i++){
        Card *card = [self.game cardAtIndex:i];
        if(card.isUnplayable){
            [self.game removeCard:card];
            [unplayableIndexes addObject:[NSIndexPath indexPathForItem:i inSection:0]];
        }
    }
    [self.cardCollectionView deleteItemsAtIndexPaths:unplayableIndexes];
}

- (void) addCards:(NSUInteger)numberOfCards{
    if(self.deck.cardCount == 0){
        [self displayMessage:@"There are no more cards in the deck :("];
    }else{
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSUInteger index = [self.cardCollectionView numberOfItemsInSection:0];
        NSUInteger cardsInDeck = [self.deck cardCount];
        for(int i=0; i < cardsInDeck  && i < numberOfCards; i++){
            Card *card = [self.deck drawRandomCard];
            [self.game addCard:card];
            [indexPaths addObject:[NSIndexPath indexPathForItem:index++ inSection:0]];
        }
        [self.cardCollectionView insertItemsAtIndexPaths:indexPaths];
        [self.cardCollectionView scrollToItemAtIndexPath:indexPaths[0] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    }
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
                label.text = [NSString stringWithFormat:@"Flipped up %@", lastPlayStatus.card.contents];
                break;
            case flipdown:
                label.text = [NSString stringWithFormat:@"Flipped down %@", lastPlayStatus.card.contents];
                break;
            case noplay:
                label.text = [NSString stringWithFormat:@"Card %@ is unplayable", lastPlayStatus.card.contents];
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

- (void) displayMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Some Title" message:message delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alert show];
}



@end
