// eslint-disable-next-line max-len
/** @type {import('@typescript-eslint/experimental-utils').TSESLint.Linter.Config} */
module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  parserOptions: {
    ecmaVersion: 13,
  },
  rules: {
    "quotes": ["error", "double"],
    "indent": [2, 2],
    "eol-last": 0,
    "no-multiple-empty-lines": ["error", {
      "max": 1,
      "maxEOF": 0,
    }],
    "max-len": ["error", {
      "code": 200,
    }],
  },
};