desc "execute artisan command on web container"
task :artisan do
  ARGV.shift; args = ARGV.join(' ')
  ossh! "docker-compose #{COMPOSE_YAMLS} run --rm web php artisan #{args}"
  exit
end

desc "execute composer command on web container"
task :composer do
  ARGV.shift; args = ARGV.join(' ')
  ossh! "docker-compose #{COMPOSE_YAMLS} run --rm web composer #{args}"
  exit
end

desc "execute phpunit command on web container"
task :test do
  ARGV.shift; args = ARGV.join(' ')
  ossh! "docker-compose #{COMPOSE_YAMLS} run --rm web phpunit #{args}"
  exit
end

desc "execute mysql command on web container"
task :mysql do
  ARGV.shift; args = ARGV.join(' ')
  ossh! "docker-compose #{COMPOSE_YAMLS} run --rm web mysql #{args}"
  exit
end

desc "execute npm command on web container"
task :npm do
  ARGV.shift; args = ARGV.join(' ')
  ossh! "docker-compose #{COMPOSE_YAMLS} run --rm web npm #{args}"
  exit
end

desc "execute npm run dev command on web container"
task :assets do
  ARGV.shift; args = ARGV.join(' ')
  ossh! "docker-compose #{COMPOSE_YAMLS} run --rm web npm run dev #{args}"
  exit
end

namespace :assets do
  desc "execute npm run watch command on web container"
  task :watch do
    ARGV.shift; args = ARGV.join(' ')
    ossh! "docker-compose #{COMPOSE_YAMLS} run --rm web npm run watch #{args}"
    exit
  end
end
