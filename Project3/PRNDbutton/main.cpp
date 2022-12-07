#include "prnd.h"
#include "ui_prnd.h"
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtGui/QFont>
#include <QtGui/QFontDatabase>
//is it going well?

// below is for chat

#include <QApplication>
#include <QMessageBox>

#include "chat.h"
#include "chat_adaptor.h"
#include "chat_interface.h"





//-------------------------------from here it is for PRND-----------------------------------------------------------------




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



//---------------------------from here it is for chat---------------------------------------------------------------------
ChatMainWindow::ChatMainWindow()
{
    qmlRegisterType<ChatMainWindow>("Joe", 1, 0, "ChatMainWindow");
    setupUi(this);
    sendButton->setEnabled(false);

    connect(messageLineEdit, SIGNAL(textChanged(QString)),
            this, SLOT(textChangedSlot(QString)));
    connect(sendButton, SIGNAL(clicked(bool)), this, SLOT(sendClickedSlot()));

    //-------------------------Pbutton-------------------------------
    connect(Pbutton, SIGNAL(clicked(bool)), this, SLOT(sendP()));
    //-------------------------Rbutton-------------------------------
    connect(Rbutton, SIGNAL(clicked(bool)), this, SLOT(sendR()));
    //-------------------------Nbutton-------------------------------
    connect(Nbutton, SIGNAL(clicked(bool)), this, SLOT(sendN()));
    //-------------------------Dbutton-------------------------------
    connect(Dbutton, SIGNAL(clicked(bool)), this, SLOT(sendD()));

    connect(actionChangeNickname, SIGNAL(triggered(bool)), this, SLOT(changeNickname()));
    connect(actionAboutQt, SIGNAL(triggered(bool)), this, SLOT(aboutQt()));
    connect(qApp, SIGNAL(lastWindowClosed()), this, SLOT(exiting()));

    // add our D-Bus interface and connect to D-Bus
    new ChatAdaptor(this);
    QDBusConnection::sessionBus().registerObject("/", this);

    org::example::chat *iface;
    iface = new org::example::chat(QString(), QString(), QDBusConnection::sessionBus(), this);
    //connect(iface, SIGNAL(message(QString,QString)), this, SLOT(messageSlot(QString,QString)));
    QDBusConnection::sessionBus().connect(QString(), QString(), "org.example.chat", "message", this, SLOT(messageSlot(QString,QString)));
    // If I change only this, It'possible to send data, but can't receive data.
    // so i think it's connected with XML UI (org.example.chat)
    connect(iface, SIGNAL(action(QString,QString)), this, SLOT(actionSlot(QString,QString)));
}



ChatMainWindow::~ChatMainWindow()
{
}

void ChatMainWindow::rebuildHistory()
{
    QString history = m_messages.join( QLatin1String("\n" ) );
    chatHistory->setPlainText(history);
}

void ChatMainWindow::messageSlot(const QString &nickname, const QString &text)
{
    QString msg( QLatin1String("<%1> %2") );
    msg = msg.arg(nickname, text);
    m_messages.append(msg);
    this->setSomeVar(text);
    if (m_messages.count() > 100)
        m_messages.removeFirst();
    rebuildHistory();
}

void ChatMainWindow::actionSlot(const QString &nickname, const QString &text)
{
    QString msg( QLatin1String("* %1 %2") );
    msg = msg.arg(nickname, text);
    m_messages.append(msg);
    this->setSomeVar(text);

    if (m_messages.count() > 100)
        m_messages.removeFirst();
    rebuildHistory();
}

void ChatMainWindow::textChangedSlot(const QString &newText)
{
    sendButton->setEnabled(!newText.isEmpty());
}

void ChatMainWindow::sendP()
{
    //emit message(m_nickname, messageLineEdit->text());
    QDBusMessage msg = QDBusMessage::createSignal("/", "org.example.chat", "message");
    msg << "buttonP" << "1";
    QDBusConnection::sessionBus().send(msg);
    messageLineEdit->setText(QString());
}

void ChatMainWindow::sendR()
{
    //emit message(m_nickname, messageLineEdit->text());
    QDBusMessage msg = QDBusMessage::createSignal("/", "org.example.chat", "message");
    msg << "buttonR" << "2";
    QDBusConnection::sessionBus().send(msg);
    messageLineEdit->setText(QString());
}

void ChatMainWindow::sendN()
{
    //emit message(m_nickname, messageLineEdit->text());
    QDBusMessage msg = QDBusMessage::createSignal("/", "org.example.chat", "message");
    msg << "buttonN" << "3";
    QDBusConnection::sessionBus().send(msg);
    messageLineEdit->setText(QString());
}

void ChatMainWindow::sendD()
{
    //emit message(m_nickname, messageLineEdit->text());
    QDBusMessage msg = QDBusMessage::createSignal("/", "org.example.chat", "message");
    msg << "buttonD" << "4";
    QDBusConnection::sessionBus().send(msg);
    messageLineEdit->setText(QString());
}
void ChatMainWindow::sendClickedSlot()
{
    //emit message(m_nickname, messageLineEdit->text());
    QDBusMessage msg = QDBusMessage::createSignal("/", "org.example.chat", "message");
    msg << m_nickname << messageLineEdit->text();
    QDBusConnection::sessionBus().send(msg);
    messageLineEdit->setText(QString());
}

void ChatMainWindow::changeNickname()
{
    NicknameDialog dialog(this);
    if (dialog.exec() == QDialog::Accepted) {
        QString old = m_nickname;
        m_nickname = dialog.nickname->text().trimmed();
        emit action(old, QString("is now known as %1").arg(m_nickname));
    }
}

void ChatMainWindow::aboutQt()
{
    QMessageBox::aboutQt(this);
}

void ChatMainWindow::exiting()
{
    //emit action(m_nickname, QLatin1String("leaves the chat"));
}

NicknameDialog::NicknameDialog(QWidget *parent)
    : QDialog(parent)
{
    setupUi(this);
}

QString ChatMainWindow::getSomeVar()
{
    return m_someVar;
}

QString ChatMainWindow::someVar(){
    return m_someVar;
}

void ChatMainWindow::setSomeVar(QString newVar){
    if(m_someVar != newVar){
        m_someVar = newVar;
        emit someVarChanged();
    }
}

int main(int argc, char *argv[])
{
    //QApplication a(argc, argv);
    //PRND w;
    //w.show();
    //return a.exec();

    QApplication app(argc, argv);

    //PRND w;
    //w.show();

    if (!QDBusConnection::sessionBus().isConnected()) {
        qWarning("Cannot connect to the D-Bus session bus.\n"
                 "Please check your system settings and try again.\n");
        return 1;
    }

    ChatMainWindow chat;
    chat.show();

    QFontDatabase::addApplicationFont(":/fonts/DejaVuSans.ttf");
    app.setFont(QFont("DejaVu Sans"));
    return app.exec();

}
