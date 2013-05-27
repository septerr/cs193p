	//
//  PlayingCardView.m
//  GraphicalSet
//
//  Created by septerr on 5/20/13.
//  Copyright (c) 2013 septerr. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

#define DEFAULT_FACECARD_SCALE_FACTOR 0.9

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat) faceCardScaleFactor{
    if(!_faceCardScaleFactor){
        _faceCardScaleFactor = DEFAULT_FACECARD_SCALE_FACTOR;
    }
    return _faceCardScaleFactor;
}

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12.0];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    [[UIColor colorWithRed:0.941176 green:0.658823 blue:0.188235 alpha:1] setStroke];
    UIRectFill(self.bounds);
    if(self.faceUp){
        if(self.rank > 10){//is face card
            UIImage *faceCardImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.jpg", [self rankAsString], self.suit]];
            CGRect imageRect = CGRectInset(self.bounds,
                                           self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                           self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
            [faceCardImage drawInRect:imageRect];
        }else{
            [self drawPips];
        }
        [self drawCorners];
    }else{
        UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
        [cardBackImage drawInRect:self.bounds];
    }
    if (self.unplayable) {
        self.alpha = 0.5f;
    } else {
        self.alpha = 1.0f;
    }
    [roundedRect stroke];
}

#define PIP_FONT_SCALE_FACTOR 0.20
#define CORNER_OFFSET 2.0

- (void) drawCorners{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont fontWithName:@"ChalkboardSE-Regular" size:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:font}];

    CGRect rect;
    rect.origin = CGPointMake(CORNER_OFFSET, CORNER_OFFSET);
    rect.size = [str size];
    [str drawInRect:rect];
    
    [self pushContextAndRotateUpsideDown];
    [str drawInRect:rect];
    [self popContext];
}



- (void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}
- (void) popContext{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}


#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

- (void)drawPips
{
    if ((self.rank == 1) || (self.rank == 5) || (self.rank == 9) || (self.rank == 3)) {
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    if ((self.rank == 6) || (self.rank == 7) || (self.rank == 8)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:PIP_VOFFSET2_PERCENTAGE
                        mirroredVertically:(self.rank != 7)];
    }
    if ((self.rank == 4) || (self.rank == 5) || (self.rank == 6) || (self.rank == 7) || (self.rank == 8) || (self.rank == 9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET3_PERCENTAGE
                        mirroredVertically:YES];
    }
    if ((self.rank == 9) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET1_PERCENTAGE
                        mirroredVertically:YES];
    }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown
{
    if (upsideDown) [self pushContextAndRotateUpsideDown];
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIFont *pipFont = [UIFont fontWithName:@"ChalkboardSE-Regular" size:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{ NSFontAttributeName : pipFont }];
    CGSize pipSize = [attributedSuit size];
    CGPoint pipOrigin = CGPointMake(
                                    middle.x-pipSize.width/2.0-hoffset*self.bounds.size.width,
                                    middle.y-pipSize.height/2.0-voffset*self.bounds.size.height
                                    );
    [attributedSuit drawAtPoint:pipOrigin];
    if (hoffset) {
        pipOrigin.x += hoffset*2.0*self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    if (upsideDown) [self popContext];
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                  mirroredVertically:(BOOL)mirroredVertically
{
    [self drawPipsWithHorizontalOffset:hoffset
                        verticalOffset:voffset
                            upsideDown:NO];
    if (mirroredVertically) {
        [self drawPipsWithHorizontalOffset:hoffset
                            verticalOffset:voffset
                                upsideDown:YES];
    }
}

- (void) pinch:(UIPinchGestureRecognizer *)gesture{
    NSLog(@"Pinch Gesture");
}

@end
