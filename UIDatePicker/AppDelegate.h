//
//  AppDelegate.h
//  UIDatePicker
//
//  Created by 易云时代 on 2017/8/21.
//  Copyright © 2017年 笑伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

