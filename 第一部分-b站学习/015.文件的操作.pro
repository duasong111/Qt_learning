#include "widget.h"
#include "ui_widget.h"
#include <QFileDialog>
#include<QFile>
#include <QTextCodec>
#include <QFileInfo>
#include <QDebug>
#include <QDateTime>
Widget::Widget(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Widget)
{
    ui->setupUi(this);
    connect(ui->pushButton,&QPushButton::clicked,[=](){
        QString path = QFileDialog::getOpenFileName(this,"打开文件","C:\\Users\\admini\\Desktop\\C++");
   ui->lineEdit->setText(path); //将路径存到lineEdit->Text


   //编码格式的类  要先去判断格式然后在转码
   //QTextCodec * codec = QTextCodec::codecForName("")

   QFile file(path); //对这个文件来进行读取
   file.open(QIODevice::ReadOnly);//来进行文件的读取
   //QByteArray arry = file.readAll(); //file.readAll();全部读取  QByteArray arry是前边文件名
  //这个和上边的是一样只不过是换了一种形式而已
      QByteArray arry;
   while(!file.atEnd()){
        arry +=file.readLine();
   }



//   ui->textEdit->setText(arry);
//   file.close();
//   file.open(QIODevice::Append);
//   file.write("我不住地是啥"); //对文件的写入
//   file.close();


   QFileInfo info(path);
   qDebug()<<"大小"<<info.size()<<"后缀名"<<info.suffix();

 //   qDebug()<<"创建日期"<<info.created().toString("yyy/MM/dd hh:mm:ss");


    });
}

Widget::~Widget()
{
    delete ui;
}

