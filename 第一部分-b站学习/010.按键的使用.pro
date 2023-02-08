#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>
#include <QMessageBox>
#include <QListWidgetItem>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this); //设置默认值
    ui->radioButton_3->setChecked(true);

    connect(ui->radioButton_4,&QPushButton::clicked,[=](){
        qDebug()<<"选了女性";
       QMessageBox::warning(this,"警告","出现错误");
    });
    connect(ui->checkBox_4,&QCheckBox::clicked,[=](int state){
       // QMessageBox::accept(this,"re","hh");
         qDebug()<<state;
    });
    QListWidgetItem * item = new QListWidgetItem("哈哈哈哈哈");

    //  ui->listWidget->addItem(item);

    //设置水平头
    ui->treeWidget->

};

MainWindow::~MainWindow()
{
    delete ui;
}

