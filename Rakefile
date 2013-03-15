require 'rake/clean'
require 'ruby-ois'
require 'ruby-ogre'

task :download do
  FileUtils::mkdir_p("deps/src")
  chdir('deps/src') {
    if /mingw/ =~ RUBY_PLATFORM
      sh "wget http://ogre-procedural.googlecode.com/files/OgreProceduralSDK_MingW_v0.2.7z"
      sh "C:\Program Files (x86)\7-Zip\7z.exe x OgreProceduralSDK_MingW_v0.2.7z"
      FileUtils::mkdir_p("./")
      sh "cp -a OgreProceduralSDK_MingW_v0.2/include ../"
      sh "cp -a OgreProceduralSDK_MingW_v0.2/lib ../"
    else
      sh "hg clone -b v0-2 https://code.google.com/p/ogre-procedural/ ogre-procedural"
    end
  }
end

task :compile do
  unless /mingw/ =~ RUBY_PLATFORM
    chdir("deps/src/ogre-procedural/") {
      sh "cmake -DOGRE_HOME=#{Ruby::Ogre::get_top_path}/deps -DOIS_HOME=#{Ruby::Ois::get_top_path}/deps/ -DCMAKE_INSTALL_PREFIX:PATH=../.. -DOgreProcedural_BUILD_SAMPLES:BOOL=ON"
      sh "make -j4 && make -i install"
    }
  end
end

DLEXT = RbConfig::MAKEFILE_CONFIG['DLEXT']

## lib/*.#{DLEXT}
file "lib/procedural.#{DLEXT}" => "bindings/procedural/procedural.#{DLEXT}" do |f|
  cp f.prerequisites, "lib/", :preserve => true
end

## ext/**/*.#{DLEXT}
file "bindings/procedural/procedural.#{DLEXT}" => FileList["bindings/procedural/Makefile"] do |f|
  sh 'cd bindings/procedural/ && make clean && make'
end
CLEAN.include 'bindings/procedural/*.{o,so,dll}'


## ext/**/Makefile
file 'bindings/procedural/Makefile' => FileList['bindings/procedural/interface/procedural_wrap.cpp'] do
  chdir('bindings/procedural/') { ruby 'extconf.rb' }
end
CLEAN.include 'bindings/procedural/Makefile'

## make wrappers with swig.
file 'bindings/procedural/interface/procedural_wrap.cpp' do
  chdir('bindings/procedural/interface') { sh 'rake' }
end
CLEAN.include 'bindings/procedural/interface/procedural_wrap.{cpp,h,o}'

desc "Compile an ogre procedural library."
task :build => "lib/procedural.#{DLEXT}"

#
# Document
#
desc 'Create documents'
task :doc => ['bindings/procedural/interface/procedural_wrap.cpp'] do |f|
  sh "rdoc #{f.prerequisites.join(' ')}"
end

