#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>

QT_BEGIN_NAMESPACE
namespace Ui { class Dialog; }
QT_END_NAMESPACE

class Dialog : public QDialog
{
    Q_OBJECT

public:
    Dialog(QWidget *parent = nullptr);
    ~Dialog();
    //绘图事件
    void paintEvent(QPaintEvent *);

private:
    Ui::Dialog *ui;
};
#endif // DIALOG_H

//资源文件
#include "dialog.h"
#include "ui_dialog.h"
#include <QPainter>
Dialog::Dialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::Dialog)
{
    ui->setupUi(this);
}

void Dialog::paintEvent(QPaintEvent *){



    //想画画就要记得写QPainter
    //记得要声明画画的就是下边的那个  QPainter painter(this);

    //可以设置画笔

   // 实例画家对象
//    QPainter painter(this); //指定当前绘图设备

//    //设置画笔
//    QPen pen(QColor(255,2,2)); //设置一个画笔
//    pen.setWidth(3);
//    pen.setStyle(Qt::DashLine);//设置的风格

//    painter.setPen(pen); //让画家 使用这个笔  *笔的颜色在画图前

// //设置画刷
//    QBrush brush(Qt::cyan);
//    painter.setBrush(brush);

//    painter.drawLine(QPoint(0,0),QPoint(100,100));
//    //这个是系统自动划线
//    //画图                 圆心         半径 x y
//    painter.drawEllipse(QPoint(100,100),100,50);
//    painter.drawRect(QRect(20,20,50,50));

//    //话文字

//    painter.drawText(QRect(10,200,150,100),"好好学习，天天飞起");



    //高级设置
 //   QPainter painter(this);

//    painter.drawEllipse(QPoint(100,50),50,50);

//    painter.setRenderHint(QPainter::Antialiasing);//更加的清晰
//    painter.drawEllipse(QPoint(200,50),50,50);



//   painter.drawRect(QRect(20,20,50,50));
//painter.translate(100,0);
//painter.save();//将其保存

//    painter.drawRect(QRect(20,20,50,50));

//    painter.translate(100,0);
//    painter.restore();//虽然 图是俩图形，但是三个图形，有一个图像又移动回来了
//    //所以看着是俩图形，实际是三个图形
//    painter.drawRect(QRect(20,20,50,50));





    //利用画家来画资源图片





}
Dialog::~Dialog()
{
    delete ui;
}

