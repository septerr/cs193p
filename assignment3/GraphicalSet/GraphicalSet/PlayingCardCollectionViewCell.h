//
//  PlayingCardCollectionViewCell.h
//  GraphicalSet
//
//  Created by septerr on 5/20/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"
#import "CardCollectionViewCell.h"
#import "PlayingCard.h"
@interface PlayingCardCollectionViewCell : CardCollectionViewCell
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@end
