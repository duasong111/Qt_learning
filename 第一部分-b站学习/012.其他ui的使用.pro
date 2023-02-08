#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->stackedWidget->setCurrentIndex(1);

    connect(ui->obect1,&QPushButton::clicked,[=](){
        ui->stackedWidget->setCurrentIndex(0);
    });

    connect(ui->obect2,&QPushButton::clicked,[=](){
        ui->stackedWidget->setCurrentIndex(1);
    });

    ui->comboBox->addItem("奔驰");
     ui->comboBox->addItem("战斗机");
      ui->comboBox->addItem("滑翔机");

      connect(ui->option,&QPushButton::clicked,[=](){
          //ui->comboBox->setCurrentText(1);
          ui->comboBox->setCurrentText("战斗机");
      });


}

MainWindow::~MainWindow()
{
    delete ui;
}

