module.exports = {
    plugins: {
     'postcss-csso': {},
     'precss': {},
     'autoprefixer': {},
     'postcss-short': { skip: 'x', prefix: '' },
     'postcss-fixes': {preserve: true},
     'postcss-preset-env': {},
    }
  }