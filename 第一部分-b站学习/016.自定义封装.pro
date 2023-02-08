//头文件 1
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

private:
    Ui::MainWindow *ui;
};
#endif // MAINWINDOW_H


//插入类的头文件


#ifndef SMALLWIDGET_H
#define SMALLWIDGET_H

#include <QWidget>

namespace Ui {
class SmallWidget;
}

class SmallWidget : public QWidget
{
    Q_OBJECT

public:
    explicit SmallWidget(QWidget *parent = nullptr);
    ~SmallWidget();
   void setNum(int num);
   int getNum();

private:
    Ui::SmallWidget *ui;
};

#endif // SMALLWIDGET_H


//smallWidget 资源文件
#include "smallwidget.h"
#include "ui_smallwidget.h"

SmallWidget::SmallWidget(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::SmallWidget)
{
    ui->setupUi(this); //避免重载
    void(QSpinBox:: *spSingal)(int) = &QSpinBox::valueChanged;
    connect(ui->spinBox,spSingal,ui->horizontalSlider,&QSlider::setValue);
 //Qlider Qspinbox跟着回应

    connect(ui->horizontalSlider,&QSlider::valueChanged,ui->spinBox,&QSpinBox::setValue);
 //这两个是使互相之间是有联系的
}

void SmallWidget::setNum(int num){
     ui->spinBox->setValue(num);
}
int SmallWidget::getNum(){
    return ui->spinBox->value();
}
SmallWidget::~SmallWidget()
{
    delete ui;
}

//mainwindow
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    //点击获取连接起来
    connect(ui->get_Num,&QPushButton::clicked,[=](){
        qDebug()<<ui->widget->getNum();
    });
   connect(ui->set_Num,&QPushButton::clicked,[=](){
        ui->widget->setNum(50);
      // qDebug()<<ui->widget->setNum('30');
    }); //设置一个


}

MainWindow::~MainWindow()
{
    delete ui;
}


