baseDepth = 100;
heartDepth = -baseDepth * 3 / 4;
headEdgeDepth = 50;
headCenterDepth = headEdgeDepth + 50;
eyeLow = headEdgeDepth + (headCenterDepth - headEdgeDepth) * 0.7;
eyeHigh = headCenterDepth;
tuskLow = headEdgeDepth * 0.8;
tuskHigh = tuskLow + 10;

module triangle (x1, y1, x2, y2) {
    polyhedron(points = [
      [x1, y1, 0],
      [x2, y2, 0],
      [715,-615,0],
      [x1, y1, baseDepth],
      [x2, y2, baseDepth],
      [715,-615,baseDepth + heartDepth],
    ], faces = [
      [0, 1, 2], // bottom
      [0, 3, 4, 1],
      [0, 2, 5, 3],
      [1, 4, 5, 2],
      [3, 5, 4], // top
    ]);
};

module graphileheart() {
    triangle(100,-615,25,-360);
    triangle(25,-360,260,-25);
    triangle(260,-25,600,-130);
    triangle(600,-130,940,-25);
    triangle(940,-25,1175,-360);
    triangle(1175,-360,1100,-615);
    triangle(1100,-615,600,-1055);
    triangle(600,-1055,100,-615);
}


module etriangle (x1, y1, x2, y2) {
    polyhedron(points = [
      [x1, y1, baseDepth + headEdgeDepth],
      [x2, y2, baseDepth + headEdgeDepth],
      [600,-450,baseDepth - 1000],
      [600,-450,baseDepth + headCenterDepth]
    ], faces = [
      [0, 2, 1], // bottom
      [0, 1, 3], // top
      [0, 3, 2],
      [1, 2, 3]
    ]);
};

module elephanthead() {
    etriangle(325,-300,490,-96);
    etriangle(490,-96,710,-96);
    etriangle(710,-96,875,-300);

    etriangle(875,-300,875,-725);

    etriangle(875,-725,710,-835);
    etriangle(710,-835,710,-1075);
    etriangle(710,-1075,600,-1130);
    etriangle(600,-1130,490,-1075);
    etriangle(490,-1075,490,-835);
    etriangle(490,-835,325,-725);

    etriangle(325,-725,325,-300);
}


module eye (x1, y1, x2, y2, x3, y3) {
    polyhedron(points = [
      [x1, y1, baseDepth],
      [x2, y2, baseDepth],
      [x3, y3, baseDepth],
      [x1, y1, baseDepth + eyeHigh],
      [x2, y2, baseDepth + eyeLow],
      [x3, y3, baseDepth + eyeHigh],
    ], faces = [
      [0, 1, 2], // bottom
      [3, 5, 4], // top
      [0, 3, 4, 1],
      [0, 2, 5, 3],
      [1, 4, 5, 2],
    ]);
};

module tusk (x1, y1, x2, y2, x3, y3) {
    polyhedron(points = [
      [600,-450, -1000],
      [x1, y1, baseDepth + tuskLow],
      [x2, y2, baseDepth + tuskLow],
      [x3, y3, baseDepth + tuskHigh],
    ], faces = [
      [1, 2, 3], // top
      [0, 2, 1],
      [0, 1, 3],
      [0, 3, 2],
    ]);
};

module main() {
    union() {
    graphileheart();
    elephanthead();
    eye(385,-415,515,-455,385,-505);
    eye(815,-415,685,-455,815,-505);
    tusk(375,-740,460,-795,325,-900);
    tusk(825,-740,740,-795,875,-900);
    }
}


difference() {
    main();
    translate([0, -2000, -2000]) {
        cube([2000, 2000, 2000]);
    }
}