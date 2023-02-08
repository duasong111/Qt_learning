//头文件
#ifndef CHOOSELEVELSCENE_H
#define CHOOSELEVELSCENE_H

#include <QMainWindow>
#include "playscene.h"
class ChooseLevelscene : public QMainWindow
{
    Q_OBJECT
public:
    explicit ChooseLevelscene(QWidget *parent = nullptr);

    //重新绘图
    void paintEvent(QPaintEvent *);
    //游戏场景的进入
    PlayScene * play = NULL;

signals:
  //写一个自定义的信号
   void chooseSceneBack();
};

#endif // CHOOSELEVELSCENE_H

#ifndef DATACONFIG_H
#define DATACONFIG_H

#include <QObject>
#include <QMap>
#include <QVector>

class dataConfig : public QObject
{
    Q_OBJECT
public:
    explicit dataConfig(QObject *parent = 0);

public:

    QMap<int, QVector< QVector<int> > >mData;//双端数组 int 相当于关卡



signals:

public slots:
};

#endif // DATACONFIG_H

#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
//#include "chooselevelscene.h"
#include "chooselevelscene.h"

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
//绘制背景推片
    void paintEvent(QPaintEvent *);
    //创建新的场景
    ChooseLevelscene * chooseScene = NULL;

private:
    Ui::MainWindow *ui;
};
#endif // MAINWINDOW_H
#ifndef MYCOIN_H
#define MYCOIN_H


#include <QPushButton>
#include <QTimer>
class MyCoin : public QPushButton
{
    Q_OBJECT
public:
  //  explicit MyCoin(QWidget *parent = nullptr);

    MyCoin(QString btnImg);

  //金币的属性
    int posX; //x坐标位置
    int posY; //y的坐标位置
    bool  flag; //标记正反
//改变标志的方法
  void changeFlag();//不用传递值
  QTimer *timer1; //正面翻反面
  QTimer *timer2;//反面翻正面
  int min =1;
  int max =8;

  bool isAnimation = false;
  //重写 按下
  void mousePressEvent(QMouseEvent *e);
  //是否胜利标志
  bool isWin;

signals:

};

#endif // MYCOIN_H
#ifndef MYPUSHUBUTTON_H
#define MYPUSHUBUTTON_H

#include <QPushButton>

class MyPushuButton : public QPushButton
{
    Q_OBJECT
public:
    //explicit MyPushuButton(QWidget *parent = nullptr);
  //构造函数 参数1 显示图片的路径 参数2 按下显示图片的路径
    MyPushuButton(QString normalImg,QString pressImg = " ");
    //保证用户的使用
    QString normalImgPath;
    QString pressImgPath;

    void zoom1();
    void zoom2();

    //重写按键 和释放时间   选择关卡的点击特效
     void mousePressEvebt(QMouseEvent *e);
     void mouseReleaseEvent(QMouseEvent *e);

signals:

};

#endif // MYPUSHUBUTTON_H
#ifndef PLAYSCENE_H
#define PLAYSCENE_H

#include <QMainWindow>
#include"mycoin.h"
class PlayScene : public QMainWindow
{
    Q_OBJECT
public:
   // explicit PlayScene(QWidget *parent = nullptr);
  PlayScene(int levelNum);
  int levelIndex;

  //重写paintEvent事件
  void paintEvent(QPaintEvent *);

 int gameArray[4][4]; //二维数组，维护每关运行的数据

   MyCoin *coinBtn[4][4];
   //是否胜利的标志
   bool isWin;
signals:
   void chooseSceneBack();

};

#endif // PLAYSCENE_H



//资源文件的操作
#include "chooselevelscene.h"
#include <QMenuBar>
#include <QPainter>
#include <QPushButton>
#include <QDebug>
#include<QTimer>
#include <QLabel>
#include "mypushubutton.h"
ChooseLevelscene::ChooseLevelscene(QWidget *parent) : QMainWindow(parent)
{
    //来进行选择关卡大小
    this->setFixedSize(320,588);

    //设置图标
    this->setWindowIcon(QPixmap(":/new/prefix1/res/Coin0001.png"));
    //设置标题
    this->setWindowTitle("选择关卡");

    //创建一个菜单栏
   QMenuBar * bar=menuBar();
   setMenuBar(bar); //将菜单栏写入

  // bar->addMenu("开始");
 QMenu *startMenu = bar->addMenu("开始");

   QAction *quitAction = startMenu->addAction("退出");

   connect(quitAction,&QAction::triggered,[=](){
       this->close();


   });


   //返回按钮  ---关于按钮
       MyPushuButton * backBtn = new MyPushuButton(":/new/prefix1/res/BackButton.png",":/new/prefix1/res/BackButtonSelected.png");
      backBtn->setParent(this);
      backBtn->move(this->width() - backBtn->width(),this->height()- backBtn->height());

      //点击返回
      connect(backBtn,&MyPushuButton::clicked,[=](){
      //   qDebug()<<"返回键";

 //延时操作要记牢啊 老哥
          //延时返回
          QTimer::singleShot(500,this,[=](){
               //根据切换值后在返回回来，需要主场景去监听
                emit this->chooseSceneBack();

          });
      });

      //创建选择关卡的按钮
      for(int i=0;i<20;i++){
          MyPushuButton *menuBtn = new MyPushuButton(":/new/prefix1/res/LevelIcon.png");
          menuBtn->setParent(this);
           menuBtn->move(25+i%4*70,130+i/4*70);
           //利用这个一重循环来去将这些点分开



           //这个来进行选择关卡  ------ 但是要对之前编辑的按钮进行穿透
           //因为会阻挡 这个时候使用的是：label->setAttribute(Qt::WA_TransparentForMouseEvents);
           connect(menuBtn,&MyPushuButton::clicked,[=](){
              QString str = QString("您选择了第 %1关").arg(i+1);
               qDebug()<<str;

               //进入游戏
               this->hide(); //将关卡隐藏掉
               play  = new PlayScene(i+1);
               play->show();//显示游戏场景

               connect(play,&PlayScene::chooseSceneBack,[=](){

                   this->show();
                   delete play;
                   play = NULL;
               });

           });




           //鼠标穿透事件

              //换成QLabel * label = new QLabel(this);怎么样 效果一样
           QLabel * label = new QLabel;
           label->setParent(this);
      label->setFixedSize(menuBtn->width(),menuBtn->height());

      label->setText(QString::number(i+1));
      label->move(25+i%4*70,130+i/4*70);
      //将label这些东西来进行水平居中
      label->setAlignment(Qt::AlignHCenter|Qt::AlignVCenter);

      label->setAttribute(Qt::WA_TransparentForMouseEvents);
      }



}
void ChooseLevelscene::paintEvent(QPaintEvent *){
   //用来设置背景页面
    QPainter painter1(this);

    QPixmap pix; // 如果你的文件不加冒号也是加载不出来的
    pix.load(":/new/prefix1/res/OtherSceneBg.png");
  painter1.drawPixmap(0,0,this->width(),this->height(),pix);
// 绘画背景上的图标
  pix.load(":/new/prefix1/res/Title.png"); //固定文件的地址
  pix = pix.scaled(pix.width()*0.8,pix.height()*0.8);//修改文件大小
  painter1.drawPixmap(12,30,pix); //则是在背景上添加背景了




}

#include "dataconfig.h"
#include <QDebug>
#include <ctime>
dataConfig::dataConfig(QObject *parent) : QObject(parent)
{
    qsrand(time(NULL));
// 4 7


    //第一关
    int array1[4][4] = {{1, 0, 1, 1},
                        {0, 0, 1, 1},
                        {1, 1, 0, 0},
                        {1, 1, 0, 1}} ;
    //将数组插入容器中
    QVector< QVector<int>> v;
    for(int i = 0 ; i < 4;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 4;j++)
        {

            v1.push_back(array1[i][j]);
        }
        v.push_back(v1);
    }
    //插入到配置文件中
    mData.insert(1,v);




    //第二关

    int array2[4][4] = { {0, 1, 0, 1},
                         {1, 0, 0, 0},
                         {1, 0, 0, 0},
                         {0, 1, 0, 1}} ;

    v.clear();
    for(int i = 0 ; i < 4;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 4;j++)
        {
            v1.push_back(array2[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(2,v);



    int array3[4][4] = {  {1, 0, 1, 1},
                          {1, 1, 0, 0},
                          {0, 0, 1, 1},
                          {1, 1, 0, 1}} ;
    v.clear();
    for(int i = 0 ; i < 4;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 4;j++)
        {
            v1.push_back(array3[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(3,v);


    int array4[4][4] = {   {0, 1, 1, 1},
                           {1, 1, 0, 1},
                           {1, 0, 1, 1},
                           {1, 1, 1, 0}} ;
    v.clear();
    for(int i = 0 ; i < 4;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 4;j++)
        {
            v1.push_back(array4[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(4,v);


    int array5[4][4] = {  {1, 0, 0, 1},
                          {0, 0, 0, 0},
                          {0, 0, 0, 0},
                          {1, 0, 0, 1}} ;
    v.clear();
    for(int i = 0 ; i < 4;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 4;j++)
        {
            v1.push_back(array5[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(5,v);


    int array6[4][4] = {   {1, 0, 0, 1},
                           {0, 1, 1, 0},
                           {0, 1, 1, 0},
                           {1, 0, 0, 1}} ;
    v.clear();
    for(int i = 0 ; i < 4;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 4;j++)
        {
            v1.push_back(array6[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(6,v);


    int array7[4][4] = {   {0, 1, 1, 0},
                           {0, 0, 0, 0},
                           {0, 0, 0, 0},
                           {0, 1, 1, 0}} ;
    v.clear();
    for(int i = 0 ; i < 4;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 4;j++)
        {
            v1.push_back(array7[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(7,v);

    int array8[4][4] = {      {0, 1, 1, 0},
                              {1, 1, 1, 1},
                              {1, 1, 1, 1},
                              {0, 1, 1, 0}} ;
    v.clear();
    for(int i = 0 ; i < 4;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 4;j++)
        {
            v1.push_back(array8[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(8,v);


    int array9[4][4] = {      {0, 0, 0, 0},
                              {0, 0, 0, 0},
                              {0, 0, 0, 0},
                              {0, 0, 0, 0} };
    v.clear();
    for(int i = 0 ; i < 4;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 4;j++)
        {
            v1.push_back(array9[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(9,v);
    //===============10随机关==================//
    v.clear();

    int num=0;
    int sum=0;
    for(int i = 0 ; i < 4;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 4;j++)
        {
            num=qrand()%2;
            v1.push_back(num);
            if(num==1){
                sum++;
            }
        }
        v.push_back(v1);
    }

    //还需要设置成偶数个，奇数个不行，可以利用vector的性质来做
    int changedValue=*v.begin()->begin();//改变第一个

    if((sum&1)!=0){
        //如果为奇数，则改变第一个
        if(changedValue==0){
            *v.begin()->begin()=1;
        }
        else{
            *v.begin()->begin()=0;
        }
    }
    mData.insert(10,v);

    //=================11-15 5个格子=======================


    int array11[5][5] = {  {0, 0, 0, 0, 0},
                           {0, 1, 0, 1, 0},
                           {0, 0, 1, 0, 0},
                           {0, 1, 0, 1, 0},
                           {0, 0, 0, 0, 0}};
    v.clear();
    for(int i = 0 ; i < 5;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 5;j++)
        {
            v1.push_back(array11[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(11,v);

    int array12[5][5] = {  {0, 0, 0, 1, 0},
                           {1, 0, 1, 1, 1},
                           {1, 0, 1, 1, 0},
                           {1, 0, 1, 1, 1},
                           {0, 0, 0, 1, 0}};
    v.clear();
    for(int i = 0 ; i < 5;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 5;j++)
        {
            v1.push_back(array12[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(12,v);


    int array13[5][5] = {  {1, 1, 1, 0, 0},
                           {0, 1, 0, 0, 0},
                           {0, 1, 1, 1, 1},
                           {0, 1, 0, 0, 1},
                           {1, 1, 1, 0, 1}};
    v.clear();
    for(int i = 0 ; i < 5;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 5;j++)
        {
            v1.push_back(array13[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(13,v);

    int array14[5][5] = {  {1, 1, 1, 1, 1},
                           {1, 0, 0, 0, 0},
                           {1, 0, 0, 0, 0},
                           {1, 0, 1, 1, 1},
                           {1, 0, 1, 1, 1}};
    v.clear();
    for(int i = 0 ; i < 5;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 5;j++)
        {
            v1.push_back(array14[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(14,v);


    //===============15随机关==================//
    v.clear();

    int num1=0;
    int sum1=0;
    for(int i = 0 ; i < 5;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 5;j++)
        {
            num1=qrand()%2;
            v1.push_back(num1);
            if(num1==1){
                sum1++;
            }
        }
        v.push_back(v1);
    }

    //还需要设置成偶数个，奇数个不行，可以利用vector的性质来做
    int changedValue1=v[3][3];//改变中间那个

    if((sum1&1)!=0){
        //如果为奇数，则改变中间一个
        if(changedValue1==0){
            v[3][3]=1;
        }
        else{
            v[3][3]=0;
        }
    }
    mData.insert(15,v);


    //================6*6===================//


//    int array16[6][6] = { {1, 1, 1, 1, 1, 1},
//                          {1, 1, 1, 1, 1, 1},
//                          {1, 1, 1, 0, 1, 1},
//                          {1, 1, 0, 0, 0, 1},
//                          {1, 1, 1, 0, 1, 1},
//                          {1, 1, 1, 1, 1, 1} };


    int array16[6][6] = { {0, 0, 0, 0, 0, 0},
                          {0, 1, 1, 1, 1, 0},
                          {0, 1, 1, 1, 1, 0},
                          {0, 1, 1, 1, 1, 0},
                          {0, 1, 1, 1, 1, 0},
                          {0, 0, 0, 0, 0, 0} };
    v.clear();
    for(int i = 0 ; i < 6;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 6;j++)
        {
            v1.push_back(array16[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(16,v);

    int array17[6][6] = {  {1, 1, 0, 0, 0, 0},
                           {1, 1, 0, 0, 0, 1},
                           {1, 1, 0, 0, 0, 0},
                           {1, 1, 0, 0, 0, 0},
                           {1, 1, 0, 0, 0, 1},
                           {1, 1, 0, 0, 0, 0} };
    v.clear();
    for(int i = 0 ; i < 6;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 6;j++)
        {
            v1.push_back(array17[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(17,v);


    int array18[6][6] = {  {0, 0, 0, 0, 0, 1},
                           {0, 0, 1, 0, 0, 0},
                           {0, 1, 1, 0, 0, 0},
                           {1, 0, 0, 1, 1, 0},
                           {1, 1, 0, 1, 0, 0},
                           {1, 1, 1, 0, 0, 0} };
    v.clear();
    for(int i = 0 ; i < 6;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 6;j++)
        {
            v1.push_back(array18[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(18,v);

    int array19[6][6] = {  {0, 0, 0, 0, 0, 0},
                           {1, 0, 0, 0, 0, 0},
                           {0, 0, 0, 0, 0, 0},
                           {0, 0, 0, 0, 0, 0},
                           {0, 0, 0, 0, 0, 0},
                           {0, 0, 0, 0, 0, 0} };
    v.clear();
    for(int i = 0 ; i < 6;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 6;j++)
        {
            v1.push_back(array19[i][j]);
        }
        v.push_back(v1);
    }

    mData.insert(19,v);

    //===============20随机关==================//
    v.clear();

    int num2=0;
    int sum2=0;
    for(int i = 0 ; i < 6;i++)
    {
        QVector<int>v1;
        for(int j = 0 ; j < 6;j++)
        {
            num2=qrand()%2;
            v1.push_back(num2);
            if(num2==1){
                sum2++;
            }
        }
        v.push_back(v1);
    }

    //还需要设置成偶数个，奇数个不行，可以利用vector的性质来做
    int changedValue2=v[4][4];//改变中间那个

    if((sum2&1)!=0){
        //如果为奇数，则改变中间一个
        if(changedValue2==0){
            v[4][4]=1;
        }
        else{
            v[4][4]=0;
        }
    }
    mData.insert(20,v);
    //===================额外测试关卡========================//


    //测试数据
    //    for( QMap<int, QVector< QVector<int> > >::iterator it = mData.begin();it != mData.end();it++ )
    //    {
    //         for(QVector< QVector<int> >::iterator it2 = (*it).begin(); it2!= (*it).end();it2++)
    //         {
    //            for(QVector<int>::iterator it3 = (*it2).begin(); it3 != (*it2).end(); it3++ )
    //            {
    //                qDebug() << *it3 ;
    //            }
    //         }
    //         qDebug() << endl;
    //    }


}
//mian source
#include "mainwindow.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();

    return a.exec();
}

#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QPainter>
#include <QPushButton>
#include "mypushubutton.h"
#include <QDebug>
#include <QTimer>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    //配置场景


    //设置固定大小
    setFixedSize(320,588);

    //设置图标             //要把文件的全部的路径都加上
    setWindowIcon(QIcon(":/new/prefix1/res/Coin0001.png"));
    //设置翻金币
    setWindowTitle("翻金币的场景");

    //实现退出
    connect(ui->action,&QAction::triggered,[=](){
        this->close();
    });
  //开始按钮  ---- 因为前边的类文件的名字打错了多了一个则是 MyPushuButton
    MyPushuButton * startBtn = new MyPushuButton(":/new/prefix1/res/MenuSceneStartButton.png");
   startBtn->setParent(this);
   startBtn->move(this->width() * 0.5 - startBtn->width()*0.5,this->height()*0.7);


   chooseScene = new ChooseLevelscene;  //创建选择关卡


   //监听选择对象的信号
   connect(chooseScene,&ChooseLevelscene::chooseSceneBack,[=](){
     chooseScene->hide();
       this->show();
   }); //只做一次连接就行了


//封装这个有弹起的操作
   connect(startBtn,&MyPushuButton::clicked,[=](){
     // qDebug()<<"点击开始";

      startBtn->zoom1();  //点击后就会往下弹
      startBtn->zoom2();  //回弹

    //添加延时进入
      QTimer::singleShot(500,this,[=](){
          //进入选择关卡
          this->hide();
          chooseScene->show();



      });



   });

}
void MainWindow::paintEvent(QPaintEvent *){ //图片要在自定义函数中进行
    QPainter painter(this);

    QPixmap pix; // 如果你的文件不加冒号也是加载不出来的
    pix.load(":/new/prefix1/res/PlayLevelSceneBg.png");
  painter.drawPixmap(0,0,this->width(),this->height(),pix);
 //绘画背景上的图标
  pix.load(":/new/prefix1/res/Title.png"); //固定文件的地址
  pix = pix.scaled(pix.width(),pix.height());//修改文件大小
  painter.drawPixmap(12,30,pix); //则是在背景上添加背景了


}
MainWindow::~MainWindow()
{
    delete ui;
}

#include "mycoin.h"
#include <QDebug>
//MyCoin::MyCoin(QWidget *parent) : QPushButton(parent)
//{

//}
MyCoin::MyCoin(QString btnImg){
    QPixmap pix;
    bool ret = pix.load(btnImg);
    if(!ret){
        QString str=QString("图片 %1 加载失败");
        qDebug()<<str;
        return ;
    }
    this->setFixedSize(pix.width(),pix.height());
    this->setStyleSheet("QPushButton{border:0px}");
    this->setIcon(pix);
    this->setIconSize(QSize(pix.width(),pix.height()));

    //初始化定时器
    timer1 = new QTimer(this);
    timer2 = new QTimer(this);

    //间隔30ms来翻转金币 ,监听正面翻反面的信号
    connect(timer1,&QTimer::timeout,[=](){
        QPixmap pix;
        QString str = QString(":/new/prefix1/res/Coin000%1").arg(this->min++);
        pix.load(str);

        this->setFixedSize(pix.width(),pix.height());
        this->setStyleSheet("QPushButton{border:0px}");
        this->setIcon(pix);
        this->setIconSize(QSize(pix.width(),pix.height()));
        //如果翻转完了，将min重置1
        if(this->min>this->max){
            this->min=1;
            isAnimation = false;
            timer1->stop();
        }
    });
     //监听的是反面翻正面
    connect(timer2,&QTimer::timeout,[=](){
        QPixmap pix;
        QString str = QString(":/new/prefix1/res/Coin000%1").arg(this->max--);
        pix.load(str);

        this->setFixedSize(pix.width(),pix.height());
        this->setStyleSheet("QPushButton{border:0px}");
        this->setIcon(pix);
        this->setIconSize(QSize(pix.width(),pix.height()));
        //如果翻转完了，将min重置1
       // if(this->min>this->max){
        if(this->max<this->min){
            this->max=8;
            isAnimation = false;
            timer2->stop(); //要是不改这个就会一直转圈的
        }
    });

}
void MyCoin::mousePressEvent(QMouseEvent *e){
    if(this->isAnimation || this->isWin){//|| this->isWin
        return;
    }
    else{
        QPushButton::mousePressEvent(e);
    }

}
//改变正反面的标志
void MyCoin::changeFlag(){
    //如果是正面则翻成反面
    if(this->flag){
        timer1->start(30); //时间30ms
       isAnimation = true; //开始做动画了
        this->flag = false;
    }else{
        timer2->start(30); //时间30ms
        isAnimation = true;
        this->flag = true;
    }
}


//按钮
#include "mypushubutton.h"
#include <QDebug>
#include <QPropertyAnimation>
//MyPushuButton::MyPushuButton(QWidget *parent) : QPushButton(parent)
//{

//}
MyPushuButton::MyPushuButton(QString normalImg,QString pressImg){
 this->normalImgPath = normalImg;
 this->pressImgPath = pressImg;
    QPixmap pix;
    bool ret = pix.load(normalImg);
    if(!ret){
        qDebug()<<"图片加载失败";
        return ;
    }
    //设置图片的固定大小
    this->setFixedSize(pix.width(),pix.height());
    //设置不规则图片的样式
    //如果这个不规则样式不设置的话会出现的情况是有一个正方形的框框
    this->setStyleSheet("QPushButton{border:0px;}");
    //设置图标                      //注意样式和那个括号以及分号
    this->setIcon(pix); //因为前边的将iron带入了
    //设置图标的大小
    this->setIconSize(QSize(pix.width(),pix.height()));

}
void MyPushuButton::zoom1(){  //弹跳
    //创建动画特效
    QPropertyAnimation * animation = new QPropertyAnimation(this,"geometry");
   //设置时间间隔
    animation->setDuration(200);
    //起始位置
    animation->setStartValue(QRect(this->x(),this->y(),this->width(),this->height()));
    //结束位置
    animation->setEndValue(QRect(this->x(),this->y()+10,this->width(),this->height()));

  //设置弹跳曲线
    animation->setEasingCurve(QEasingCurve::OutBounce);

    animation->start();

}
void MyPushuButton::zoom2(){
    //创建动画特效
    QPropertyAnimation * animation = new QPropertyAnimation(this,"geometry");
   //设置时间间隔
    animation->setDuration(200);
    //起始位置
    animation->setStartValue(QRect(this->x(),this->y()+10,this->width(),this->height()));
    //结束位置
    animation->setEndValue(QRect(this->x(),this->y(),this->width(),this->height()));

  //设置弹跳曲线
    animation->setEasingCurve(QEasingCurve::OutBounce);

    animation->start();

}
void MyPushuButton::mousePressEvebt(QMouseEvent *e){
    if(this->pressImgPath !=""){//需要去切换图片
        QPixmap pix;
        bool ret = pix.load(this->pressImgPath);
        if(!ret){
            qDebug()<<"图片加载失败";
            return ;
        }
        //设置图片的固定大小
        this->setFixedSize(pix.width(),pix.height());
        //设置不规则图片的样式
        //如果这个不规则样式不设置的话会出现的情况是有一个正方形的框框
        this->setStyleSheet("QPushButton{border:0px;}");
        //设置图标                      //注意样式和那个括号以及分号
        this->setIcon(pix); //因为前边的将iron带入了
        //设置图标的大小
        this->setIconSize(QSize(pix.width(),pix.height()));

    }
    //交给父类来执行其他的内容
    return QPushButton::mousePressEvent(e);

}

void MyPushuButton::mouseReleaseEvent(QMouseEvent *e){


    if(this->pressImgPath !=""){//需要去切换图片
        QPixmap pix;
        bool ret = pix.load(this->normalImgPath);
        if(!ret){
            qDebug()<<"图片加载失败";
            return ;
        }
        //设置图片的固定大小
        this->setFixedSize(pix.width(),pix.height());
        //设置不规则图片的样式
        //如果这个不规则样式不设置的话会出现的情况是有一个正方形的框框
        this->setStyleSheet("QPushButton{border:0px;}");
        //设置图标                      //注意样式和那个括号以及分号
        this->setIcon(pix); //因为前边的将iron带入了
        //设置图标的大小
        this->setIconSize(QSize(pix.width(),pix.height()));

    }
    //交给父类来执行其他的内容
    return QPushButton::mouseReleaseEvent(e);
}

//进行操作的页面
#include "playscene.h"
#include <QDebug>
#include <QMenuBar>
#include <QPainter>
#include <QTimer>
#include<QLabel>
#include "mypushubutton.h"
#include "mycoin.h"
#include "dataconfig.h"
#include <QPropertyAnimation>
//PlayScene::PlayScene(QWidget *parent) : QMainWindow(parent)
//{

//}
PlayScene::PlayScene(int levelNum)
{
    QString str = QString("进入了第 %1关").arg(levelNum);

    qDebug()<<str;
    this->levelIndex = levelNum;

    //初始化场景
    this->setFixedSize(300,588);
    //设置图标
     this->setWindowIcon(QPixmap(":/new/prefix1/res/Coin0001.png"));
    //设置标题
    this->setWindowTitle("翻金币场景");


    QMenuBar * bar=menuBar();
    setMenuBar(bar); //将菜单栏写入

   // bar->addMenu("开始");
  QMenu *startMenu = bar->addMenu("开始");

    QAction *quitAction = startMenu->addAction("退出");

    connect(quitAction,&QAction::triggered,[=](){
        this->close();


    });
    //返回按钮

    //返回按钮  ---关于按钮
        MyPushuButton * backBtn = new MyPushuButton(":/new/prefix1/res/BackButton.png",":/new/prefix1/res/BackButtonSelected.png");
       backBtn->setParent(this);
       backBtn->move(this->width() - backBtn->width(),this->height()- backBtn->height());

       //点击返回
       connect(backBtn,&MyPushuButton::clicked,[=](){
         qDebug()<<"翻金币的返回";

  //延时操作要记牢啊 老哥
           //延时返回
           QTimer::singleShot(500,this,[=](){
                //根据切换值后在返回回来，需要主场景去监听
                 emit this->chooseSceneBack();

           });
       });

       //显示当前的关
       QLabel * label = new QLabel;
       label->setParent(this);
       QFont font;
       font.setFamily("华文新魏"); //字体的格式
       font.setPointSize(20); //设置字体的大小
       QString str1 = QString("Level: %1").arg(this->levelIndex);
       //将字体设置 进去
      label->setFont(font);
       label->setText(str1);
       label->setGeometry(30,this->height()-50,120,50);
      // label ->move(500,100);


       dataConfig config;
       //初始化每关的二维数组

       for(int i=0;i<4;i++){
           for(int j=0;j<4;j++){
               this->gameArray[i][j]=config.mData[this->levelIndex][i][j];
               }
           }
//胜利图片的显示
//       QLabel * winLabel = new QLabel;
//       QPixmap tmpPix;
//       tmpPix.load(":/new/prefix1/res/LevelCompletedDialogBg.png");
//       winLabel->setGeometry(0,0,tmpPix.width(),tmpPix.height());
//       winLabel->setPixmap(tmpPix);
//       winLabel->setParent(this);
//       winLabel->move((this->width()-tmpPix.width())*0.5,-tmpPix.height());




       //显示金币的背景图
       for(int i=0;i<4;i++){
           for(int j=0;j<4;j++){
               //绘制图片
               QPixmap pix = QPixmap(":/new/prefix1/res/BoardNode.png");
               QLabel * label = new QLabel;
               label->setGeometry(0,0,pix.width(),pix.height()); //方便修改
               label->setPixmap(pix);
               label->setParent(this);
               label->move(57+i*50,200+j*50);



               //创建金币
               QString str;
               if(this->gameArray[i][j]==1){
                   str =":/new/prefix1/res/Coin0001.png";
                   //是 1 则是金币
               }else{
                   str=":/new/prefix1/res/Coin0008.png";
                   //是 0 则是金币
               }
               MyCoin *coin = new MyCoin(str);
               coin->setParent(this);
               coin->move(59+i*50,204+j*50);

               //给金币的属性赋值
               coin->posX = i;
               coin->posY = j;
               coin->flag = this->gameArray[i][j];//1 正 0 反

               //将金币放入二维数组中 以便于后期的维护
               coinBtn[i][j] = coin;

               //点击金币 进行翻转
               connect(coin,&MyCoin::clicked,[=](){
                   coin->changeFlag();
                   this->gameArray[i][j] = this->gameArray[i][j]== 0 ? 1: 0;
               //上边的那个是翻硬币的时候改变数值


                   QTimer::singleShot(300,this,[=](){
                       //翻转周围的金币   //延时翻转
                       if(coin->posX +1<=3){//右侧的都单转
                           coinBtn[coin->posX+1][coin->posY]->changeFlag();
                           this->gameArray[coin->posX+1][coin->posY]= this->gameArray[coin->posX+1][coin->posY]== 0 ? 1: 0;
                       }
                       //周围的左侧硬币进行翻转

                       if(coin->posX -1>=0){
                           coinBtn[coin->posX-1][coin->posY]->changeFlag();
                           this->gameArray[coin->posX-1][coin->posY]= this->gameArray[coin->posX-1][coin->posY]== 0 ? 1: 0;
                       }
                       if(coin->posY +1<=3){//上侧的都单转
                           coinBtn[coin->posX][coin->posY+1]->changeFlag();
                           this->gameArray[coin->posX][coin->posY+1]= this->gameArray[coin->posX][coin->posY+1]== 0 ? 1: 0;
                       }

                       //周围的下侧硬币进行翻转
                       if(coin->posY -1>=0){
                           coinBtn[coin->posX][coin->posY-1]->changeFlag();
                           this->gameArray[coin->posX][coin->posY-1]= this->gameArray[coin->posX][coin->posY-1]== 0 ? 1: 0;
                       }




                       //判断是否翻完
                       this->isWin = true;
                       for(int i=0;i<4;i++){
                           for(int j=0;j<4;j++){
                               if(coinBtn[i][j]->flag==false){
                                   this->isWin = false;
                                   break;
                               }
                           }
                       }
                       if(this->isWin == true){
                           //胜利了
                           qDebug()<<"胜利了";
                         //  将所有的按钮都改为true
//                           for(int i=0;i<4;i++){
//                               for(int j=0;j<4;j++){
//                                   coinBtn[i][j]->isWin= true;
//                                   }
//                               }

                           //将胜利图片下来
//                           QPropertyAnimation *animation = new QPropertyAnimation(winLabel,"geometry");
//                      //设置时间间隔
//                           animation->setDuration(1000);
//                           animation->setStartValue(QRect(winLabel->x(),winLabel->y(),winLabel->width(),winLabel->height()));
//                       //设置结束位置
//                          animation->setEndValue(QRect(winLabel->x(),winLabel->y()+114,winLabel->width(),winLabel->height()));
//                       //设置缓和曲线
//                          animation->setEasingCurve(QEasingCurve::OutBounce);
//                          //执行动画
//                          animation->start();

                       }

                   });
               });
           }
       }
}
void PlayScene::paintEvent(QPaintEvent *){
    QPainter painter(this);

    QPixmap pix; // 如果你的文件不加冒号也是加载不出来的
    pix.load(":/new/prefix1/res/PlayLevelSceneBg.png");
  painter.drawPixmap(0,0,this->width(),this->height(),pix);
 //绘画背景上的图标
  pix.load(":/new/prefix1/res/Title.png"); //固定文件的地址
  pix = pix.scaled(pix.width()*0.7,pix.height()*0.7);//修改文件大小
  painter.drawPixmap(12,30,pix); //则是在背景上添加背景

}







