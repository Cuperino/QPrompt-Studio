// This file is part of QPrompt Studio.
// SPDX-FileCopyrightText: 2022 Javier O. Cordero Pérez
// SPDX-License-Identifier: GPL-3.0-only


#include "materialseparator_qtquick.h"

#include "kddockwidgets/controllers/Separator.h"

#include <QTimer>

using namespace KDDockWidgets;
using namespace KDDockWidgets::Views;

MaterialSeparator_qtquick::MaterialSeparator_qtquick( Controllers::Separator* controller, QQuickItem* parent )
    : View_qtquick( controller, Type::Separator, parent )
    , m_controller( controller ) { }

void MaterialSeparator_qtquick::init() {
    createQQuickItem( u":/MaterialSeparator.qml"_qs, this  );

    // Only set once, on Separator::init(), so single-shot is used
    QTimer::singleShot( 0, this, &MaterialSeparator_qtquick::isVerticalChanged );
}

bool MaterialSeparator_qtquick::isVertical() const {
    return m_controller->isVertical();
}

void MaterialSeparator_qtquick::onMousePressed() {
    if ( freed() )
        return;

    m_controller->onMousePress();
}

void MaterialSeparator_qtquick::onMouseMoved( QPointF localPos ) {
    if ( freed() )
        return;

    const QPointF pos = QQuickItem::mapToItem( parentItem(), localPos );
    m_controller->onMouseMove( pos.toPoint() );
}

void MaterialSeparator_qtquick::onMouseReleased() {
    if ( freed() )
        return;

    m_controller->onMouseReleased();
}

void MaterialSeparator_qtquick::onMouseDoubleClicked() {
    if ( freed() )
        return;

    m_controller->onMouseDoubleClick();
}
