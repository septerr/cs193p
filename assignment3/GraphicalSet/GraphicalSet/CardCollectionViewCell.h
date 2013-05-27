//
//  CardCollectionViewCell.h
//  GraphicalSet
//
//  Created by septerr on 5/21/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
#import "Card.h"
@interface CardCollectionViewCell : UICollectionViewCell
- (CardView *) cardView;
- (void) updateView:(Card *) card;
@end
