/*
  This file is part of QPrompt Studio.

  SPDX-FileCopyrightText: 2021 Javier O. Cordero Pérez
  Author: Javier O. Cordero Pérez <javiercorderoperez@gmail.com>

  SPDX-License-Identifier: GPL-3.0-only

  Contact Javier Cordero at <javiercorderoperez@gmail.com> for commercial licensing options.
*/


//#define SDIO = false
#include <kddockwidgets/Config.h>
// If DockWidgetQuick isn't found is because KDDockWidgets was compiled without QtQuick support.
#include <kddockwidgets/DockWidgetQuick.h>
#include <kddockwidgets/private/DockRegistry_p.h>
#include <kddockwidgets/FrameworkWidgetFactory.h>

#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS) || defined(Q_OS_WASM) || defined(Q_OS_WATCHOS) || defined(Q_OS_QNX)
#include <QGuiApplication>
#else
#include <QApplication>
#include <QtWidgets>
#endif
#include <QQmlApplicationEngine>

//#include <KLocalizedContext>
//#include <KI18n/KLocalizedString>
//#include <qqmlcontext.h>

#include "QPrompt/src/prompter/documenthandler.h"

#define QPROMPT_STUDIO_URI "com.cuperino.qpromptstudio"
#define QPROMPT_URI "com.cuperino.qprompt"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WINDOWS)
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    putenv("QSG_RENDER_LOOP=windows");
#else
    putenv("QSG_RENDER_LOOP=basic");
#endif
#elif defined(Q_OS_MACOS) || defined(Q_OS_LINUX)
    setenv("QSG_RENDER_LOOP", "basic", 1);
#endif
#ifdef Q_OS_WIN
    QGuiApplication::setAttribute(Qt::AA_UseOpenGLES);
#endif
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
#endif
#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS) || defined(Q_OS_WASM) || defined(Q_OS_WATCHOS) || defined(Q_OS_QNX)
    QGuiApplication app(argc, argv);
#else
    QApplication app(argc, argv);
#endif

    QCoreApplication::setOrganizationName("Cuperino");
    QCoreApplication::setOrganizationDomain("cuperino.com");
    QCoreApplication::setApplicationName("QPrompt Studio");

    qmlRegisterType<DocumentHandler>(QPROMPT_URI".document", 1, 0, "DocumentHandler");
    qmlRegisterType<MarkersModel>(QPROMPT_URI".markers", 1, 0, "MarkersModel");

    auto flags = KDDockWidgets::Config::self().flags();
    KDDockWidgets::Config::self().setFlags(flags);

    QQmlApplicationEngine engine;
    qRegisterMetaType<Marker>();
    // If setQmlEngine isn't found is because KDDockWidgets was compiled without QtQuick support.
    KDDockWidgets::Config::self().setQmlEngine(&engine);
//    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load((QUrl(QStringLiteral("qrc:///qml/main.qml"))));

//     auto prompterDockWidget = new KDDockWidgets::DockWidgetQuick("Prompter", KDDockWidgets::DockWidgetBase::Option::Option_NotClosable);
//     prompterDockWidget->setWidget(QStringLiteral("qrc:/PrompterView.qml"));
    //prompterDockWidget->setWidget(QStringLiteral("qrc:/Prompter.qml"));
//     prompterDockWidget->show();

//     auto editorDockWidget = new KDDockWidgets::DockWidgetQuick("Editor", KDDockWidgets::DockWidgetBase::Option::Option_NotClosable);
//     editorDockWidget->setWidget(QStringLiteral("qrc:/PrompterView.qml"));
//     editorDockWidget->show();
//
//     auto markersDockWidget = new KDDockWidgets::DockWidgetQuick("Markers");
//     markersDockWidget->setWidget(QStringLiteral("qrc:/MarkersDrawer.qml"));
//     markersDockWidget->show();
//
//     auto toolbarDockWidget = new KDDockWidgets::DockWidgetQuick("Toolbar", KDDockWidgets::DockWidgetBase::Option::Option_NotClosable);
//     toolbarDockWidget->setWidget(QStringLiteral("qrc:/EditorToolbar.qml"));
//     toolbarDockWidget->show();

//     KDDockWidgets::MainWindowBase *mainWindow = KDDockWidgets::DockRegistry::self()->mainwindows().constFirst();
//     mainWindow->addDockWidgetAsTab(prompterDockWidget);
//     mainWindow->addDockWidget(editorDockWidget, KDDockWidgets::Location_OnLeft, nullptr, QSize(660, 480));
//     mainWindow->addDockWidget(markersDockWidget, KDDockWidgets::Location_OnLeft, nullptr, QSize(320, /*ignored*/0));
//     mainWindow->addDockWidget(toolbarDockWidget, KDDockWidgets::Location_OnBottom, nullptr, QSize(/*ignored*/0, 96));

    return app.exec();
}
