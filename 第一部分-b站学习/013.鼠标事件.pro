//mylabel.h
#ifndef MYLABLE_H
#define MYLABLE_H

#include <QLabel>

class myLable : public QLabel
{
    Q_OBJECT
public:
    explicit myLable(QWidget *parent = nullptr);
    //进入
   void enterEvebt(QEvent *event);
   //离开
   void LeaveEvent(QEvent *);

   virtual void mouseMoveEvent(QMouseEvent *ev);
   virtual void mousePressEvent(QMouseEvent *ev);
   virtual void mouseReleaseEvent(QMouseEvent *ev);
signals:

};

#endif // MYLABLE_H

// .h
#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

  void timerEvent(QTimerEvent *ev);
  int id1;
  int id2;
  int stand = 6;
private:
    Ui::MainWindow *ui;
};
#endif // MAINWINDOW_H


//source文件
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QTimer>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
  id1 = startTimer(1000);//参数：设置间隔
  id2 = startTimer(3000);
  //定时器的第二种使用


  QTimer * timer = new  QTimer(this);

 timer->start(500);  //&QTimer::timeout 这个是信号
 connect(timer,&QTimer::timeout,[=](){
   static int num = 1; //使用静态的，这样可以每次不用重新计时了
    ui->label_4->setText(QString::number(num++));
 });

 connect(ui->btn,&QPushButton::clicked,[=]{
    timer->stop();
 });

 connect(ui->star,&QPushButton::clicked,[=]{
    timer->start();
 });

}

MainWindow::~MainWindow()
{
    delete ui;
}
void MainWindow::timerEvent(QTimerEvent *ev){
  if(ev->timerId() == id1){
    static int num=1;
    ui->label_2->setText(QString::number(num++));

  }


  if(ev->timerId() == id2){ //这个来区分走的标志
    static int num2=1;
    ui->label_3->setText(QString::number(num2++));
  }
}

//label source文件
#include "mylable.h"
#include <QDebug>
#include <QMouseEvent>
myLable::myLable(QWidget *parent) : QLabel(parent)
{
  setMouseTracking(true); //设置 鼠标追踪
}
//void myLable::enterEvebt(QEvent *event){
//    qDebug()<<"鼠标进去了";
//}
//void myLable::LeaveEvent(QEvent *){
//     qDebug()<<"鼠标离开了";
//}
void myLable::mouseMoveEvent(QMouseEvent *ev){
   QString str = QString("鼠标单击： x=%1 y=%2").arg(ev->x()).arg(ev->y());
    qDebug()<<str;//这个时候再后台打印的东西就应该是上边你所输入的那个函数了
}
void myLable::mousePressEvent(QMouseEvent *ev){
   //   QString str1 = QString("鼠标释放： x=%1 y=%2 globalx=%3").arg(ev->x()).arg(ev->y().arg(ev->globalX()));
  //  qDebug()<<str1;
    QString str = QString("鼠标释放了： x=%1 y=%2 globalx=%3").arg(ev->x()).arg(ev->y()).arg(ev->globalX());
     qDebug()<<str;
}
void myLable::mouseReleaseEvent(QMouseEvent *ev){
    qDebug()<<"鼠标离开了";
}


