$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'xamplr-gen'

require 'test/unit/assertions'

World(Test::Unit::Assertions)
