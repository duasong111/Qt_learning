#include "mainwindow.h"
#include <QMenuBar>
#include <QToolBar>
#include <QDebug>
#include <QPushButton>
#include <QStatusBar>
#include <QLabel>
#include <QDockWidget>
#include <QTextEdit>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    resize(600,400);

    //菜单栏 最多只有一个
    QMenuBar *bar =menuBar();
    //放进去
    setMenuBar(bar);
        //地址
   QMenu *fileMenu = bar->addMenu("文件");
   QMenu *editMenu = bar->addMenu("编辑");
 //  QMenu *toolBar = bar->addAction("打开");



   QAction *newAction11=fileMenu->addAction("新建"); //这就是返回值的作用

   fileMenu->addSeparator();  //添加分割符
  QAction *openAction =fileMenu->addAction("打开");


   //工具栏 多个
   QToolBar * toolBar = new QToolBar(this);
   addToolBar(Qt::LeftToolBarArea,toolBar);
  toolBar->setAllowedAreas(Qt::LeftToolBarArea|Qt::RightToolBarArea); //左右悬浮
//toolBar->setFloatable(true);
  toolBar->setMovable(false); //控制 浮动
  //工具栏设置内容
  toolBar->addAction(newAction11);
  toolBar->addSeparator();
  toolBar->addAction(openAction);

  QPushButton *btn = new QPushButton("按钮",this);
  toolBar->addWidget(btn);
  //menuBar->addMenu()


  //状态栏  -最多也是一个
  QStatusBar *stBar=statusBar();
  setStatusBar(stBar); //设置窗口
  QLabel * label = new QLabel("提示信息");
  stBar->addWidget(label);
     QLabel * label2 = new QLabel("右侧提示信息");
     stBar ->addPermanentWidget(label2);
      //permanent 永久
 //铆接部件 浮动窗口 多个
     QDockWidget * dockWidget =new QDockWidget("浮动",this);
     addDockWidget(Qt::BottomDockWidgetArea,dockWidget);


//     QDockWidget * dockWidget2 = new QDockWidget("浮动2",this);
//      addDockWidget(Qt::LeftDockWidgetArea,dockWidget2);

   //dockWidget（
     dockWidget->setAllowedAreas(Qt::LeftDockWidgetArea|Qt::RightDockWidgetArea);
     // 上边的那个只能在左右悬浮
    //  dockWidget->setAllowedAreas(Qt::RightDockWidgetArea| Qt::LeftWidgetArea);
    // 设置中心部件 只能有一个
     QTextEdit *edit = new QTextEdit(this);
     setCentralWidget(edit);

}

MainWindow::~MainWindow()
{
}

