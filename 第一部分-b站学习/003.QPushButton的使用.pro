#ifndef MYPUSHBUTTON_H
#define MYPUSHBUTTON_H

#include <QPushButton>

class MyPushButton : public QPushButton
{
    Q_OBJECT
public:
    explicit MyPushButton(QWidget *parent = nullptr);
  ~MyPushButton();

signals:


};

#endif // MYPUSHBUTTON_H

//widget.h

#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();
};
#endif // WIDGET_H

//widget资源文件
#include "widget.h"
#include <QPushButton>
#include<mypushbutton.h>
#include <debug/debug.h>
Widget::Widget(QWidget *parent)
    : QWidget(parent)
{
    QPushButton *btn = new QPushButton;
    btn->setParent(this);
    btn->setText("第一个按钮");

    QPushButton *btn2 =new QPushButton("第二个",this);
    resize(600,400); //编辑方框的大小
    btn2->move(110,220);
    setFixedSize(600,400); // 设置固定大小
  // btn2->resize(10,30);
   setWindowTitle("第一个文档");

   //创建一个自己的的按钮对象 --对象树的操作
   MyPushButton* myBtn = new MyPushButton;
   myBtn->setText("自己按钮");
   myBtn->move(100,0);
   myBtn->setParent(this); //设置到对象树中

   //信号发送     发送的信号              接受者     处理槽函数
   connect(myBtn,&QPushButton::clicked,this,&QWidget::close);
   //connect(btn,&QPushButton::clicked,this,&QWidget::setHidden);//自己玩
        // 定义的按钮
}

Widget::~Widget()
{
    qDebug("mywidget的析构作用");
}

//mypushbutton
#include "mypushbutton.h"
#include <debug/debug.h>
MyPushButton::MyPushButton(QWidget *parent) : QPushButton(parent)
{
    qDebug("我的按钮类构造调用");

}
MyPushButton::~MyPushButton()
{
    qDebug("按钮析构");
}

