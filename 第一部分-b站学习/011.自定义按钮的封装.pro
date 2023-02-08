//mywidget.h
#ifndef MYWIDGET_H
#define MYWIDGET_H

#include <QWidget>

namespace Ui {
class Mywidget;
}

class Mywidget : public QWidget
{
    Q_OBJECT

public:
    explicit Mywidget(QWidget *parent = nullptr);
    ~Mywidget();
    void setNum(int num);

private:
    Ui::Mywidget *ui;
};

#endif // MYWIDGET_H

//widget头文件
#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>

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
};
#endif // WIDGET_H

//mywidget source
#include "mywidget.h"
#include "ui_mywidget.h"

Mywidget::Mywidget(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Mywidget)
{
    ui->setupUi(this);
    /* void(QSpinBox:: *spSingal)(int) = &QSpinBox::valueChanged;
    connect(ui->spinBox,spSingal,ui->horizontalSlider,&QSlider::setValue);*/
    void(QSpinBox:: *spSingal)(int) = &QSpinBox::valueChanged;
    connect(ui->spinBox,spSingal,ui->progressBar,&QProgressBar::setValue);
 //进度条这个没有进行自主拖拽的
  //  connect(ui->progressBar,&QProgressBar::valueChanged,ui->spinBox,&QSpinBox::setValue);
}

Mywidget::~Mywidget()
{
    delete ui;
}
void Mywidget::setNum(int num){
    ui->spinBox->setValue(num);
}

//widget
#include "widget.h"
#include "ui_widget.h"
#include <QDebug>
#include <iostream>
Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
    ui->setupUi(this);

    connect(ui->btn_num,&QPushButton::clicked,[=](){
        ui->widget->setNum(50);
    });
}

Widget::~Widget()
{
    delete ui;
}



