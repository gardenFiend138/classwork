require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end

end


class Question
  attr_accessor :author_id, :title, :body
  attr_reader :id
  class << self # enter the singleton scope
    def all
      data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
      data.map { |datum| Question.new(datum) }
    end

    def find_by_author_id(author_id)
      question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
      *
      FROM
      questions
      WHERE
      author_id = ?

      SQL

      return nil if question.empty?

      question.map { |quest| Question.new(quest) }
    end

    def find_by_question_id(question_id)
      question = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
      *
      FROM
      questions
      WHERE
      question_id = ?

      SQL

      return nil if question.empty?

      question.map { |quest| Question.new(quest) }
    end

  end # exit singleton scope

  def initialize(options)
    @id = options['id']
    @author_id = options['author_id']
    @title = options['title']
    @body = options['body']
  end

  # finish this up after user class
  def author
    # data = QuestionsDatabase.instance.execute("SELECT fname, lname FROM questions")
    User.find_by_user_id(@author_id)

  end


  def replies
    data = QuestionsDatabase.instance.execute("SELECT fname, lname FROM questions")

  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
      INSERT INTO
        questions (title, body, author_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, author_id = ?
      WHERE
        id = ?
    SQL
    true
  end


end

class User

  class << self # enter the singleton scope
    def all
      data = QuestionsDatabase.instance.execute("SELECT * FROM users")
      data.map { |datum| User.new(datum) }
    end

    def find_by_user_id(user_id)
      user = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
      *
      FROM
      users
      WHERE
      id = ?

      SQL

      return nil if user.empty?
      User.new(user.first)

    end

    def find_by_name(fname, lname)
      user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
      *
      FROM
      users
      WHERE
      fname = ?, lname = ?

      SQL

      return nil if user.empty?
      User.new(user.first)
    end
  end # exit singleton scope

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end
end

class Reply
  attr_accessor :user_id, :body, :parent_reply_id, :question_id
  attr_reader :id
  class << self # enter the singleton scope
    def all
      data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
      data.map { |datum| Reply.new(datum) }
    end

    def find_by_user_id(user_id)
      reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
      *
      FROM
      replies
      WHERE
      user_id = ?

      SQL

      return nil if reply.empty?

      reply.map { |rep| Reply.new(rep) }
    end

    def find_by_question_id(question_id)
      reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
      *
      FROM
      replies
      WHERE
      question_id = ?

      SQL

      return nil if reply.empty?

      reply.map { |rep| Reply.new(rep) }
    end

    def find_by_id(id)
      reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
      *
      FROM
      replies
      WHERE
      id = ?

      SQL

      return nil if reply.empty?

      reply.map { |rep| Reply.new(rep) }
    end

    def find_by_parent_id(parent_id)
      reply = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
      SELECT
      *
      FROM
      replies
      WHERE
      parent_id = ?

      SQL

      return nil if reply.empty?

      reply.map { |rep| Reply.new(rep) }
    end
  end # exit Singleton /   scope

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @parent_reply_id = options['parent_reply_id']
    @body = options['body']
    @question_id = options['question_id']
  end

  def author
    User.find_by_user_id(@user_id)
  end

  def question
    Question.find_by_question_id(@question_id)
  end

  def parent_reply
    Reply.find_by_parent_id(@parent_id)
  end

  def child_replies
    Reply.find_by_parent_id(@id)
  end
end

class QuestionFollow
  class << self # enter singleton scope

    def follower_for_question_id(question_id)

      users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.fname, users.lname
      FROM
      question_follows
      JOIN
      questions ON question_follows.question_id = questions.id
      JOIN
      users ON question_follows.user_id = users.id
      WHERE
      question_follows.question_id = ?
      -- AND
      -- question_follows.user_id = users.id

      SQL
      p users
      return nil if users.empty?

      users.map { |user| User.new(user) }
    end


  end # exit singleton scope

end
