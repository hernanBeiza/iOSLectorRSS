//
//  ViewController.m
//  moofwd
//
//  Created by Hernán Beiza on 9/1/15.
//  Copyright (c) 2015 Hiperactivo. All rights reserved.
//

#import "ViewController.h"
#import "NoticiaTableViewCell.h"
#import "DetalleViewController.h"
#import "Macros.h"
#import "RSSParser.h"
#import "CargadorView.h"
@interface ViewController ()  <UITableViewDelegate,UITableViewDataSource, NoticiaTableViewCellDelegate,RSSParserDelegate,UIAlertViewDelegate>
@property (nonatomic,weak) IBOutlet UITableView *noticiasTableView;
@property (nonatomic,strong) NSArray *noticias;
@property (nonatomic, strong) RSSParser *rssParser;
@end

@implementation ViewController
@synthesize noticiasTableView;
@synthesize noticias;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hiperactivo"]];
    self.navigationItem.titleView =logoImageView;
    [self cargar];
}

- (void)cargar
{
    if (_rssParser ==nil) {
        [[CargadorView sharedCargadorView] animaEnView:self.view];
        _rssParser = [[RSSParser alloc] init];
        [_rssParser setDelegate:self];
        [_rssParser iniciar];
    }
}

#pragma mark - RSSParserDelegate
- (void)rssParser:(RSSParser *)parser conDatos:(NSArray *)datos
{
    _rssParser = nil;
    [[CargadorView sharedCargadorView] animaOUT];
    noticias = [[NSArray alloc] initWithArray:datos];
    [noticiasTableView reloadData];
}

- (void)rssParser:(RSSParser *)parser conError:(NSError *)error
{
    _rssParser = nil;
    [[CargadorView sharedCargadorView] animaOUT];
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Atención"
                                                     message:error.localizedDescription
                                                    delegate:self
                                           cancelButtonTitle:@"Chao"
                                           otherButtonTitles:@"Intentar de nuevo", nil];
    [alerta setTag:1];
    [alerta show];
    DBLog(@"");
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex==1) {
            [self cargar];
        }
    }
}
#pragma mark - UITableViewCellDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBLog(@"%@",indexPath);
    NSDictionary *noticia = [noticias objectAtIndex:indexPath.row];
    [self irDetalle:noticia];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return noticias.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

#pragma mark - UITableViewDataDelegate
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NoticiaTableViewCell *celdaTableViewCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [celdaTableViewCell setDelegate:self];
    NSDictionary *noticia = [noticias objectAtIndex:indexPath.row];
    [celdaTableViewCell setMiIndexPath:indexPath];
    [celdaTableViewCell config:noticia];
    return celdaTableViewCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - NoticiaTableViewCellDelegate
- (void)noticiaTableViewCell:(NoticiaTableViewCell *)noticiaTableViewCell irDetalleConPath:(NSIndexPath*)path
{
    NSDictionary *noticia = [noticias objectAtIndex:path.row];
    [self irDetalle:noticia];
}
- (void)irDetalle:(NSDictionary*)info
{
    DetalleViewController *miDetalleViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetalleViewController"];
    [miDetalleViewController setInfo:info];
    [self.navigationController pushViewController:miDetalleViewController animated:YES];
}
@end
