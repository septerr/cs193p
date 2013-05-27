//
//  SetCardView.h
//  GraphicalSet
//
//  Created by septerr on 5/20/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"
#import "CardView.h"

@interface SetCardView : CardView
@property (nonatomic) SetSymbol symbol;
@property (nonatomic) SetNumber number;
@property (nonatomic) SetColor color;
@property (nonatomic) SetShading shading;
@end
