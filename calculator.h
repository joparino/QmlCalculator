#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QObject>
#include <QJSEngine>

class Calculator: public QObject
{
    Q_OBJECT
public:
    explicit Calculator(QObject *parent = 0){};

public slots:
    QString evalute(QString expression)
    {
        QJSValue result = m_jsEngine.evaluate(expression);
        if (result.isError())
        {
            return "Ошибка";
        }
        return result.toString();
    }

private:
    QJSEngine m_jsEngine;
};

#endif // CALCULATOR_H
