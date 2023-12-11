# README
# テーブル設計

ランビション(RunVision)

## users テーブル

| Column                | Type     | Options     |
| ------------------    | ------   | ----------- |
| nickname              | string   | null: false |
| email                 | string   | null: false , unique: true |
| encrypted_password    | string   | null: false |


### Association
- has_many :events
- has_many :runnings




##  events  テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| event_name         | string    | null: false |
| target_distance    | integer   | null: false |
| period             | integer   | null: false |
| commit             | text      | null: false |
| user               | references| null: false , foreign_key: true |

### Association
なし※アクセスはBASIC認証をする




##  runnings  テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| user               | references| null: false , foreign_key: true |
| ran_distance       | integer   | null: false           |
| ran_location       | text      | null: false           |
| impression         | text      | null: false |
| date               | integer   | null: false |


### Association
- belongs_to :user
- has_many :comments





##   comments   テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| user               | references| null: false, foreign_key: true |
| running            | references| null: false, foreign_key: true |
| comment            | text      | null: false, foreign_key: true |
+----------------------------------------+

### Association
- belongs_to :user
- belongs_to :running









This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
