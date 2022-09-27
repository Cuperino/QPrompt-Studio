// This file is part of QPrompt Studio.
// SPDX-FileCopyrightText: 2022 Javier O. Cordero Pérez
// SPDX-License-Identifier: GPL-3.0-only


#ifndef MATERIALSEPARATOR_QTQUICK_H
#define MATERIALSEPARATOR_QTQUICK_H

#pragma once
#include <QQuickItem>
#include <kddockwidgets/views/View_qtquick.h>

namespace KDDockWidgets::Controllers {
class Separator;
}

class MaterialSeparator_qtquick : public KDDockWidgets::Views::View_qtquick {
    Q_OBJECT
    Q_PROPERTY( bool isVertical READ isVertical NOTIFY isVerticalChanged )
public:
    explicit MaterialSeparator_qtquick( KDDockWidgets::Controllers::Separator* controller, QQuickItem* parent = nullptr );
    bool isVertical() const;
    void init() override;
    Q_INVOKABLE void onMousePressed();
    Q_INVOKABLE void onMouseMoved( QPointF localPos );
    Q_INVOKABLE void onMouseReleased();
    Q_INVOKABLE void onMouseDoubleClicked();
Q_SIGNALS:
    void isVerticalChanged();
private:
    KDDockWidgets::Controllers::Separator* const m_controller;
};
#endif // MATERIALSEPARATOR_QTQUICK_H
