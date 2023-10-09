const Browserify = require('browserify');
const fs = require('fs');
const path = require('path');
const colors = require('colors/safe');

const DEFAULT_OPTIONS = {
  help: false,
  watch: false,
  paths: []
};

const options = process.argv.slice(2).reduce(
  (options, arg) => {
    switch (arg) {
      case '-h':
      case '--help':
        options.help = true;
        break;
      case '-w':
      case '--watch':
        options.watch = true;
        break;
      default:
        options.paths.push(arg);
        break;
    }

    return options;
  },
  Object.assign({}, DEFAULT_OPTIONS)
);

if (options.help || options.paths.length === 0) {
  help();
  process.exit(0);
}

const FRAMER_DIR = path.resolve(options.paths[0]);
const MODULE_DIR = path.resolve(FRAMER_DIR, 'modules');
const BUNDLE_PATH = path.resolve(FRAMER_DIR, 'framer', 'framer.modules.js');
const INCLUDE_FILES = /\.coffee$|\.js$/;

const BUNDLE_OPTIONS = {
  transform: ['coffeeify'],
  extensions: ['.coffee', '.js'],
  debug: true
};

bundle();

if (options.watch) {
  watch();
}

function help() {
  console.error('Usage: framer-bundler [--watch] path');
}

function watch() {
  const listener = throttle(100, bundle);

  fs.watch(MODULE_DIR, (event, file) => {
    INCLUDE_FILES.test(file) && listener();
  });
}

function bundle() {
  try {
    const startTime = Date.now();
    const b = Browserify(BUNDLE_OPTIONS);

    fs.readdirSync(MODULE_DIR)
      .filter(file => INCLUDE_FILES.test(file))
      .map(file => path.resolve(MODULE_DIR, file))
      .map(file => path.parse(file))
      .forEach(file => b.require(path.format(file), {expose: file.name}));

    b.bundle()
      .on('error', error => finish(error))
      .pipe(fs.createWriteStream(BUNDLE_PATH))
      .on('error', error => finish(error))
      .on('close', () => finish(null, Date.now() - startTime));
  }
  catch (error) {
    finish(error);
  }
}

function finish(error, buildTime) {
  const message = error
    ? `${timestamp()} ${colors.red.bold('FAIL')}\n\n${colors.red(indent(error))}\n`
    : `${timestamp()} ${colors.green.bold('SUCCESS')} ${buildTime}ms`;
  console.error(message);
}

function timestamp() {
  const now = new Date();
  const hh = ('0' + now.getHours()).substr(-2);
  const mm = ('0' + now.getMinutes()).substr(-2);
  const ss = ('0' + now.getSeconds()).substr(-2);
  return `${hh}:${mm}:${ss}`;
}

function indent(obj) {
  return String(obj).split(/\r?\n|\r/g)
    .map(line => '  ' + line)
    .join('\n');
}

function throttle(interval, callback) {
  let scheduled = null;

  const run = function() {
    clearTimeout(scheduled);
    scheduled = null;
    callback();
  };

  return function() {
    if (!scheduled) {
      scheduled = setTimeout(run, interval);
    }
  };
}
