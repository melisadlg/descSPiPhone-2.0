//
//  GaramondProSemibold.m
//  DescubreSanP
//
//  Created by Melisa on 12/9/13.
//  Copyright (c) 2013 Melisa. All rights reserved.
//

#import "GaramondProSemibold.h"

@implementation GaramondProSemibold

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
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
 */

- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"GaramondPremrPro-SmbdIt" size:self.font.pointSize];
}


@end
