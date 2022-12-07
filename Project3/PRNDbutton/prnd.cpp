#include "prnd.h"
#include "ui_prnd.h"

PRND::PRND(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::PRND)
{
    ui->setupUi(this);
}

PRND::~PRND()
{
    delete ui;
}

