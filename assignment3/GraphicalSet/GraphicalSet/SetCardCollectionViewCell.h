//
//  SetCardCollectionViewCell.h
//  GraphicalSet
//
//  Created by septerr on 5/20/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardCollectionViewCell.h"
#import "SetCardView.h"

@interface SetCardCollectionViewCell : CardCollectionViewCell
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;

@end
