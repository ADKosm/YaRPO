//
// Created by alex on 20.01.17.
//

#include <QObject>
#include <QApplication>
#include <QWidget>
#include <QString>
#include <QVBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <string>
#include <string.h>

#include <src/widgets.h>

extern "C" {

struct Application* Application_New(int * argc, char ** argv) {
    QApplication * app = new QApplication(*argc, argv);
    return (struct Application*) app;
}

int Application_Exec(struct Application *app) {
    QApplication * application = (QApplication*)app;
    return application->exec();
}

const char* Object_GetClassName(struct Object *object) {
    QObject * obj = (QObject*) object;
    const char * name = obj->metaObject()->className();
    char * result = new char[strlen(name)];
    strcpy(result, name + 1);
    return result;
}

void Object_Delete(struct Object *object) {
    QObject * obj = (QObject*) object;
    delete obj;
}

struct Widget* Widget_New(struct Widget *parent) {
    QWidget * wid = new QWidget((QWidget*) parent);
    return (struct Widget*)wid;
}

void Widget_SetVisible(struct Widget *widget, bool v) {
    printf("4 - %s\n", (((QWidget*)widget)->metaObject()->className()));
    QWidget * a = ((QWidget*)widget);
    printf("5 - %s\n", a->metaObject()->className());
    a->setVisible(true); // SEGFAULT!!
    printf("6\n");
}
void Widget_SetWindowTitle(struct Widget *widget, const char *title) {
    ((QWidget*)widget)->setWindowTitle(QString(title));
}
void Widget_SetSize(struct Widget *widget, int w, int h) {
    ((QWidget*)widget)->resize(w, h);
}

void Widget_SetLayout(struct Widget *widget, struct Layout *layout) {
    ((QWidget*)widget)->setLayout((QLayout*)layout);
}

struct VBoxLayout* VBoxLayout_New(struct Widget *parent) {
    QVBoxLayout * vbl = new QVBoxLayout((QWidget*) parent);
    return (struct VBoxLayout*)vbl;
}
void Layout_AddWidget(struct Layout *layout, struct Widget *widget) {
    ((QLayout*) layout)->addWidget((QWidget*)widget);
}

struct Label* Label_New(struct Widget *parent) {
    QLabel * label = new QLabel((QWidget*) parent);
    return (struct Label*) label;
}
void Label_SetText(struct Label *label, const char *text) {
    ((QLabel*)label)->setText(QString(text));
}

struct PushButton* PushButton_New(struct Widget *parent) {
    QPushButton * button = new QPushButton((QWidget*) parent);
    return (struct PushButton*) button;
}
void PushButton_SetText(struct PushButton *button, const char *text) {
    ((QPushButton*)button)->setText(QString(text));
}
void PushButton_SetOnClicked(struct PushButton *button, NoArgumentsCallback *callback) {
    QPushButton* b = (QPushButton*)button;
    QObject::connect(b, &QPushButton::clicked, [button, callback]{ callback((struct Object*) button); });
}


// ---
}