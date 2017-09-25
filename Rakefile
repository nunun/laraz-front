require 'tmpdir'
require 'shellwords'
require 'rbconfig'
require 'yaml'
ARGV.delete("--")
Dir.glob('**/tasks.rake').each {|r| load r }

COMPOSE_YAMLS = "-f docker-compose.yml"    unless defined? COMPOSE_YAMLS
UP_OPTIONS    = "--build --remove-orphans" unless defined? UP_OPTIONS

task :default do
  system('rake -sT')
end

desc "up debug compose"
task :up do
  ossh "docker-compose #{COMPOSE_YAMLS} down",
       "docker-compose #{COMPOSE_YAMLS} #{ARGV.join(' ')} #{UP_OPTIONS}"
end

desc "down debug compose"
task :down do
  ossh "docker-compose #{COMPOSE_YAMLS} down"
end

desc "build compose images"
task :build do
  ossh "docker-compose #{COMPOSE_YAMLS} build"
end

desc "pull compose images"
task :pull do
  images = get_images("docker-compose.*")
  if images.size > 0
    puts "pulling images ... " + images.join(", ")
    ossh *(images.map {|i| "docker pull #{i}" })
  else
    puts "no images to pull."
  end
end

###############################################################################
###############################################################################
###############################################################################

def ossh(*commands)
  execute_ossh(commands, 0)
end

def ossh!(*commands)
  execute_ossh(commands, 1)
end

def ossh?(command)
  return execute_ossh([command], 2)
end

def execute_ossh(commands, method)
  result = true
  case os = RbConfig::CONFIG['host_os']
  when /mswin|cygwin/
    case method
    when 0
      commands.push "@%WINDIR%\\SYSTEM32\\TIMEOUT /T 10"
    when 1
      commands.push "@echo."
      commands.push "@SET /p Dummy=Hit Enter to continue...."
    when 2
      commands.push "@if not \"%ERRORLEVEL%\" == \"0\" ("
      commands.push "    @%WINDIR%\\SYSTEM32\\TIMEOUT /T 10"
      commands.push "    @exit 1"
      commands.push ")"
    end
    bat = File.join(Dir.tmpdir, 'rake_osdo.bat')
    File.write bat, commands.join("\n")
    result = true
    case os
    when "cygwin"
      b = "#{bat.to_ospath.shellescape}"
      w = (method != 0)? "-w" : ""
      sh "chmod 755 #{b}", verbose: false
      sh "cygstart #{w} #{b}", verbose: false do |ok,status| result &= ok end
    else
      sh "#{bat}" do |ok,status| reslt &= ok end
    end
  else
    commands.each do |c|
      sh c do |ok,status| result &= ok end
    end
  end
  return result
end

def get_images(compose_glob_path)
   return Dir.glob(compose_glob_path)
          .map {|y| YAML.load_file(y) rescue {} }
          .delete_if {|h| !h.is_a?(Hash) || !h.has_key?("services") }
          .map {|v| v["services"]}.map {|v| v.values.map {|s|
            i = nil
            if s.has_key?("build")
              build = nil
              if s["build"].is_a?(String)
                build = s["build"]
              elsif s["build"].is_a?(Hash) && s["build"].has_key?("context")
                build = s["build"]["context"]
              else
                next
              end
              path = File.join(build, "Dockerfile")
              if File.exist?(path)
                File.open(path).each_line do |l|
                  if l =~ /^\s*[Ff][Rr][Oo][Mm]\s*(.*)$/
                    i = $1
                  end
                end
              end
            elsif s.has_key?("image")
              i = s["image"]
            end
            next i
          }}.flatten.compact.uniq
          .delete_if {|i| i =~ /^\${PUSH}/}
end

class String
  def to_ospath
    case os = RbConfig::CONFIG['host_os']
    when /cygwin/
      return `cygpath -w #{self}`.chomp
    end
    return self
  end
  def to_camel
    self.split("_").map{|w| w[0] = w[0].upcase; w}.join
  end
end
