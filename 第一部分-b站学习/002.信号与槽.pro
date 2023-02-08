//这里是头文件部分
ifndef STUDENT_H
#define STUDENT_H

#include <QObject>

class Student : public QObject
{
    Q_OBJECT
public:
    explicit Student(QObject *parent = nullptr);

signals:

public slots: //要实现必须有槽
    // 声明和实现
  void treat();
  void treat(QString foodName);

};

#endif // STUDENT_H

//teacher.h
#ifndef TEACHER_H
#define TEACHER_H

#include <QObject>

class Teacher : public QObject
{
    Q_OBJECT
public:
    explicit Teacher(QObject *parent = nullptr);

signals:
   //自定义写到这
    //返回这是void 只要声明就行
    //有参数 可以重载
    void hungry();  //在这来定义函数

    void hungry(QString foodName);
};

#endif // TEACHER_H
widget.h
#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include "teacher.h"
#include "student.h"

QT_BEGIN_NAMESPACE
namespace Ui { class Widget; }
QT_END_NAMESPACE

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();

private:
    Ui::Widget *ui;

    Teacher * zt;  //函数定义变量
    Student * st;

    void classIsOver();
    //要在widget定义函数也要在此处声明
};
#endif // WIDGET_H

//资源文件
#include "student.h"
#include <QDebug>
Student::Student(QObject *parent) : QObject(parent)
{

}

void Student::treat(){
    qDebug("吃饭");
}
void Student::treat(QString foodName){
    //转换to.Utf8
    qDebug()<<("老师吃:")<<foodName.toUtf8().data();
}


#include "teacher.h"

Teacher::Teacher(QObject *parent) : QObject(parent)
{

}

#include "widget.h"
#include "ui_widget.h"
#include <QDebug>
#include <QPushButton>
// Teacher

Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
    ui->setupUi(this);

    //创建老师和学生的对象
    this->zt = new Teacher(this);
    this->st = new Student(this);

   // connect(zt,&Teacher::hungry,st,&Student::treat);
  //classIsOver();

    //这段是避免重载的使用
    //使用指针来代替，避免重载不能识别
//    void(Teacher::*teacherSignal)(QString)= &Teacher::hungry;
//    void(Student::*studentSolt)(QString)= &Student::treat;
//    connect(zt,teacherSignal,st,studentSolt);
//  classIsOver();

 QPushButton *btn2 = new QPushButton("下课",this);

  this->resize(600,400);
//  connect(btn2,&QPushButton::clicked,this,&Widget::classIsOver);
  //下课的按钮

  void(Teacher::*teacherSignal2)(void)= &Teacher::hungry;
  void(Student::*studentSolt2)(void)= &Student::treat;
  connect(zt,teacherSignal2,st,studentSolt2);
 classIsOver();
  // 信号的连接
connect(btn2,&QPushButton::clicked,zt,teacherSignal2);

//[=](){
 // btn2->setText("aaaa");
//}();
  // lambad表达式
//    int ret=[]()->int{return 100;}();
//    qDebug()<<"ret ="<<ret;

//    QPushButton *btn3 = new QPushButton;
//    btn3->setText("关闭");
//    btn3->parent(this);
//    btn3->move(100,1);
//    connect(btn3,&QPushButton::clicked,this,[](){
//      //  this->close();
//        emit zt->hungry("鸡丁");
//    });


}

void Widget::classIsOver()
{
 //emit zt->hungry();
    emit zt->hungry("鸡丁");
}

Widget::~Widget()
{
    delete ui;
}

//将main.cpp省略了反正都一样


