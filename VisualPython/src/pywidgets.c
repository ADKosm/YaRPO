#include <Python.h>
#include <modsupport.h>
#include "src/widgets.h"

static char module_docstring[] =
        "This module provides an interface for Qt using C.";
static char hello_docstring[] =
        "Simple GUI on python";

int argc = 1;
char argv[] = "GUI";

static PyObject *pywidgets_hello(PyObject *self, PyObject *args);
static PyObject *pywidgets_application_exec(PyObject *self, PyObject *args);
static PyObject *pywidgets_application_new(PyObject *self, PyObject *args);
static PyObject *pywidgets_object_getclassname(PyObject *self, PyObject *args);
static PyObject *pywidgets_object_delete(PyObject *self, PyObject *args);
static PyObject *pywidgets_vboxlayout_new(PyObject *self, PyObject *args);
static PyObject *pywidgets_layout_addwidget(PyObject *self, PyObject *args);
static PyObject *pywidgets_widget_new(PyObject *self, PyObject *args);
static PyObject *pywidgets_widget_setvisible(PyObject *self, PyObject *args);
static PyObject *pywidgets_widget_setwindowtitle(PyObject *self, PyObject *args);
static PyObject *pywidgets_setlayout(PyObject *self, PyObject *args);
static PyObject *pywidgets_setsize(PyObject *self, PyObject *args);
static PyObject *pywidgets_label_new(PyObject *self, PyObject *args);
static PyObject *pywidgets_label_settext(PyObject *self, PyObject *args);
static PyObject *pywidgets_pushbutton_new(PyObject *self, PyObject *args);
static PyObject *pywidgets_pushbutton_settext(PyObject *self, PyObject *args);

static PyMethodDef module_methods[] = {
        {"hello", pywidgets_hello, METH_VARARGS, hello_docstring},
        {"Application_New", pywidgets_application_new, METH_VARARGS, hello_docstring},
        {"Application_Exec", pywidgets_application_exec, METH_VARARGS, hello_docstring},
        {"Object_GetClassName", pywidgets_object_getclassname, METH_VARARGS, hello_docstring},
        {"Object_Delete", pywidgets_object_delete, METH_VARARGS, hello_docstring},
        {"VBoxLayout_New", pywidgets_vboxlayout_new, METH_VARARGS, hello_docstring},
        {"Layout_AddWidget", pywidgets_layout_addwidget, METH_VARARGS, hello_docstring},
        {"Widget_New", pywidgets_widget_new, METH_VARARGS, hello_docstring},
        {"Widget_SetVisible", pywidgets_widget_setvisible, METH_VARARGS, hello_docstring},
        {"Widget_SetWindowTitle", pywidgets_widget_setwindowtitle, METH_VARARGS, hello_docstring},
        {"Widget_SetLayout", pywidgets_setlayout, METH_VARARGS, hello_docstring},
        {"Widget_SetSize", pywidgets_setsize, METH_VARARGS, hello_docstring},
        {"Label_New", pywidgets_label_new, METH_VARARGS, hello_docstring},
        {"Label_SetText", pywidgets_label_settext, METH_VARARGS, hello_docstring},
        {"PushButton_New", pywidgets_pushbutton_new, METH_VARARGS, hello_docstring},
        {"PushButton_SetText", pywidgets_pushbutton_settext, METH_VARARGS, hello_docstring},
        {NULL, NULL, 0, NULL}
};

static struct PyModuleDef moduledef = {
        PyModuleDef_HEAD_INIT,
        "libpywidgets",     /* m_name */
        "This is a module",  /* m_doc */
        -1,                  /* m_size */
        module_methods,    /* m_methods */
        NULL,                /* m_reload */
        NULL,                /* m_traverse */
        NULL,                /* m_clear */
        NULL,                /* m_free */
};

PyMODINIT_FUNC PyInit_libpywidgets(void) {
    PyObject *m = PyModule_Create(&moduledef);//Py_InitModule3("_pywidgets", module_methods, module_docstring);
    if (m == NULL)
        return;
}

static PyObject *pywidgets_hello(PyObject *self, PyObject *args) {
    PyObject *ret = Py_BuildValue("s", "Hello from pure C");
    return ret;
}

static PyObject *pywidgets_application_new(PyObject *self, PyObject *args) {
    int *a = malloc(sizeof(int));
    *a = 1;

    char *b = malloc(1);
    *b = '\0';
    return Py_BuildValue("L", (long long)Application_New(a, &b));
}

static PyObject *pywidgets_application_exec(PyObject *self, PyObject *args) {
    long long app_l;

    if (!PyArg_ParseTuple(args, "L", &app_l)) return NULL;

    return Py_BuildValue("i", Application_Exec((struct Application*)app_l));
}

static PyObject *pywidgets_object_getclassname(PyObject *self, PyObject *args) {
    long long obj_l;

    if(!PyArg_ParseTuple(args, "L", &obj_l)) return NULL;

    return Py_BuildValue("s", Object_GetClassName((struct Object*)obj_l));
}

static PyObject *pywidgets_object_delete(PyObject *self, PyObject *args) {
    long long obj_l;

    if(!PyArg_ParseTuple(args, "L", &obj_l)) return NULL;

    Object_Delete((struct Object*)obj_l);

    return Py_BuildValue("i", NULL);
}

static PyObject *pywidgets_vboxlayout_new(PyObject *self, PyObject *args) {
    long long obj_l;

    if (!PyArg_ParseTuple(args, "L", &obj_l)) return NULL;

    return Py_BuildValue("L", (long long)VBoxLayout_New((struct Widget*)obj_l));
}

static PyObject *pywidgets_layout_addwidget(PyObject *self, PyObject *args) {
    long long layout_l, widget_l;

    if (!PyArg_ParseTuple(args, "LL", &layout_l, &widget_l)) return NULL;

    Layout_AddWidget((struct Layout*)layout_l, (struct Widget*)widget_l);

    return Py_BuildValue("i", NULL);
}

static PyObject *pywidgets_widget_new(PyObject *self, PyObject *args) {
    long long obj_l;

//    if (!PyArg_ParseTuple(args, "L", &obj_l)) {
//        printf("ASDSSF\n");
        return Py_BuildValue("L", (long long)Widget_New((struct Widget*)NULL));
//    } else {
//        return Py_BuildValue("L", (long long)Widget_New((struct Widget*)obj_l));
//    }
}

static PyObject *pywidgets_widget_setvisible(PyObject *self, PyObject *args) {
    long long obj_l;
    int v;

    printf("2\n");

    if (!PyArg_ParseTuple(args, "Li", &obj_l, &v)) return NULL;

    printf("3 - %d\n", v);

    Widget_SetVisible((struct Widget*)obj_l, (bool)v);

    printf("7\n");

    return Py_BuildValue("i", NULL);
}

static PyObject *pywidgets_widget_setwindowtitle(PyObject *self, PyObject *args) {
    long long obj_l;
    const char * title;

    if (!PyArg_ParseTuple(args, "Ls", &obj_l, &title)) return NULL;

    Widget_SetWindowTitle((struct Widget*)obj_l, title);

    return Py_BuildValue("i", NULL);
}

static PyObject *pywidgets_setlayout(PyObject *self, PyObject *args) {
    long long layout_l, widget_l;

    if (!PyArg_ParseTuple(args, "LL", &widget_l, &layout_l)) return NULL;

    Widget_SetLayout((struct Widget*)widget_l, (struct Layout*)layout_l);

    return Py_BuildValue("i", NULL);
}

static PyObject *pywidgets_setsize(PyObject *self, PyObject *args) {
    long long obj_l;
    int w, h;

    if (!PyArg_ParseTuple(args, "Lii", &obj_l, &w, &h)) return NULL;

    Widget_SetSize((struct Label*)obj_l, w, h);

    return Py_BuildValue("i", NULL);
}

static PyObject *pywidgets_label_new(PyObject *self, PyObject *args) {
    long long obj_l;

    if (!PyArg_ParseTuple(args, "L", &obj_l)) return NULL;

    return Py_BuildValue("L", (long long)Label_New((struct Widget*)obj_l));
}

static PyObject *pywidgets_label_settext(PyObject *self, PyObject *args) {
    long long obj_l;
    const char * title;

    if (!PyArg_ParseTuple(args, "Ls", &obj_l, &title)) return NULL;

    Label_SetText((struct Label*)obj_l, title);

    return Py_BuildValue("i", NULL);
}

static PyObject *pywidgets_pushbutton_new(PyObject *self, PyObject *args) {
    long long obj_l;

    if (!PyArg_ParseTuple(args, "L", &obj_l)) return NULL;

    return Py_BuildValue("L", (long long)PushButton_New((struct Widget*)obj_l));
}


static PyObject *pywidgets_pushbutton_settext(PyObject *self, PyObject *args) {
    long long obj_l;
    const char * title;

    if (!PyArg_ParseTuple(args, "Ls", &obj_l, &title)) return NULL;

    PushButton_SetText((struct PushButton*)obj_l, title);

    return Py_BuildValue("i", NULL);
}