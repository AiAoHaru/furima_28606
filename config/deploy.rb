# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
# lock 'Capistranoのバージョン'
lock '3.14.1'

# Capistranoのログの表示に利用する
# set :application, 'アプリケーション名'
set :application, 'furima_28606'

# どのリポジトリからアプリをpullするかを指定する
# set :repo_url,  'git@github.com:Githubのユーザー名/レポジトリ名.git'
set :repo_url,  'git@github.com:AiAoHaru/furima_28606.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
# set :rbenv_ruby, 'このアプリで使用しているrubyのバージョン' #カリキュラム通りに進めた場合、’2.6.5’ です
set :rbenv_ruby, '2.6.5'

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                                  # keys: ['~/.ssh/ご自身のキーペア名.pem'] 
                                  keys: ['~/.ssh/furimaapp28606.pem'] 

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end