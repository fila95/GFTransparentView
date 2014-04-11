//
// GFMaskView.m
// Version 1.0
//
// Copyright (c) 2014 Giovanni Filaferro ( http://www.nanotek.it/ ). All Rights Reserved.
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

#import "GFMaskView.h"

@implementation GFMaskView

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

-(void)drawRect:(CGRect)rect {
    CGContextRef        ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    // Convert the attributed text to a UIBezierPath
    CGPathRef           path = CGPathCreateWithRect(rect, nil);
    
    // Adjust the path bounds horizontally as requested by the view
    CGRect              bounds = rect;
    CGAffineTransform   xform = CGAffineTransformMakeTranslation(bounds.origin.x, bounds.origin.y);
    
    // Adjust the path bounds vertically because it doesn't seem to be taken into account yet
    bounds = CGPathGetBoundingBox(path);
    xform = CGAffineTransformTranslate(xform, 0., (self.bounds.size.height - bounds.size.height) / 2.);
    
    // Apply the transform to the path
    path = CGPathCreateCopyByTransformingPath(path, &xform);
    
    // Set colors, the fill color should be the background color because we're going
    //  to draw everything BUT the text, the text will be left clear.
    //CGContextSetFillColorWithColor(ctx, self.textColor.CGColor);
    
    // Flip and offset things
    CGContextScaleCTM(ctx, 1., -1.);
    CGContextTranslateCTM(ctx, 0., 0. - self.bounds.size.height);
    
    // Invert the path
    CGContextAddRect(ctx, self.bounds);
    CGContextAddPath(ctx, path);
    CGContextDrawPath(ctx, kCGPathEOFill);
    
    // Discard the path
    CFRelease(path);
    
    // Restore gstate
    CGContextRestoreGState(ctx);
}

@end
