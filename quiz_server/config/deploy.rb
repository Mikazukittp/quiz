# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'quiz'
set :repo_url, 'git@github.com:haijima/quiz.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/html/quiz-party'

# Default value for :scm is :git
set :scm, :git

set :rbenv_type, :user # :system or :user
set :rbenv_ruby, '2.2.1'
#set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
#set :rbenv_map_bins, %w{rake gem bundle ruby rails}
#set :rbenv_roles, :all # default value

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  Rake::Task["deploy:check:directories"].clear

  namespace :check do
    desc '(overwrite) Check shared and release directories exist'
    task :directories do
      on release_roles :all do
        execute :sudo, :mkdir, '-pv', shared_path, releases_path
        execute :sudo, :chown, '-R', "#{fetch(:user)}:#{fetch(:group)}", deploy_to
      end
    end
  end

  task :finished, :build_bower do
    on release_roles :all do
      execute :sudo, 'mkdir /var/www/html/quiz-party/current/client/dist'
      execute :sudo, :chown, '-R', "deploy:admin-g", '/var/www/html/quiz-party/current/client/dist'
      execute :sudo, 'mkdir /var/www/html/quiz-party/current/client/.tmp'
      execute :sudo, :chown, '-R', "deploy:admin-g", '/var/www/html/quiz-party/current/client/.tmp'
      execute "cp /var/www/html/bower.json /var/www/html/quiz-party/current/client/bower.json"
      execute "cd /var/www/html/quiz-party/current/client; bower install"
      execute "cd /var/www/html/quiz-party/current/client; sudo npm install"
      execute "cp /var/www/html/quiz/client/deploy.sh /var/www/html/quiz-party/current/client/deploy.sh"
      execute "cd /var/www/html/quiz-party/current/client; sudo sh /var/www/html/quiz-party/current/client/deploy.sh"
      execute "htre"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

desc "テストタスクです"
task :test do
  on roles(:web) do
    execute "pwd"
  end
end
