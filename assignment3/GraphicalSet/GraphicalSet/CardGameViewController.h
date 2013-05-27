//
//  CardGameViewController.h
//  GraphicalSet
//
//  Created by septerr on 5/19/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic, readonly) Deck *deck;
@property (strong, nonatomic, readonly) CardMatchingGame *game;

- (void) displayMessage:(NSString *)message;
- (void) addCards:(NSUInteger)numberOfCards;
- (void) updateUI;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
@end
