require_relative "ruby-procedural/version"

module Ruby
  module Procedural
   def self.get_top_path
      File.dirname(File.dirname(File.expand_path(__FILE__)))
    end

    def self.get_deps_lib_path
      "#{get_top_path}/deps/lib"
    end

    def self.get_deps_inc_path
      "#{get_top_path()}/deps/include"
    end

    def self.get_inc_flags
      flags = "-I#{get_top_path}/deps/include/OgreProcedural/"
      return flags
    end

    def self.get_lib_flags
      flags = "-L#{get_top_path}/deps/lib -lOgreProcedural"
      return flags
    end
  end
end
