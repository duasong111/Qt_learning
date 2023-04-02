
#include "dialog.h"
#include <QWidget>
#include <QApplication>
#include<QPushButton.h>
#include <QLabel>
#include <QDebug>
#include <QDialog>
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    Dialog w;
//    w.resize(400,300);
//    QLabel label(&w); //这个标签取那个显示的地址
//    label.setText("hello word");
    //w.show();

    //设置断点
    QWidget widget;
//    widget.setWindowTitle(QObject::tr("进行断点操作")); //没有用到指针
//    widget.resize(400,300);
//    widget.move(200,100);  //其实这个值是传入到x y本来xy就是坐标
//    int x = widget.x();    //rect这里是指矩形
//    qDebug("x: %d",x); //进行数据的输入
//    //利用QDebug来进行数据的输入
//    int y = widget.y();
//    qDebug("y: %d",y);
//    QRect geometry = widget.geometry(); //没有边框
//    QRect frame = widget.frameGeometry(); //包含边框的的窗口框架和举行的数值
   // widget.show();
//    qDebug()<<"geometry:"<<geometry<<"frame"<<frame;
//    return a.exec();
}
