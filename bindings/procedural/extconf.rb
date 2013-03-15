require 'mkmf'
require "ruby-ois"
require "ruby-ogre"
require_relative "../../lib/ruby-procedural"


# set flags
$CFLAGS += " -g #{Ruby::Procedural::get_inc_flags} #{Ruby::Ogre::get_inc_flags} #{Ruby::Ois::get_inc_flags}"

if (/mingw/ =~ RUBY_PLATFORM)
  $LDFLAGS += " -static-libgcc -static-libstdc++ #{Ruby::Procedural::get_lib_flags} #{Ruby::Ogre::get_lib_flags} #{Ruby::Ois::get_lib_flags} -lws2_32 -lwinmm"
else
  $LDFLAGS += " -static-libgcc -static-libstdc++ #{Ruby::Procedural::get_lib_flags} #{Ruby::Ogre::get_lib_flags} #{Ruby::Ois::get_lib_flags}"
end

$srcs = ["interface/procedural_wrap.cpp"]

$objs = $srcs.collect {|o| o.sub(/\.cpp|\.cc|\.cxx/, ".o")}
$cleanfiles = $objs

create_makefile('procedural')
