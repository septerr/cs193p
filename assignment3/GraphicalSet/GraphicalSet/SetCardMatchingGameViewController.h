//
//  SetGameViewController.h
//  GraphicalSet
//
//  Created by septerr on 5/19/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "CardGameViewController.h"
#import "SetCardView.h"

@interface SetCardMatchingGameViewController : CardGameViewController
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;

@end
