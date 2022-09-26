// This file is part of QPrompt Studio.
// SPDX-FileCopyrightText: 2021-2022 Javier O. Cordero Pérez
// SPDX-License-Identifier: GPL-3.0-only


// #define SDIO = false
#include <kddockwidgets/Config.h>
// If DockWidgetQuick isn't found is because KDDockWidgets was compiled without QtQuick support.
#include <kddockwidgets/private/DockRegistry.h>
// #include <kddockwidgets/ViewFactory.h>
#include <kddockwidgets/ViewFactory_qtquick.h>
#include <kddockwidgets/Platform_qtquick.h>
#include <kddockwidgets/views/DockWidget_qtquick.h>
#include "kddockwidgets/views/MainWindow_qtquick.h"

#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS) || defined(Q_OS_WASM) || defined(Q_OS_WATCHOS) || defined(Q_OS_QNX)
#include <QGuiApplication>
#else
#include <QApplication>
#include <QtWidgets>
#endif
#include <QQmlApplicationEngine>

// #include <KLocalizedContext>
// #include <KI18n/KLocalizedString>
// #include <qqmlcontext.h>

#include "utils/abstractunits.hpp"
#include "QPrompt/src/prompter/documenthandler.h"

#define QPROMPT_STUDIO_URI "com.cuperino.qpromptstudio"
#define QPROMPT_URI "com.cuperino.qprompt"

class MaterialViewFactory : public KDDockWidgets::ViewFactory_qtquick
{
public:
    ~MaterialViewFactory() override;

    // Title bar
    QUrl titleBarFilename() const override
    {
        return QUrl("qrc:///MaterialTitlebar.qml");
    }
    // MainWIndow Background
    QUrl dockwidgetFilename() const override
    {
        return QUrl("qrc:///Blank.qml");
    }
};

MaterialViewFactory::~MaterialViewFactory() = default;

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
    KDDockWidgets::initFrontend(KDDockWidgets::FrontendType::QtQuick);
    QCoreApplication::setOrganizationName("Cuperino");
    QCoreApplication::setOrganizationDomain("cuperino.com");
    QCoreApplication::setApplicationName("QPrompt");

    qmlRegisterType<DocumentHandler>(QPROMPT_URI".document", 1, 0, "DocumentHandler");
    qmlRegisterType<MarkersModel>(QPROMPT_URI".markers", 1, 0, "MarkersModel");
    qmlRegisterUncreatableType<AbstractUnits>(QPROMPT_URI".abstractunits", 1, 0, "Units", "Access to Duration enum");

    auto &config = KDDockWidgets::Config::self();
    auto flags = config.flags();

    config.setFlags(flags);
    config.setViewFactory(new MaterialViewFactory());
// #if defined(DOCKS_DEVELOPER_MODE)
//     auto internalFlags = KDDockWidgets::Config::self().internalFlags();
//     // These are debug-only/development flags, which you can ignore.
//     KDDockWidgets::Config::self().setInternalFlags(internalFlags);
// #endif
//
//     KDDockWidgets::Config::self().setFlags(flags);

    QQmlApplicationEngine engine;
    // If setQmlEngine isn't found is because KDDockWidgets was compiled without QtQuick support.
    KDDockWidgets::Platform_qtquick::instance()->setQmlEngine(&engine);
    engine.load((QUrl(QStringLiteral("qrc:///main.qml"))));

//     auto prompterDockWidget = new KDDockWidgets::Views::DockWidget_qtquick("Prompter");
//     prompterDockWidget->setGuestItem(QStringLiteral("qrc:/PrompterView.qml"));
//     //prompterDockWidget->setWidget(QStringLiteral("qrc:/Prompter.qml"));
//     prompterDockWidget->show();
//
//     auto editorDockWidget = new KDDockWidgets::Views::DockWidget_qtquick("Editor");
//     editorDockWidget->setGuestItem(QStringLiteral("qrc:/PrompterView.qml"));
//     editorDockWidget->show();
//
//     auto markersDockWidget = new KDDockWidgets::Views::DockWidget_qtquick("Markers");
//     markersDockWidget->setGuestItem(QStringLiteral("qrc:/MarkersDrawer.qml"));
//     markersDockWidget->show();
//
//     auto toolbarDockWidget = new KDDockWidgets::Views::DockWidget_qtquick("Toolbar");
//     toolbarDockWidget->setGuestItem(QStringLiteral("qrc:/EditorToolbar.qml"));
//     toolbarDockWidget->show();
//
//     // Access the main area we created in QML with DockingArea {}
//     auto mainArea = KDDockWidgets::DockRegistry::self()->mainDockingAreas().constFirst();
//     mainArea->addDockWidgetAsTab(prompterDockWidget);
//     mainArea->addDockWidget(editorDockWidget, KDDockWidgets::Location_OnLeft, nullptr, QSize(660, 480));
//     mainArea->addDockWidget(markersDockWidget, KDDockWidgets::Location_OnLeft, nullptr, QSize(320, /*ignored*/0));
//     mainArea->addDockWidget(toolbarDockWidget, KDDockWidgets::Location_OnBottom, nullptr, QSize(/*ignored*/0, 96));

    return app.exec();
}
