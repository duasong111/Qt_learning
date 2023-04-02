#include "mywidget_modal.h"
#include "ui_mywidget_modal.h"
#include <QDialog>
#include <QPushButton>
Mywidget_modal::Mywidget_modal(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Mywidget_modal)
{
    ui->setupUi(this);
    connect(ui->showChidButton,SIGNAL(clicked()),this,SLOT(showChidDialog()));
 //    QDialog  dialog(this);
//   dialog.exec();
//    QDialog *dialog= new QDialog(this);
//    dialog->setModal(true);
 //   dialog.show();
}

Mywidget_modal::~Mywidget_modal()
{
    delete ui;
}

void Mywidget_modal::showChidDialog()
{
    QDialog *dialog = new QDialog(this);
    dialog->show();
}
