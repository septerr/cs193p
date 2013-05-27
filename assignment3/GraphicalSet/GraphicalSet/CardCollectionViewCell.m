//
//  CardCollectionViewCell.m
//  GraphicalSet
//
//  Created by septerr on 5/21/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "CardCollectionViewCell.h"

@implementation CardCollectionViewCell

- (CardView *) cardView{
    //abstract
    return nil;
}
- (void) updateView:(Card *)card{
    //abstract
}
@end
