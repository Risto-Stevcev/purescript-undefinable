"use strict";

exports.undefined = undefined;

exports.undefinable = function (a, r, f) {
  return a === undefined ? r : f(a);
};

exports.notUndefined = function (x) {
  return x;
};
