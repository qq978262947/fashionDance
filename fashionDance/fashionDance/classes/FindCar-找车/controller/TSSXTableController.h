//
//  TSSXTableController.h
//  fashionDance
//
//  Created by Dylan on 3/16/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSSXTableController : UITableViewController

@property (nonatomic,strong)NSString * resURL;

+(instancetype)tableControllerWithUrl:(NSString *)ulrStr;
@end
