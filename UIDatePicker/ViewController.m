//
//  ViewController.m
//  UIDatePicker
//
//  Created by 易云时代 on 2017/8/21.
//  Copyright © 2017年 笑伟. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/NSObject.h>

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIDatePicker *picker;//日期选择器
@property (nonatomic, strong) UILabel *label;//显示日期


@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSDictionary *dataSource;//数据源
@property (nonatomic, strong) NSArray *provArr;//省
@property (nonatomic, strong) NSArray *cityArr;//市

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*日期选择器*/
    _picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 300, 160)];//选择器初始化
    _picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-hans"];//简体中文
    _picker.datePickerMode = UIDatePickerModeDate;//日期的模式
    [self.view addSubview:_picker];
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, 300, 30)];
    _label.layer.borderWidth = 1;
    _label.text = @"时间";
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 220, 100, 30)];
    [button setTitle:@"Click" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    /*籍贯选择器*/
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 260, 300, 160)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
    //获取数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ProvinceList" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    _dataSource = dic;
    _provArr = [_dataSource allKeys];
    //默认第一个
    NSString *seledPrvo = [_provArr objectAtIndex:0];
    _cityArr = [_dataSource objectForKey:seledPrvo];
    
    
}
-(void)onClick:(id)sender{
    NSDate *date = _picker.date;
    NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    matter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    _label.text = [matter stringFromDate:date];
    
}
#pragma mark UIpickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){//省
        return _provArr.count;
    }else{//市
        return _cityArr.count;
    }
}
#pragma mark UIpickerViewDelegate
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {//省份
        return [_provArr objectAtIndex:row];
    }else{//城市
        return [_cityArr objectAtIndex:row];
        
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {

        NSString *selectedProv = [_provArr objectAtIndex:row];
        NSArray *arr = [_dataSource objectForKey:selectedProv];
        _cityArr = arr;
        [_pickerView reloadComponent:1];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
