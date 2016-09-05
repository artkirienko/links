# Pinger (тестовое задание)

Приложение принимает список **url**-ов. Приложение мониторит эти **url**. Если с **url** всё хорошо (коды: `2xx, 3xx`), то мониторится раз в минуту. Если плохо (остальные коды, нет ответа), то нужно об этом сообщить и начать мониторить этот **url** раз в 30 секунд; как только с ним опять всё стало хорошо, нужно об этом сообщить и мониторить раз в минуту.

Предполагается, что пользователь будет вводить **url** в формате: `http://url`, контроля ввода не реализовано.

Нельзя добавлять ссылку на само приложение, если оно запущено в режиме `development`

* Ruby version

  MRI Ruby 2.3.1 (используется *safe navigation* из `Ruby >=2.3.0`)

* System dependencies

  MRI Ruby 2.3.1, Redis, sqlite3

* Database creation

  ```
  bundle exec rails db:create db:migrate
  ```

* How to run app:

  Create database.

  ```
  bundle exec rails s
  bundle exec sidekiq -C config/sidekiq.yml
  ```

* Services (job queues, cache servers, search engines, etc.)

  Sidekiq

* How to run test suite:

  ```
  rails test
  ```
