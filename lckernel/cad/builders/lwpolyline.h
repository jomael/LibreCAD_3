#pragma once

#include "cadentity.h"

namespace lc {
	namespace builder {

		struct LWBuilderVertex
		{
			LWBuilderVertex(geo::Coordinate v, double bul)
			{
				location = v;
				bulge = bul;
				startWidth = 0;
				endWidth = 0;
			}

			LWBuilderVertex(geo::Coordinate v, double startW, double endW, double bul)
			{
				location = v;
				startWidth = startW;
				endWidth = endW;
				bulge = bul;
			}

			geo::Coordinate location;
			double bulge;
			double startWidth;
			double endWidth;
		};

		class LWPolylineBuilder : public CADEntityBuilder {
			public:
				LWPolylineBuilder();
				virtual ~LWPolylineBuilder() = default;
				void addLineVertex(const lc::geo::Coordinate& vert);
				void addArcVertex(const lc::geo::Coordinate& vert);
				void modifyLastVertex(const geo::Coordinate& vert);
				void modifyLastVertexArc();
				void modifyLastVertexLine();
				void removeVertex(int index);
				const std::vector<lc::builder::LWBuilderVertex>& getVertices();
				lc::entity::LWPolyline_CSPtr build();
		private:
			std::vector<lc::builder::LWBuilderVertex> _vertices;
			double _currentVertex_Bulge;
			double _currentVertex_StartWidth;
			double _currentVertex_EndWidth;
			geo::Coordinate _currentVertex_Location;
		};

	}
}