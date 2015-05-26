//
//  Futura.m
//  descSPiPhone
//
//  Created by melisadlg on 5/24/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import "Futura.h"

@implementation Futura

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */

- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"Futura" size:self.font.pointSize];
}


@end
