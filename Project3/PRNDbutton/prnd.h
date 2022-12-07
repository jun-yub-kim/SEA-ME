#ifndef PRND_H
#define PRND_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui { class PRND; }
QT_END_NAMESPACE

class PRND : public QMainWindow
{
    Q_OBJECT

public:
    PRND(QWidget *parent = nullptr);
    ~PRND();

private:
    Ui::PRND *ui;
};
#endif // PRND_H
