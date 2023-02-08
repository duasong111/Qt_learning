//

//source文件
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include<QDialog>
#include <QDebug>
#include <QMessageBox>
#include <QColorDialog>
#include <QFileDialog>
#include <QFontDialog>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    connect(ui->actionnew_2,&QAction::triggered,[=](){
        //模态 （不可以更改    非模态 可以更改
//        QDialog dig(this);
//        dig.resize(500,300);
//        dig.exec(); //main.cpp中的一样
//        qDebug()<<"模态换弹出";


//        QDialog * dig2 = new QDialog(this);
//        dig2->resize(300,100);//大小
//        dig2->setAttribute(Qt::WA_DeleteOnClose);//属性
//        dig2->show();
//        qDebug()<<"非模态对话框";



//     QMessageBox::critical(this,"critical","错误");
//    //   其实后边的可以改变的
//     //                参数 父亲  参数     标题 参数3 参数4
//  if(QMessageBox::Save==   QMessageBox::question(this,"ques","tiwen",QMessageBox::Save|QMessageBox::Cancel))

//  {
//      qDebug()<<"用户选择是保存";
//  }
// else{
//  qDebug()<<"用户是取消";
//  }
 //记得看文档然后知道其类型
  //QMessageBox::warning(this,"警告","出现错误");


   // 颜色
    //    QColor * color = new QColorDialog(this);

        // 文件对话框 参数 父亲 参数2 标题 参数3 默认路径 参数4 过滤文件格式
//      QString str =  QFileDialog::getOpenFileName(this,"打开文件","C:\\Users\\admini\\Desktop\\C++");
//     qDebug()<<str;


//        bool flag;
//    QFont font =    QFontDialog::getFont(&flag,QFont("华文彩云",24));
//   qDebug()<<"字体"<<font.family().toUtf8().data()<<"字号"<<font.pointSize()<<"是否倾斜"<<font.italic()<<"是否加粗"<<font.bold();
    });
 //为啥有的要返回值有的不要返回值呢？
   //是因为看你是否对那个返回的来进行操作
}

MainWindow::~MainWindow()
{
    delete ui;
}

