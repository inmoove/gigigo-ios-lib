//
//  GIGLayoutSize.h
//  layout
//
//  Created by Sergio Baró on 06/02/15.
//  Copyright (c) 2015 Gigigo. All rights reserved.
//

#ifndef layout_GIGLayoutSize_h
#define layout_GIGLayoutSize_h


__unused NSLayoutConstraint* gig_constrain_width(UIView *view, CGFloat width)
{
    NSLayoutConstraint *constraint = gig_constraint_attribute(view, NSLayoutAttributeWidth, width);
    [view addConstraint:constraint];
    
    return constraint;
}

__unused NSLayoutConstraint* gig_constrain_height(UIView *view, CGFloat height)
{
    NSLayoutConstraint *constraint = gig_constraint_attribute(view, NSLayoutAttributeHeight, height);
    [view addConstraint:constraint];
    
    return constraint;
}

__unused NSArray* gig_constrain_size(UIView *view, CGSize size)
{
    NSLayoutConstraint *width = gig_constrain_width(view, size.width);
    NSLayoutConstraint *height = gig_constrain_height(view, size.height);
    
    return @[width, height];
}


#endif
