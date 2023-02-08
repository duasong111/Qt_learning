
//头文件
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


//source文件
#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QMenuBar>
#include <QAction>
#include <QToolBar>
#include <QPushButton>
#include <QStatusBar>
#include <QLabel>
#include <QDockWidget>
#include <QTextEdit>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    resize(600,400);

    //菜单栏
  QMenuBar * bar= menuBar();
  setMenuBar(bar); //将菜单栏放入
  QMenu *fileMenu = bar->addMenu("文件");
  QMenu *editMenu = bar->addMenu("编辑");
 QAction *newAction = fileMenu->addAction("创建");
 // QAction *newAction = new QAction(this);
   //要是这样创建新的话，那那个创建打开不是文件的子文件，不是一个新的个体
 QAction *openAction = fileMenu->addAction("打开");
 fileMenu->addSeparator(); //添加一个分割符

 QToolBar * toolBar = new QToolBar(this);
 addToolBar(Qt::LeftToolBarArea,toolBar);
 toolBar->setFloatable(Qt::LeftToolBarArea|Qt::RightToolBarArea);

QPushButton *btn = new QPushButton("创建",this);
toolBar->addWidget(btn);

QStatusBar * staBar = new QStatusBar(this);
setStatusBar(staBar);

 QLabel * label = new QLabel("提示信息",this);
 staBar->addWidget(label);

 QDockWidget * dockWidget =new QDockWidget("浮动",this);
 addDockWidget(Qt::BottomDockWidgetArea,dockWidget);

 QTextEdit *edit = new QTextEdit(this);
 setCentralWidget(edit);

}

MainWindow::~MainWindow()
{
    delete ui;
}

