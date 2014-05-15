#ifndef LCVCIRCLE_H
#define LCVCIRCLE_H

#include "lcvdrawitem.h"
#include "cad/primitive/circle.h"

class LcDrawOptions;
class LcPainter;
class QRectF;

class LCVCircle  : public LCVDrawItem, public lc::Circle {
    public:
        LCVCircle(const std::shared_ptr<const lc::Circle> circle);

        virtual void draw(LcPainter* painter, LcDrawOptions* options, const QRectF& rect) const;
};

#endif // LCVCIRCLE_H