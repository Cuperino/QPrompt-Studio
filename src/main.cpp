/*
  This file is part of QPrompt Studio.

  SPDX-FileCopyrightText: 2021 Javier O. Cordero Pérez
  Author: Javier O. Cordero Pérez <javiercorderoperez@gmail.com>

  SPDX-License-Identifier: GPL-3.0-only

  Contact Javier Cordero at <javiercorderoperez@gmail.com> for commercial licensing options.
*/


#define SDIO = false
#include <kddockwidgets/Config.h>
// If DockWidgetQuick isn't found is because KDDockWidgets was compiled without QtQuick support.
#include <kddockwidgets/DockWidgetQuick.h>
#include <kddockwidgets/private/DockRegistry_p.h>
#include <kddockwidgets/FrameworkWidgetFactory.h>

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <KI18n/KLocalizedString>

#include "QPrompt/src/prompter/documenthandler.h"

int main(int argc, char *argv[])
{
#ifdef Q_OS_WIN
    QGuiApplication::setAttribute(Qt::AA_UseOpenGLES);
#endif
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
#endif
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("Cuperino");
    QCoreApplication::setOrganizationDomain("cuperino.com");
    QCoreApplication::setApplicationName("QPrompt Studio");

    qmlRegisterType<DocumentHandler>("com.cuperino.qprompt.document", 1, 0, "DocumentHandler");

    auto flags = KDDockWidgets::Config::self().flags();
    KDDockWidgets::Config::self().setFlags(flags);

    QQmlApplicationEngine appEngine;
    // If setQmlEngine isn't found is because KDDockWidgets was compiled without QtQuick support.
    KDDockWidgets::Config::self().setQmlEngine(&appEngine);
    appEngine.load((QUrl(QStringLiteral("qrc:/qml/main.qml"))));


    return app.exec();
}
